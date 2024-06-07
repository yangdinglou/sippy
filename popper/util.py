import clingo
import clingo.script
import signal
import argparse
import os
import logging
import operator
from time import perf_counter
from contextlib import contextmanager
from .core import Literal
from difflib import SequenceMatcher

clingo.script.enable_python()

TIMEOUT=3000
EVAL_TIMEOUT=0.01
MAX_LITERALS=40
MAX_SOLUTIONS=1
CLINGO_ARGS=''
MAX_RULES=2
MAX_VARS=9
MAX_BODY=12
MAX_EXAMPLES=10000

STOP_SCORE=0

global_circle = False
global_vcd = False

def parse_args():
    parser = argparse.ArgumentParser(description='Popper is an ILP system based on learning from failures')

    parser.add_argument('kbpath', help='Path to files to learn from')
    parser.add_argument('--quiet', '-q', default=False, action='store_true', help='Hide information during learning')
    parser.add_argument('--debug', default=False, action='store_true', help='Print debugging information to stderr')
    parser.add_argument('--stats', default=False, action='store_true', help='Print statistics at end of execution')
    parser.add_argument('--timeout', type=float, default=TIMEOUT, help=f'Overall timeout in seconds (default: {TIMEOUT})')
    parser.add_argument('--eval-timeout', type=float, default=EVAL_TIMEOUT, help=f'Prolog evaluation timeout in seconds (default: {EVAL_TIMEOUT})')
    parser.add_argument('--max-literals', type=int, default=MAX_LITERALS, help=f'Maximum number of literals allowed in program (default: {MAX_LITERALS})')
    parser.add_argument('--max-body', type=int, default=MAX_BODY, help=f'Maximum number of body literals allowed in rule (default: {MAX_BODY})')
    parser.add_argument('--max-vars', type=int, default=MAX_VARS, help=f'Maximum number of variables allowed in rule (default: {MAX_VARS})')
    parser.add_argument('--max-rules', type=int, default=MAX_RULES, help=f'Maximum number of rules allowed in recursive program (default: {MAX_RULES})')
    parser.add_argument('--max-examples', type=int, default=MAX_EXAMPLES, help=f'Maximum number of examples per label (positive or negative) to learn from (default: {MAX_EXAMPLES})')
    parser.add_argument('--functional-test', default=False, action='store_true', help='Run functional test')
    parser.add_argument('--threshold', type=int, default=STOP_SCORE, help='SIPPY: Specified version (the input is the threshold score)')
    parser.add_argument('--circle', default=False, action='store_true', help='For learning the predicate with circle (only work with --threshold))')
    parser.add_argument('--vcd', default=False, action='store_true', help='Output VCDryad predicates')
    parser.add_argument('--bkcons', default=False, action='store_true', help='EXPERIMENTAL FEATURE: deduce background constraints from Datalog background')
    return parser.parse_args()

def timeout(settings, func, args=(), kwargs={}, timeout_duration=1):
    result = None
    class TimeoutError(Exception):
        pass

    def handler(signum, frame):
        raise TimeoutError()

    # set the timeout handler
    signal.signal(signal.SIGALRM, handler)
    signal.alarm(timeout_duration)
    try:
        result = func(*args, **kwargs)
    except TimeoutError as _exc:
        settings.logger.warn(f'TIMEOUT OF {int(settings.timeout)} SECONDS EXCEEDED')
        return result
    except AttributeError as moo:
        if '_SolveEventHandler' in str(moo):
            settings.logger.warn(f'TIMEOUT OF {int(settings.timeout)} SECONDS EXCEEDED')
            return result
        raise moo
    finally:
        signal.alarm(0)

    return result

def load_kbpath(kbpath):
    def fix_path(filename):
        full_filename = os.path.join(kbpath, filename)
        return full_filename.replace('\\', '\\\\') if os.name == 'nt' else full_filename
    return fix_path("bk.pl"), fix_path("exs.pl"), fix_path("bias.pl")

class Stats:
    def __init__(self, info = False, debug = False):
        self.exec_start = perf_counter()
        self.total_programs = 0
        self.durations = {}

    def total_exec_time(self):
        return perf_counter() - self.exec_start

    def show(self):
        message = f'Num. programs: {self.total_programs}\n'
        total_op_time = sum(summary.total for summary in self.duration_summary())

        for summary in self.duration_summary():
            percentage = int((summary.total/total_op_time)*100)
            message += f'{summary.operation}:\n\tCalled: {summary.called} times \t ' + \
                       f'Total: {summary.total:0.2f} \t Mean: {summary.mean:0.3f} \t ' + \
                       f'Max: {summary.maximum:0.3f} \t Percentage: {percentage}%\n'
        message += f'Total operation time: {total_op_time:0.2f}s\n'
        message += f'Total execution time: {self.total_exec_time():0.2f}s'
        print(message)

    def duration_summary(self):
        summary = []
        stats = sorted(self.durations.items(), key = lambda x: sum(x[1]), reverse=True)
        for operation, durations in stats:
            called = len(durations)
            total = sum(durations)
            mean = sum(durations)/len(durations)
            maximum = max(durations)
            summary.append(DurationSummary(operation.title(), called, total, mean, maximum))
        return summary

    @contextmanager
    def duration(self, operation):
        start = perf_counter()
        try:
            yield
        finally:
            end = perf_counter()
            duration = end - start

            if operation not in self.durations:
                self.durations[operation] = [duration]
            else:
                self.durations[operation].append(duration)

def format_prog(prog):
    return '\n'.join(format_rule(order_rule(rule)) for rule in prog)

def format_literal(literal):
    args = ','.join(literal.arguments)
    return f'{literal.predicate}({args})'

def format_literal2(literal):
    if len(literal.arguments) == 2:
        return (f'{literal.predicate}^({literal.arguments[0].lower()})', {f'subst({literal.arguments[1]})': f'keys^({literal.arguments[0].lower()})'}, None)
    elif len(literal.arguments) == 3:
        return (f'{literal.predicate}^({literal.arguments[0].lower()})', {f'subst({literal.arguments[2]})': f'keys^({literal.arguments[0].lower()})'}, (f'{literal.arguments[0]}',f'{literal.arguments[1]}'))

def format_rule(rule):
    head, body = rule
    head_str = ''
    if head:
        head_str = format_literal(head)
    body_str = ','.join(format_literal(literal) for literal in body)
    cut = '' if global_circle else ', !'
    return f'{head_str}:- {body_str}{cut}.'

def from_domain_to_number(str):
    strlist = ['value','key','next','left','right', 'back', 'prev', 'child']
    nearest = max(strlist, key=lambda x: SequenceMatcher(None, x, str).ratio())

    if nearest in ['value','key']:
        return 0
    elif nearest in ['next', 'left']:
        return 1
    elif nearest in ['right','child']:
        return 2
    else:
        return 3

def from_domain_to_type(str):
    strlist = ['value','key','next','left','right', 'back', 'prev', 'child']
    nearest = max(strlist, key=lambda x: SequenceMatcher(None, x, str).ratio())
    if nearest in ['value','key']:
        return 'int'
    elif nearest in ['next', 'left', 'right', 'back', 'prev', 'child']:
        return 'loc'

def format_ptrs(inptr, ptrs):
    ptrs = dict(sorted(ptrs.items(), key=lambda item: from_domain_to_number(item[0])))
    cnt = 0
    for i in ptrs:
        yield f'{inptr} + {cnt} :-> {ptrs[i]}'
        cnt += 1
    yield f'[{inptr}, {cnt}]'
  
    
def format_ptrs2(inptr, ptrs):
    ptrs = list(map(lambda x: f'{from_domain_to_type(x)} {x}: {ptrs[x].lower()}', ptrs))
    # cnt = 0
    # for i in ptrs:
    #     yield f'{inptr} + {cnt} :-> {ptrs[i]}'
    #     cnt += 1
    yield f'({inptr.lower()} |-> {"; ".join(ptrs)})'

def format_pure(pure):
    if pure.predicate == 'empty':
        return f'{pure.arguments[0]}==[]'
    elif pure.predicate == 'nil':
        return f'{pure.arguments[0]}==[]'
    elif pure.predicate == 'insert':
        return f'{pure.arguments[2]}=={pure.arguments[0]} + [{pure.arguments[1]}]'
    elif pure.predicate == 'cons':
        return f'{pure.arguments[2]}=={pure.arguments[0]} + [{pure.arguments[1]}]'
    elif pure.predicate == 'ord_union':
        return f'{pure.arguments[2]}=={pure.arguments[0]} + {pure.arguments[1]}'
    elif pure.predicate == 'append':
        return f'{pure.arguments[2]}=={pure.arguments[0]} + {pure.arguments[1]}'
    elif pure.predicate == 'min_list':
        return f'{pure.arguments[1]}==lower({pure.arguments[0]})'
    elif pure.predicate == 'max_list':
        return f'{pure.arguments[1]}==upper({pure.arguments[0]})'
    elif pure.predicate == 'gt_set':
        return f'{pure.arguments[0]} >= upper({pure.arguments[1]})'
    elif pure.predicate == 'lt_set':
        return f'{pure.arguments[0]} <= lower({pure.arguments[1]})'
    elif pure.predicate == 'gt_list':
        return f'{pure.arguments[0]} >= upper({pure.arguments[1]})'
    elif pure.predicate == 'lt_list':
        return f'{pure.arguments[0]} <= lower({pure.arguments[1]})'
    elif pure.predicate == 'diff_lessthanone':
        return f'{pure.arguments[0]}  <= {pure.arguments[1]} + 1 && {pure.arguments[1]}  <= {pure.arguments[0]} + 1'
    elif pure.predicate == 'my_succ':
        return f'{pure.arguments[1]}=={pure.arguments[0]} + 1'
    elif pure.predicate == 'my_prev':
        return f'{pure.arguments[0]}=={pure.arguments[1]} + 1'
    elif pure.predicate == 'maxnum':
        return f'{pure.arguments[2]}==({pure.arguments[0]} <= {pure.arguments[1]} ? {pure.arguments[1]} : {pure.arguments[0]})'
    elif pure.predicate == 'zero' or pure.predicate == 'nullptr':
        return f'{pure.arguments[0]}==0'
    elif pure.predicate == 'same_ptr':
        return f'{pure.arguments[0]}=={pure.arguments[1]}'
    elif pure.predicate == 'anypointer' or pure.predicate == 'anynumber':
        return None
    else:
        raise ValueError(f'Unknown pure predicate {pure.predicate}')


def format_pure2(pure):

    if pure.predicate == 'gt_set':
        return f'({pure.arguments[0].lower()} gt-set subst({pure.arguments[1]}))'
    elif pure.predicate == 'lt_set':
        return f'({pure.arguments[0].lower()} lt-set subst({pure.arguments[1]}))'
    elif pure.predicate == 'gt_list':
        return f'{pure.arguments[0]} >= upper({pure.arguments[1]})'
    elif pure.predicate == 'lt_list':
        return f'{pure.arguments[0]} <= lower({pure.arguments[1]})'
    elif pure.predicate == 'diff_lessthanone':
        return f'{pure.arguments[0]}  <= {pure.arguments[1]} + 1 && {pure.arguments[1]}  <= {pure.arguments[0]} + 1'
    elif pure.predicate == 'my_succ':
        return f'{pure.arguments[1]}=={pure.arguments[0]} + 1'
    elif pure.predicate == 'my_prev':
        return f'{pure.arguments[0]}=={pure.arguments[1]} + 1'
    elif pure.predicate == 'maxnum':
        return f'{pure.arguments[2]}==({pure.arguments[0]} <= {pure.arguments[1]} ? {pure.arguments[1]} : {pure.arguments[0]})'
    elif pure.predicate == 'zero' or pure.predicate == 'nullptr':
        return f'{pure.arguments[0]}==0'
    elif pure.predicate == 'same_ptr':
        return f'{pure.arguments[0]}=={pure.arguments[1]}'
    else:
        return None

def format_body(body, head):
    pred = None
    pure = []
    spatial = []
    tmp_pts = {}

    for literal in body:
        if (literal.predicate == 'nullptr') and (literal.arguments[0] == 'A'):
            pred = f'{literal.arguments[0]}==0'
        elif literal.predicate == 'same_ptr' and (literal.arguments[0] == 'A'):
            pred = f'{literal.arguments[0]}=={literal.arguments[1]}'
        elif literal.predicate in ['anypointer','anynumber','insert', 'empty','ord_union','min_list','max_list','gt_list','lt_list','diff_lessthanone', 'my_succ', 'my_prev', 'maxnum', 'zero', 'nullptr', 'same_ptr', 'cons', 'append', 'gt_set', 'lt_set', 'nil']:
            tmppure = format_pure(literal)
            if tmppure != None:
                pure.append(tmppure)
        else:
            if literal.predicate in head:
                spatial.append(format_literal(literal))
            else:
                if f'{literal.arguments[0]}' in tmp_pts:
                    tmp_pts[f'{literal.arguments[0]}'][literal.predicate] = f'{literal.arguments[1]}'
                else:
                    tmp_pts[f'{literal.arguments[0]}'] = {literal.predicate:f'{literal.arguments[1]}'}

    for i in tmp_pts:
        tmp = format_ptrs(i, tmp_pts[i])
        spatial.extend(tmp)
    if len(spatial)== 0:
        spatial = ['emp']
    if len(pure) == 0:
        pure = ['true']
    return pred, ' && '.join(pure), ' ** '.join(spatial)

def format_body2(body, head):
    pred = None
    pure = []
    spatial = []
    tmp_pts = {}
    subst = {}
    second = None

    for literal in body:
        if (literal.predicate == 'nullptr') and (literal.arguments[0] == 'A'):
            pred = f'({literal.arguments[0].lower()} l= nil)'
        elif literal.predicate == 'same_ptr' and (literal.arguments[0] == 'A'):
            pred = f'{literal.arguments[0]}=={literal.arguments[1]}'
        elif literal.predicate in ['anypointer','anynumber','insert', 'empty','ord_union','min_list','max_list','gt_list','lt_list','diff_lessthanone', 'my_succ', 'my_prev', 'maxnum', 'zero', 'nullptr', 'same_ptr', 'cons', 'append', 'gt_set', 'lt_set', 'nil']:
            tmppure = format_pure2(literal)
            if tmppure != None:
                pure.append(tmppure)
        else:
            if literal.predicate in head:
                (pred_call, tmpsubst, tmpsecond) = format_literal2(literal)
                
                second = tmpsecond
                spatial.append(pred_call)
                subst.update(tmpsubst)
            else:
                if f'{literal.arguments[0]}' in tmp_pts:
                    tmp_pts[f'{literal.arguments[0]}'][literal.predicate] = f'{literal.arguments[1]}'
                else:
                    tmp_pts[f'{literal.arguments[0]}'] = {literal.predicate:f'{literal.arguments[1]}'}
    for i in tmp_pts:
        tmp = format_ptrs2(i, tmp_pts[i])
        spatial.extend(tmp)
    if len(spatial)== 0:
        spatial = ['emp']
    if len(pure) == 0:
        pure = ['true']
    assert len(subst) <=1
    if len(subst) == 1:
        for i in subst:
            pure = list(map(lambda x: x.replace(i, subst[i]), pure))
    if second != None:
            for pts in tmp_pts['A']:
                if tmp_pts['A'][pts] == 'B':
                    spatial.extend([f'({second[0].lower()} |-> secondary {pts}: {second[1].lower()})'])
    return pred, ' & '.join(pure), ' * '.join(spatial)

def to_sl_preds(rules, head_types):
    type_to_str = {'pointer':'loc', 'integer':'int', 'set':'interval', 'list':'list'}
    preds = dict()
    for rule in rules:
        head, body = rule
        head_str = head.predicate
        head_args = zip(head.arguments, head_types)
        head_str = f'{head_str}({",".join([f"{type_to_str[typ]} {arg}" for arg, typ in head_args])})'
        if head_str in preds:
            preds[head_str].append(body)
        else:
            preds[head_str] = [body]
    output = []
    heads = [head.split('(')[0] for head in preds]
    for head in preds:
        output.append(f'predicate {head} {{')
        tmppred = None
        tmppure = None
        tmpspatial = None
        for body in preds[head]:
            # headname = head.split('(')[0]
            # body_str = ','.join(format_literal(literal) for literal in body)
            pred, pure, spatial = format_body(body, heads)
            if pred != None:
                output.append(f'| {pred} => {{{pure} ; {spatial}}}')
                if tmppure == None:
                    tmppred = f"| not ({pred})"
                else:
                    output.append(f' not ({pred}) => {{{tmppure} ; {tmpspatial}}}')

            else:
                if tmppred == None:
                    tmppure = pure
                    tmpspatial = spatial
                else:
                    output.append(f'{tmppred} => {{{pure} ; {spatial}}}')
            # output.append(f'|  {pred} => {pure} ; {spatial}')
        output.append('}')
    return output

# define pred sorted(a):
# ((a l= nil) & emp) 
# ((a |-> loc next: c; int key: e) * sorted^(c) & (e lt-set keys^(c)))
def to_dryad_preds(rules, head_types):
    type_to_str = {'pointer':'loc', 'integer':'int', 'set':'interval', 'list':'list'}
    preds = dict()
    for rule in rules:
        head, body = rule
        head_str = head.predicate
        head_args = zip(head.arguments, head_types)
        head_str = f'{head_str}^(a):'
        if head_str in preds:
            preds[head_str].append(body)
        else:
            preds[head_str] = [body]
    output = []
    heads = [head.predicate]
    for head in preds:
        output.append(f'define pred {head}')
        tmppred = None
        tmppure = None
        tmpspatial = None
        for body in preds[head]:
            # headname = head.split('(')[0]
            # body_str = ','.join(format_literal(literal) for literal in body)
            pred, pure, spatial = format_body2(body, heads)
            if pred != None:
                output.append(f'({pred} & {spatial}) |')
                if tmppure == None:
                    tmppred = f"| not ({pred})"
                else:
                    output.append(f'({tmppure} & {tmpspatial})')

            else:
                if tmppred == None:
                    tmppure = pure
                    tmpspatial = spatial
                else:
                    output.append(f'({pure} & {spatial})')
            # output.append(f'|  {pred} => {pure} ; {spatial}')
        # output.append('}')
    return output

def print_prog_score(prog, score, cons, head_types):
    tp, fn, tn, fp, size = score
    precision = 'n/a'
    if (tp+fp) > 0:
        precision = f'{tp / (tp+fp):0.2f}'
    recall = 'n/a'
    if (tp+fn) > 0:
        recall = f'{tp / (tp+fn):0.2f}'
    print('*'*10 + ' SOLUTION ' + '*'*10)
    print(f'Precision:{precision} Recall:{recall} TP:{tp} FN:{fn} TN:{tn} FP:{fp} Size:{size}')
    print(format_prog(order_prog(prog)))
    
    out_pred = to_sl_preds(order_prog(prog), head_types) if not global_vcd else to_dryad_preds(order_prog(prog), head_types)
    print("Output predicates:")
    for pred in out_pred:
        print(pred)
    print()
    # print(cons)
    print('*'*30)

def prog_size(prog):
    return sum(rule_size(rule) for rule in prog)

def rule_size(rule):
    head, body = rule
    return 1 + len(body)

def reduce_prog(prog):
    def f(literal):
        return literal.predicate, literal.arguments
    reduced = {}
    for rule in prog:
        head, body = rule
        head = f(head)
        body = frozenset(f(literal) for literal in body)
        k = head, body
        reduced[k] = rule
    return reduced.values()

def order_prog(prog):
    return sorted(list(prog), key=lambda rule: (rule_is_recursive(rule), len(rule[1])))

def rule_is_recursive(rule):
    head, body = rule
    if not head:
        return False
    return any(head.predicate  == literal.predicate for literal in body if isinstance(literal, Literal))

def prog_is_recursive(prog):
    if len(prog) < 2:
        return False
    return any(rule_is_recursive(rule) for rule in prog)

def prog_has_invention(prog):
    if len(prog) < 2:
        return False
    return any(rule_is_invented(rule) for rule in prog)

def rule_is_invented(rule):
    head, body = rule
    if not head:
        return False
    return head.predicate.startswith('inv')

def order_rule(rule):
    head, body = rule
    ordered_body = []
    grounded_variables = set()

    if head:
        if head.inputs == []:
            return rule
        grounded_variables.update(head.inputs)

    body_literals = set(body)


    while body_literals:
        selected_literal = None
        for literal in body_literals:
            if len(literal.outputs) == len(literal.arguments):
                selected_literal = literal
                break

            if not literal.inputs.issubset(grounded_variables):
                continue

            if head and literal.predicate != head.predicate:
                # find the first ground non-recursive body literal and stop
                selected_literal = literal
                break
            elif selected_literal == None:
                # otherwise use the recursive body literal
                selected_literal = literal

        if selected_literal == None:
            tmpstr = ','.join(format_literal(literal) for literal in body_literals)
            message = f'{tmpstr} in clause {format_rule(rule)} could not be grounded'
            raise ValueError(message)

        ordered_body.append(selected_literal)
        grounded_variables = grounded_variables.union(selected_literal.outputs)
        body_literals = body_literals.difference({selected_literal})

    return head, tuple(ordered_body)

class DurationSummary:
    def __init__(self, operation, called, total, mean, maximum):
        self.operation = operation
        self.called = called
        self.total = total
        self.mean = mean
        self.maximum = maximum

def flatten(xs):
    return [item for sublist in xs for item in sublist]

class Settings:
    def __init__(self, cmd_line=False, info=True, debug=False, show_stats=False, bkcons=False, max_literals=MAX_LITERALS, timeout=TIMEOUT, quiet=False, eval_timeout=EVAL_TIMEOUT, max_examples=MAX_EXAMPLES, max_body=MAX_BODY, max_rules=MAX_RULES, max_vars=MAX_VARS, functional_test=False, kbpath=False, ex_file=False, bk_file=False, bias_file=False, threshold = STOP_SCORE, circle = False, vcd = False):

        if cmd_line:
            args = parse_args()
            self.bk_file, self.ex_file, self.bias_file = load_kbpath(args.kbpath)
            quiet = args.quiet
            debug = args.debug
            show_stats = args.stats
            bkcons = args.bkcons
            max_literals = args.max_literals
            timeout = args.timeout
            eval_timeout = args.eval_timeout
            max_examples = args.max_examples
            max_body = args.max_body
            max_vars = args.max_vars
            max_rules = args.max_rules
            functional_test = args.functional_test
            threshold = args.threshold
            circle = args.circle
            global global_circle
            global_circle = circle
            vcd = args.vcd
            global global_vcd
            global_vcd = vcd
        else:
            if kbpath:
                self.bk_file, self.ex_file, self.bias_file = load_kbpath(kbpath)
            else:
                self.ex_file = ex_file
                self.bk_file = bk_file
                self.bias_file = bias_file
        self.logger = logging.getLogger("popper")

        if quiet:
            pass
        elif debug:
            log_level = logging.DEBUG
            logging.basicConfig(filename='example.log', filemode='w', format='%(asctime)s %(message)s', level=log_level, datefmt='%H:%M:%S')
        elif info:
            log_level = logging.INFO
            logging.basicConfig(format='%(asctime)s %(message)s', level=log_level, datefmt='%H:%M:%S')

        self.info = info
        self.debug = debug
        self.stats = Stats(info=info, debug=debug)
        self.stats.logger = self.logger
        self.show_stats = show_stats
        self.bkcons = bkcons
        self.max_literals = max_literals
        self.functional_test = functional_test
        self.threshold = threshold
        self.circle = circle
        self.vcd = vcd
        self.timeout = timeout
        self.eval_timeout = eval_timeout
        self.max_examples = max_examples
        self.max_body = max_body
        self.max_vars = max_vars
        self.max_rules = max_rules

        self.solution = None
        self.best_prog_score = None
        self.best_cons = None

        solver = clingo.Control(['-Wnone'])
        with open(self.bias_file) as f:
            solver.add('bias', [], f.read())
        solver.add('bias', [], """
            #defined body_literal/4.
            #defined clause/1.
            #defined clause_var/2.
            #defined var_type/3.
            #defined body_size/2.
            #defined recursive/0.
            #defined var_in_literal/4.
        """)
        solver.ground([('bias', [])])


        self.max_rules = None
        for x in solver.symbolic_atoms.by_signature('max_clauses', arity=1):
            self.max_rules = x.symbol.arguments[0].number

        self.recursion_enabled = False
        for x in solver.symbolic_atoms.by_signature('enable_recursion', arity=0):
            self.recursion_enabled = True

        self.pi_enabled = False
        for x in solver.symbolic_atoms.by_signature('enable_pi', arity=0):
            self.pi_enabled = True

        if self.max_rules == None:
            if self.recursion_enabled or self.pi_enabled:
                self.max_rules = max_rules
            else:
                self.max_rules = 1

        # for SL predicate learning
        if self.pi_enabled:
            self.max_body = 7
            self.max_vars = 7

        for x in solver.symbolic_atoms.by_signature('max_body', arity=1):
            self.max_body = x.symbol.arguments[0].number

        for x in solver.symbolic_atoms.by_signature('max_vars', arity=1):
            self.max_vars = x.symbol.arguments[0].number

        self.logger.debug(f'Max rules: {self.max_rules}')
        self.logger.debug(f'Max vars: {self.max_vars}')
        self.logger.debug(f'Max body: {self.max_body}')

    def print_incomplete_solution(self, prog, tp, fn, size):
        self.logger.info('*'*20)
        self.logger.info('New best hypothesis:')
        self.logger.info(f'tp:{tp} fn:{fn} size:{size}')
        for rule in order_prog(prog):
            self.logger.info(format_rule(order_rule(rule)))
        self.logger.info('*'*20)
