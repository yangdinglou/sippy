% f(A,B):-nullptr(A),empty(B).
% f(A,B):-min_list(B,D),value(A,D),f(E,C),pointer(A,E),insert(C,D,B).
%  python popper.py ./examples/predicate-infer/srtl2/ --info --eval-timeout=10 --stats

max_vars(5).
max_body(5).
max_clauses(2).
enable_recursion.

head_pred(f,2).
body_pred(nullptr,1).
% body_pred(plus,3).
body_pred(delete,3).
body_pred(min_list,2).
body_pred(zero,1).
% body_pred(one,1).
body_pred(empty,1).
body_pred(value,2).
body_pred(pointer,2).
body_pred(insert,3).


type(f,(element,list)).
type(nullptr,(element,)).
% type(plus,(integer,integer,integer)).
type(delete,(list,integer,list)).
type(min_list,(list,integer)).
type(empty,(list,)).
% type(zero,(integer,)).
% type(one,(integer,)).
type(value,(element,integer)).
type(pointer,(element,element)).
type(insert,(list,integer,list)).

direction(f,(in,out)).
direction(nullptr,(out,)).
direction(delete,(in,in,out)).
direction(min_list,(in,in)).
direction(empty,(out,)).
% direction(zero,(out,)).
% direction(one,(out,)).
direction(value,(out,out)).
direction(pointer,(out,out)).
direction(insert,(in,in,out)).

% :-
%     body_size(0,1).

% :-
% 	body_literal(Rule1,q,_,_),
% 	body_literal(Rule2,q,_,_),
% 	Rule1 != Rule2.


:-
	not body_literal(0,nullptr,_,_).

:-
	#count{P,A,Vars : body_literal(0,P,A,Vars)} > 3.
:-
    not clause(1).

% :-
%     #count{A,Vars : body_literal(1,q,A,Vars)} != 1.
:-
    head_literal(1, f, 2, (Var,_)),
    not body_literal(1, pointer, _, (Var,_)).
:-
    #count{A, Vars: body_literal(1, pointer, A, Vars)} != 1.
:-
    body_literal(T, pointer, _, (A, B1)),
    body_literal(T, pointer, _, (A, B2)),
    B1 != B2.

:-
	head_literal(1, f, 2, (Var,_)),
    not body_literal(1, value, _, (Var,_)).
:-
    #count{A, Vars: body_literal(1, value, A, Vars)} != 1.
:-
    body_literal(T, value, _, (A, B1)),
    body_literal(T, value, _, (A, B2)),
    B1 != B2.
