% rbt(X, Col) :- nullptr(X), black(Col).
% rbt(X, Col) :- left(X, L), right(X, R), color(X, Col), inv1(L, R, Col).

% inv1(L, R, Col) :- red(Col), black(C), rbt(L, C), rbt(R, C).
% inv1(L, R, Col) :- black(Col), rbt(L, C1), rbt(R, C2), anycolor(C1), anycolor(C2).

max_vars(5).
max_body(5).
max_clauses(4).
max_pi_arity(3).
enable_recursion.
enable_pi.

head_pred(rbt,2).
body_pred(nullptr,1).

input_pointer(left,pointer).
input_pointer(right,pointer).
input_pointer(color,c).

body_pred(anycolor,1).
body_pred(black,1).
body_pred(red,1).

type(rbt,(pointer, c)).
type(nullptr,(pointer,)).

type(anycolor,(c,)).
type(black,(c,)).
type(red,(c,)).

direction(rbt,(in, out)).
direction(nullptr,(in,)).

direction(anycolor,(in,)).
direction(black,(out,)).
direction(red,(out,)).

:-
    not invented(_,3).
direction(inv1,(in,in,in)).
% type(inv1,(pointer,pointer,c)).


:-
	#count{P,A,Vars : body_literal(0,P,A,Vars)} > 3.

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
    body_literal(T, anycolor, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.


:-
	#count{A,Vars : body_literal(0,nullptr,A,Vars)} == 0.

:-
	#count{A,Var : body_literal(0,nullptr,A,(Var,)), head_var(0, Var)} == 0.

% :-
%     body_literal(1, left, _, (_,Out)),
%     body_literal(1, inv1, _, Args),
%     not var_member(Out, Args).

% :-
%     body_literal(1, right, _, (_,Out)),
%     body_literal(1, inv1, _, Args),
%     not var_member(Out, Args).

% :-
%     body_literal(1, color, _, (_,Out)),
%     body_literal(1, inv1, _, Args),
%     not var_member(Out, Args).



% :-
% 	#count{A,Vars : body_literal(2,rbt,A,Vars)} != 2.

% :-
% 	#count{A,Vars : body_literal(3,rbt,A,Vars)} != 2.

func_head(rbt).
func_head(black).
func_head(red).
not_in(left,0).
not_in(right,0).
not_in(color,0).
not_in(nullptr,1).
not_in(left,2).
not_in(right,2).
not_in(color,2).
not_in(nullptr,2).
not_in(left,3).
not_in(right,3).
not_in(color,3).
not_in(nullptr,3).

:-
    body_literal(T, left, _, (A, B)),
    body_literal(T, right, _, (A, B)).

:- 
    head_literal(T, inv1, _ ,(A,_,_)),
    not body_literal(T, rbt, _, (A,_)).

:- 
    head_literal(T, inv1, _ ,_),
    body_literal(T, inv1, _, _).

:- 
    head_literal(T, rbt, _ ,_),
    body_literal(T, rbt, _, _).

equal_var(C, A, B):- head_literal(C, inv1, _ ,(A,B,_)).
equal_var(C, A, B):- head_literal(C, inv1, _ ,(A,B)).

exclusive_head(black, red).
exclusive_head(red, anycolor).
exclusive_head(black, anycolor).


:- not body_literal(_,black,_,_).
:- not body_literal(_,red,_,_).