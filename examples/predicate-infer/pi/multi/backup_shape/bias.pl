% p(This, Sz) :- nullptr(This), zero(Sz).

% p(This) :- next(This, Nxt), p(Nxt), child(This, tail), q(tail).

% q(This) :- nullptr(This), zero(Sz).

% q(This) :- next(This, Nxt),value(This, n), nullptr(n), q(Nxt).

%learned:
% BEST PROG 13:
% p(A):-nullptr(A).
% p(A):-inv1(B),child(A,B),next(A,C),p(C).
% inv1(A):-nullptr(A).
% inv1(A):-value(A,B),is_value(B),next(A,C),inv1(C).
% Precision:1.00, Recall:1.00, TP:10, FN:0, TN:5, FP:0
max_vars(4).
max_body(4).
max_clauses(4).
enable_pi.
enable_recursion.


head_pred(p,1).
body_pred(next,2).
body_pred(child,2).
body_pred(value,2).
body_pred(nullptr,1).
% body_pred(node,1).
body_pred(is_value,1).

type(p,(element,)).
type(next,(element,element)).
type(child,(element,element)).
type(value,(element, int)).
type(nullptr,(element,)).
% type(node,(element,)).
type(is_value,(int,)).

direction(p,(in,)).
direction(next,(in,out)).
direction(child,(in,out)).
direction(value,(out,out)).
direction(nullptr,(out,)).
% direction(node,(in,)).
direction(is_value,(in,)).


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
	#count{P,A,Vars : body_literal(P,p,A,Vars)} = 0.
:-
	#count{A,Vars : body_literal(1,next,A,Vars)} != 1.
:-
	#count{A,Vars : body_literal(1,child,A,Vars)} != 1.

:-
    head_literal(1,_,_,(Var1,)),
    not body_literal(1,next,_,(Var1,_)).
:-
    head_literal(1,_,_,(Var1,)),
    not body_literal(1,child,_,(Var1,_)).

:- 
	head_literal(2,P,_,_),
	body_literal(0,P,_,_).

:-
	#count{A,Vars : body_literal(3,next,A,Vars)} != 1.
:-
	#count{A,Vars : body_literal(3,value,A,Vars)} != 1.

:-
    head_literal(3,_,_,(Var1,)),
    not body_literal(3,next,_,(Var1,_)).
:-
    head_literal(3,_,_,(Var1,)),
    not body_literal(3,value,_,(Var1,_)).

:-
	#count{P,A,Vars : body_literal(P,child,A,Vars)} != 1.

:-
	#count{P,A,Vars : body_literal(P,next,A,Vars)} != 2.

:-
	#count{P,A,Vars : body_literal(P,value,A,Vars)} != 1.