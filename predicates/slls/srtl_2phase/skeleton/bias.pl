% f(A,B):-nullptr(A),empty(B).
% f(A,B):-min_list(B,D),value(A,D),q(E,C),pointer(A,E),delete(B,D,C).
%  python popper.py ./examples/predicate-infer/srtl2/ --info --eval-timeout=10 --stats

max_vars(5).
max_body(5).
max_clauses(2).
enable_recursion.

head_pred(f,1).
body_pred(nullptr,1).
body_pred(empty,1).
body_pred(pointer,2).


type(f,(element,)).
type(nullptr,(element,)).
type(empty,(list,)).
type(pointer,(element,element)).

direction(f,(in,)).
direction(nullptr,(out,)).
direction(empty,(out,)).
direction(pointer,(out,out)).

% :-
%     body_size(0,1).




:-
	not body_literal(0,nullptr,_,_).
:-
    not clause(1).


:-
    head_literal(1, f, 1, (Var,)),
    not body_literal(1, pointer, _, (Var,_)).
:-
    #count{A, Vars: body_literal(1, pointer, A, Vars)} != 1.
:-
    body_literal(T, pointer, _, (A, B1)),
    body_literal(T, pointer, _, (A, B2)),
    B1 != B2.