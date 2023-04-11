% p(A):-nullptr(A).
% p(A):-inv1(B),child(A,B),next(A,C),p(C).
% inv1(A):-nullptr(A).
% inv1(A):-next(A,C),inv1(C).

max_vars(3).
max_body(4).
max_clauses(4).
enable_recursion.

enable_pi.


head_pred(p,1).
body_pred(child,2).
% body_pred(pointer,2).
body_pred(next,2).
% body_pred(right,2).
% body_pred(height,2).
body_pred(nullptr,1).

type(p,(element,)).
type(child,(element,element)).
% type(pointer,(element,element)).
type(next,(element,element)).
% type(right,(element,element)).
% type(height,(element,integer)).
type(nullptr,(element,)).

% direction(inv1, (out,)).
direction(p,(in,)).
direction(child,(in,out)).
% direction(pointer,(in,out)).
direction(next,(out,out)).
% direction(right,(in,out)).
% direction(height,(in, out)).
direction(nullptr,(out,)).

:-
	#count{A,Vars : body_literal(0,nullptr,A,Vars)} = 0.
:-
	#count{A,Vars : body_literal(2,nullptr,A,Vars)} = 0.

:-
    #count{P,Vars : body_literal(0,P,_,Vars)} > 2.

:-
    #count{P,Vars : body_literal(2,P,_,Vars)} > 2.
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
	head_literal(1, p, _,(Var,)),
	not body_literal(1,next,_,(Var,_)).

:-
	head_literal(1, p, _,(Var,)),
	not body_literal(1,child,_,(Var,_)).


:-
    body_literal(T, child, _, (A, B1)),
    body_literal(T, child, _, (A, B2)),
	B1 != B2.

:-
    body_literal(T, next, _, (A, B1)),
    body_literal(T, next, _, (A, B2)),
	B1 != B2.