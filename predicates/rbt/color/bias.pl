% rbt(X, Col, Bn) :- nullptr(X), black(Col), zero(Bn).
% rbt(X, Col, Bn) :- left(X, L), right(X, R), color(X, Col), inv1(L, R, Col, Bn).

% inv1(L, R, Col, Bn) :- red(Col), black(C), rbt(L, C, Bn), rbt(R, C, Bn).
% inv1(L, R, Col, Bn) :- black(Col), my_prev(Bn, Bnl), is(Bnl, Bnr), rbt(L, C1, Bnl), rbt(R, C2, Bnr), anycolor(C1), anycolor(C2).

max_vars(5).
max_body(5).
max_clauses(4).
max_pi_arity(4).
enable_recursion.
enable_pi.
not_ordering.

head_pred(rbt,2).
body_pred(nullptr,1).
body_pred(left,2).
body_pred(right,2).
body_pred(color,2).
body_pred(anycolor,1).
body_pred(black,1).
body_pred(red,1).

type(rbt,(pointer, color)).
type(nullptr,(pointer,)).
type(left,(pointer, pointer)).
type(right,(pointer, pointer)).
type(color,(pointer, color)).
type(anycolor,(color,)).
type(black,(color,)).
type(red,(color,)).

direction(rbt,(in, out)).
direction(nullptr,(out,)).
direction(left,(in, out)).
direction(right,(in, out)).
direction(color,(in, out)).
direction(anycolor,(in,)).
direction(black,(out,)).
direction(red,(out,)).

:-
    not clause(1).
:-
    not clause(2).
:-
    not clause(3).

:-
    head_literal(0,P,_,_),
    not head_literal(1,P,_,_).

:-
    head_literal(1,P,_,_),
    head_literal(2,P,_,_).

:-
    head_literal(2,P,_,_),
    not head_literal(3,P,_,_).


:-
    head_literal(1, rbt, 2, (Var,_)),
    not body_literal(1, left, _, (Var,_)).
:-
    #count{A, Vars: body_literal(1, left, A, Vars)} != 1.
:-
    body_literal(T, left, _, (A, B1)),
    body_literal(T, left, _, (A, B2)),
    B1 != B2.


:-
    head_literal(1, rbt, 2, (Var,_)),
    not body_literal(1, right, _, (Var,_)).
:-
    #count{A, Vars: body_literal(1, right, A, Vars)} != 1.
:-
    body_literal(T, right, _, (A, B1)),
    body_literal(T, right, _, (A, B2)),
    B1 != B2.


:-
    head_literal(1, rbt, 2, (Var,_)),
    not body_literal(1, color, _, (Var,_)).
:-
    #count{A, Vars: body_literal(1, color, A, Vars)} != 1.
:-
    body_literal(T, color, _, (A, B1)),
    body_literal(T, color, _, (A, B2)),
    B1 != B2.

:-
    #count{P,A,Vars : body_literal(0,P,A,Vars)} !=2.
:-
    #count{P,A,Vars : body_literal(1,P,A,Vars)} !=4.
:-
    #count{P,A,Vars : body_literal(2,P,A,Vars)} !=4.
:-
    #count{P,A,Vars : body_literal(3,P,A,Vars)} !=5.

:-
	#count{A,Vars : body_literal(0,nullptr,A,Vars)} == 0.

:-
	#count{A,Var : body_literal(0,nullptr,A,(Var,)), head_var(0, Var)} == 0.

% :-
%     #count{A,Vars : body_literal(2,rbt,A,Vars)} != 2.
% :-
%     #count{A,Vars : body_literal(3,rbt,A,Vars)} != 2.

:-
	#count{A,Vars : body_literal(2,left,A,Vars)} > 0.

:-
	#count{A,Vars : body_literal(2,right,A,Vars)} > 0.

:-
	#count{A,Vars : body_literal(3,left,A,Vars)} > 0.

:-
	#count{A,Vars : body_literal(3,right,A,Vars)} > 0.

:-
	#count{A,Vars : body_literal(1,nullptr,A,Vars)} > 0.

:-
	#count{A,Vars : body_literal(2,nullptr,A,Vars)} > 0.

:-
	#count{A,Vars : body_literal(3,nullptr,A,Vars)} > 0.