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
inner_pointer(pointto, pointer).
inner_pointer(next2, pointer).
input_pointer(value, integer).
input_pointer(next1, pointer).

type(p,(pointer,)).

type(nullptr,(pointer,)).
type(anynumber,(integer,)).

direction(p,(in,)).
direction(nullptr,(in,)).
direction(anynumber,(in,)).

:- not invented(_, 1).
direction(inv1,(in,)).

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

