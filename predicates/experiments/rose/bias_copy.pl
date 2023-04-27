% p(This) :- nullptr(This).
% p(This) :- next(This, Nxt), inv1(Nxt).

% inv1(This) :- nullptr(This).
% inv1(This) :- value(This, r), p(r), next(This, Nxt), inv1(Nxt).

% BEST PROG 753:
% p(A):-nullptr(A).
% p(A):-next1(A,B),inv1(B).
% inv1(A):-p(A).
% inv1(A):-pointto(A,C),next2(A,B),inv1(C),inv1(B).
% Precision:1.00, Recall:1.00, TP:4, FN:0, TN:0, FP:0

max_vars(3).
max_body(4).
max_clauses(4).
enable_recursion.
enable_pi.

head_pred(p,1).

body_pred(nullptr,1).
body_pred(p,1).
body_pred(pointto,2).
body_pred(next1,2).
body_pred(next2,2).

type(p,(pointer,)).

type(nullptr,(pointer,)).
type(pointto,(pointer,pointer)).
type(next1,(pointer,pointer)).
type(next2,(pointer,pointer)).

:-
    not clause(1).
:-
    not clause(2).
:-
    not clause(3).

:-
    head_literal(2,P,_,_),
    not body_literal(1,P,_,_).
:-
    not head_literal(2,_,1,_).

:-
    head_literal(0,P,_,_),
    not head_literal(1,P,_,_).

:-
    head_literal(1,P,_,_),
    head_literal(2,P,_,_).

:-
    head_literal(2,P,_,_),
    not head_literal(3,P,_,_).

% :-
%     #count{P,A,Vars : body_literal(0,P,A,Vars)} !=1.
% :-
%     #count{P,A,Vars : body_literal(1,P,A,Vars)} !=2.
% :-
%     #count{P,A,Vars : body_literal(2,P,A,Vars)} !=1.
% :-
%     #count{P,A,Vars : body_literal(3,P,A,Vars)} !=4.

% :-
%     #count{A,Vars : body_literal(1,next1,A,Vars)} = 0.

:-
    head_literal(1,_,_,(Var1,)),
    not body_literal(1,next1,_,(Var1,_)).

:-
    head_literal(3,_,_,(Var1,)),
    not body_literal(3,next2,_,(Var1,_)).

:-
    head_literal(3,_,_,(Var1,)),
    not body_literal(3,pointto,_,(Var1,_)).

% :-
%     #count{A,Vars : body_literal(3,next2,A,Vars)} = 0.

% :-
%     #count{A,Vars : body_literal(3,pointto,A,Vars)} = 0.

% :-
%     #count{A,Vars : body_literal(3,p,A,Vars)} = 0.

% :-
%     head_literal(3,P,_,_),
%     not body_literal(3,P,_,_).

% :-
%     body_literal(N,P1,_,Vars),
%     body_literal(N,P2,_,Vars),
%     head_literal(_,P1,_,_),
%     head_literal(_,P2,_,_).