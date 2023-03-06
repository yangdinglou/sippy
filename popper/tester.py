import os
import time
import numpy as np
import pkg_resources
from pyswip import Prolog
from pyswip.prolog import PrologError
from contextlib import contextmanager
from . util import format_rule, order_rule, order_prog, prog_is_recursive, format_prog, format_literal, rule_is_recursive

import clingo
import clingo.script
import pkg_resources
from . core import Literal
from . generate import parse_model
from collections import defaultdict

class Tester():

    def query(self, query, key):
        result = next(self.prolog.query(query))[key]
        return set(result)

    def bool_query(self, query,):
        return len(list(self.prolog.query(query))) > 0

    def __init__(self, settings):
        self.settings = settings
        self.prolog = Prolog()

        bk_pl_path = self.settings.bk_file
        exs_pl_path = self.settings.ex_file
        test_pl_path = pkg_resources.resource_filename(__name__, "lp/test.pl")

        for x in [exs_pl_path, bk_pl_path, test_pl_path]:
            if os.name == 'nt': # if on Windows, SWI requires escaped directory separators
                x = x.replace('\\', '\\\\')
            self.prolog.consult(x)

        # load examples
        self.bool_query(f'load_examples')
        self.pos_index = self.query('findall(K,pos_index(K,Atom),Xs)', 'Xs')
        self.neg_index = self.query('findall(K,neg_index(K,Atom),Xs)', 'Xs')

        self.num_pos = len(self.pos_index)
        self.num_neg = len(self.neg_index)

        # weird
        self.settings.pos_index = self.pos_index
        self.settings.neg_index = self.neg_index

        self.pos_exs = []
        if self.settings.threshold != 0:
            self.pos_exs = list(self.prolog.query('findall(Atom, pos(Atom), X)'))[0]['X']

        if self.settings.recursion_enabled:
            self.prolog.assertz(f'timeout({self.settings.eval_timeout})')

    def test_prog(self, prog):
        if len(prog) == 1:
            return self.test_single_rule(prog)
        try:
            with self.using(prog):
                pos_covered = frozenset(self.query('pos_covered(Xs)', 'Xs'))
                inconsistent = False
                if len(self.neg_index) > 0:
                    inconsistent = len(list(self.prolog.query("inconsistent"))) > 0
        except PrologError as err:
            print('PROLOG ERROR',err)
            pos_covered = set()
            inconsistent = True

        return pos_covered, inconsistent

    def is_valid(self, prog):
        try:
            with self.using(prog):
                pos_covered = frozenset(self.query('pos_covered(Xs)', 'Xs'))
                return True
        except PrologError as err:
            return False
        
    def test_single_rule(self, prog):
        try:
            rule = list(prog)[0]
            head, _body = rule
            head, ordered_body = order_rule(rule)
            atom_str = format_literal(head)
            body_str = format_rule((None,ordered_body))[2:-1]
            q = f'findall(ID, (pos_index(ID,{atom_str}),({body_str}->  true)), Xs)'
            xs = next(self.prolog.query(q))
            pos_covered = frozenset(xs['Xs'])
            inconsistent = False
            q = f'neg_index(_,{atom_str}),{body_str},!'
            if len(self.neg_index) > 0:
                inconsistent = len(list(self.prolog.query(q))) > 0
        except PrologError as err:
            print('PROLOG ERROR',err)
        return pos_covered, inconsistent

    def is_inconsistent(self, prog):
        if len(self.neg_index) == 0:
            return False
        with self.using(prog):
            return len(list(self.prolog.query("inconsistent"))) > 0

    def is_complete(self, prog):
        with self.using(prog):
            pos_covered = frozenset(self.query('pos_covered(Xs)', 'Xs'))
            return len(pos_covered) == len(self.pos_index)

    def get_pos_covered(self, prog):
        with self.using(prog):
            pos_covered = frozenset(self.query('pos_covered(Xs)', 'Xs'))
            return pos_covered

    @contextmanager
    def using(self, prog):
        if self.settings.recursion_enabled:
            prog = order_prog(prog)
        current_clauses = set()
        try:
            for rule in prog:
                head, _body = rule
                x = format_rule(order_rule(rule))[:-1]
                self.prolog.assertz(x)
                current_clauses.add((head.predicate, head.arity))
            yield
        finally:
            for predicate, arity in current_clauses:
                args = ','.join(['_'] * arity)
                self.prolog.retractall(f'{predicate}({args})')

    def is_non_functional(self, prog):
        with self.using(prog):
            return self.bool_query('non_functional')

    def reduce_inconsistent(self, program):
        if len(program) < 3:
            return program
        for i in range(len(program)):
            subprog = program[:i] + program[i+1:]
            if not prog_is_recursive(subprog):
                continue
            with self.using(subprog):
                if self.is_inconsistent(subprog):
                    return self.reduce_inconsistent(subprog)
        return program

    def is_sat(self, prog):
        if len(prog) == 1:
            rule = list(prog)[0]
            head, _body = rule
            head, ordered_body = order_rule(rule)
            head = f'pos_index(_,{format_literal(head)})'
            x = format_rule((None,ordered_body))[2:-1]
            x = f'{head},{x},!'
            return self.bool_query(x)
        else:
            try:
                with self.using(prog):
                    return self.bool_query('sat')
            except PrologError as err:
                self.settings.logger.info('PROLOG ERROR in is_sat')
                for rule in prog:
                    self.settings.logger.info(format_rule(rule))
                # print('PROLOG ERROR',err)
                return False

    def is_body_sat(self, body):
        _, ordered_body = order_rule((None,body))
        body_str = ','.join(format_literal(literal) for literal in ordered_body)
        query = body_str + ',!'
        return self.bool_query(query)

    def check_redundant_literal(self, prog):
        for rule in prog:
            head, body = rule
            if head:
                c = f"[{','.join(('not_'+ format_literal(head),) + tuple(format_literal(lit) for lit in body))}]"
            else:
                c = f"[{','.join(tuple(format_literal(lit) for lit in body))}]"
            res = list(self.prolog.query(f'redundant_literal({c})'))
            if res:
                yield rule

    def has_redundant_literal(self, prog):
        for rule in prog:
            head, body = rule
            if head:
                c = f"[{','.join(('not_'+ format_literal(head),) + tuple(format_literal(lit) for lit in body))}]"
            else:
                c = f"[{','.join(tuple(format_literal(lit) for lit in body))}]"
            res = list(self.prolog.query(f'redundant_literal({c})'))
            if res:
                return True
        return False

    def has_redundant_rule_(self, prog):
        prog_ = []
        for head, body in prog:
            c = f"[{','.join(('not_'+ format_literal(head),) + tuple(format_literal(lit) for lit in body))}]"
            prog_.append(c)
        prog_ = f"[{','.join(prog_)}]"
        return len(list(self.prolog.query(f'redundant_clause({prog_})'))) > 0
        # return self.bool_query(f'redundant_clause({prog_})')

    def has_redundant_rule(self, prog):
        # AC: if the overhead of this call becomes too high, such as when learning programs with lots of clauses, we can improve it by not comparing already compared clauses

        base = []
        step = []
        for rule in prog:
            if rule_is_recursive(rule):
                step.append(rule)
            else:
                base.append(rule)
        if len(base) > 1 and self.has_redundant_rule_(base):
            return True
        if len(step) > 1 and self.has_redundant_rule_(step):
            return True
        return False

    # WE ASSUME THAT THERE IS A REUNDANT RULE
    def find_redundant_rule_(self, prog):
        prog_ = []
        for i, (head, body) in enumerate(prog):
            c = f"{i}-[{','.join(('not_'+ format_literal(head),) + tuple(format_literal(lit) for lit in body))}]"
            prog_.append(c)
        prog_ = f"[{','.join(prog_)}]"
        # print(prog_)
        q = f'find_redundant_rule({prog_},K1,K2)'
        res = list(self.prolog.query(q))
        k1 = res[0]['K1']
        k2 = res[0]['K2']
        return prog[k1], prog[k2]
        # return len(res) > 0

    def find_redundant_rules(self, prog):
        # AC: if the overhead of this call becomes too high, such as when learning programs with lots of clauses, we can improve it by not comparing already compared clauses
        base = []
        step = []
        for rule in prog:
            if rule_is_recursive(rule):
                step.append(rule)
            else:
                base.append(rule)
        if len(base) > 1 and self.has_redundant_rule(base):
            return self.find_redundant_rule_(base)
        if len(step) > 1 and self.has_redundant_rule(step):
            return self.find_redundant_rule_(step)
        return None


    def get_pos_score(self, rules):
        with self.using(rules):
            score = 0
            for x in self.pos_exs:
                new_query = "eval_head(" + x + ",X)"
                score += list(self.prolog.query(new_query))[0]['X']
            return score