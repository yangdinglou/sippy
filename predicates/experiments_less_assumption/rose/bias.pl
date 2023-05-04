% p(This) :- nullptr(This).
% p(This) :- next(This, Nxt), inv1(Nxt).

% inv1(This) :- nullptr(This).
% inv1(This) :- value(This, r), p(r), next(This, Nxt), inv1(Nxt).

max_vars(3).
max_body(4).
max_clauses(4).
enable_recursion.
enable_pi.

head_pred(p,1).

body_pred(nullptr,1).
body_pred(anynumber,1).
body_pred(pointto,2).
body_pred(value,2).
body_pred(next1,2).
body_pred(next2,2).

type(p,(pointer,)).

type(nullptr,(pointer,)).
type(anynumber,(integer,)).
type(pointto,(pointer,pointer)).
type(value,(pointer,integer)).
type(next1,(pointer,pointer)).
type(next2,(pointer,pointer)).

direction(p,(in,)).
direction(nullptr,(out,)).
direction(anynumber,(out,)).
direction(pointto,(out,out)).
direction(value,(in,out)).
direction(next1,(in,out)).
direction(next2,(out,out)).

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
    body_literal(T, anynumber, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.

:-
	#count{A,Vars : body_literal(0,nullptr,A,Vars)} == 0.

:-
	#count{A,Vars : body_literal(2,nullptr,A,Vars)} == 0.

:-
	#count{A,Var : body_literal(0,nullptr,A,(Var,)), head_var(0, Var)} == 0.

:-
    body_literal(T, nullptr, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.

:-
    head_literal(1, p, 1, (Var,)),
    not body_literal(1, next1, _, (Var,_)).
% :-
%     #count{A, Vars: body_literal(1, next1, A, Vars)} != 1.

:-
    head_literal(1, p, 1, (Var,)),
    not body_literal(1, value, _, (Var,_)).
% :-
%     #count{A, Vars: body_literal(1, value, A, Vars)} != 1.

:-
    body_literal(T, pointto, _, (A, B1)),
    body_literal(T, pointto, _, (A, B2)),
    B1 != B2.

:-
    body_literal(T, value, _, (A, B1)),
    body_literal(T, value, _, (A, B2)),
    B1 != B2.

:-
    body_literal(T, next1, _, (A, B1)),
    body_literal(T, next1, _, (A, B2)),
    B1 != B2.

:-
    body_literal(T, next2, _, (A, B1)),
    body_literal(T, next2, _, (A, B2)),
    B1 != B2.
