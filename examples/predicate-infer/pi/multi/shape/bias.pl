% p(This, Sz) :- nullptr(This), zero(Sz).

% p(This, Sz) :- next(This, Nxt), p(Nxt, Sz1), child(This, tail), q(tail, Sz2), plus(sss).

% q(This, Sz) :- nullptr(This), zero(Sz).

% q(This, Sz) :- next(This, Nxt),value(This, n), is_value(n), q(Nxt, Sz1), succ(Sz, Sz1).

%learned:
% BEST PROG 10918:
% p(A):-nullptr(A).
% p(A):-next(A,C),child(A,B),inv1(B),p(C).
% inv1(A):-nullptr(A).
% inv1(A):-value(A,C),is_value(C),next(A,B),inv1(B).
% Precision:1.00, Recall:1.00, TP:10, FN:0, TN:5, FP:0
max_vars(6).
max_body(5).
max_clauses(4).
enable_pi.
enable_recursion.


head_pred(p,2).
body_pred(next,2).
body_pred(child,2).
% body_pred(node,1).
% body_pred(value,2).
body_pred(nullptr,1).
% body_pred(node,1).
% body_pred(is_value,1).
body_pred(succ,2).
body_pred(pred,2).
body_pred(plus,3).
body_pred(zero,1).

type(p,(element, int)).
type(next,(element,element)).
type(child,(element,element)).
% type(value,(element, v)).
type(nullptr,(element,)).
% type(node,(element,)).
% type(is_value,(v,)).
type(succ,(int,int)).
type(pred,(int,int)).
type(plus,(int,int,int)).
type(zero,(int,)).

direction(p,(in, in)).
direction(next,(in,out)).
direction(child,(in,out)).
% direction(value,(out,out)).
direction(nullptr,(out,)).
% direction(node,(in,)).
% direction(is_value,(in,)).
direction(succ,(in,out)).
direction(pred,(in,out)).
direction(plus,(in,out,in)).
direction(zero,(out,)).


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
	not head_literal(2,_,2,_).

:-
	#count{A,Vars : body_literal(1,p,A,Vars)} != 1.
:-
	#count{A,Vars : body_literal(1,next,A,Vars)} != 1.
:-
	#count{A,Vars : body_literal(1,child,A,Vars)} != 1.

:-
	#count{A,Vars : body_literal(1,plus,A,Vars)} != 1.




:-
    head_literal(1,_,_,(Var1,_)),
    not body_literal(1,next,_,(Var1,_)).
:-
    head_literal(1,_,_,(Var1,_)),
    not body_literal(1,child,_,(Var1,_)).

:- 
	head_literal(2,P,_,_),
	body_literal(0,P,_,_).

:- 
	head_literal(2,P,_,_),
	not body_literal(1,P,_,_).

:-
	#count{A,Vars : body_literal(3,next,A,Vars)} != 1.
% :-
% 	#count{A,Vars : body_literal(3,value,A,Vars)} != 1.

:-
    head_literal(3,_,_,(Var1,_)),
    not body_literal(3,next,_,(Var1,_)).
% :-
%     head_literal(3,_,_,(Var1,)),
%     not body_literal(3,value,_,(Var1,_)).

:-
	#count{P,A,Vars : body_literal(P,child,A,Vars)} != 1.
:-
	#count{P,A,Vars : body_literal(P,next,A,Vars)} != 2.
% :-
% 	#count{P,A,Vars : body_literal(P,value,A,Vars)} != 1.

:-
	#count{A,Vars : body_literal(0,nullptr,A,Vars)} = 0.

:-
	#count{A,Vars : body_literal(2,nullptr,A,Vars)} = 0.

:- 
	head_literal(3,P,_,_),
	not body_literal(3,P,_,_).