
def pts_basic(names, types):
    basic_def = [f'body_pred({name}, 2).' for name in names]
    basic_direct = [f'direction({name}, (in, out)).' for name in names]
    basic_type = [f'type({name}, (pointer, {types[name]})).' for name in names]
    return basic_def, basic_direct, basic_type
def constraints_mainpts(pred_name, arity, names):
    str = ','.join(['_']* (arity-1))
    
    return [f'''
:-
    head_literal(1, {pred_name}, {arity}, (Var,{str})),
    not body_literal(1, {name}, _, (Var,_)).
:-
    #count{{A, Vars: body_literal(1, {name}, A, Vars)}} != 1.
:-
    body_literal(T, {name}, _, (A, B1)),
    body_literal(T, {name}, _, (A, B2)),
    B1 != B2.
''' for name in names]




print(pts_basic(['p', 'q', 'r'], {'p': 'pointer', 'q': 'int', 'r': 'int'}))
for rule in constraints_mainpts('rbt', 3, ['left', 'right', 'color']):
    print(rule)