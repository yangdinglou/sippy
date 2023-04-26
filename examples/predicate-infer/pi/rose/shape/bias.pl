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
body_pred(p,1).
body_pred(pointto,2).
body_pred(next1,2).
body_pred(next2,2).

type(p,(pointer,)).

type(nullptr,(pointer,)).
type(pointto,(pointer,pointer)).
type(next1,(pointer,pointer)).
type(next2,(pointer,pointer)).

direction(p,(in,)).
direction(nullptr,(out,)).
direction(pointto,(out,out)).
direction(next1,(in,out)).
direction(next2,(out,out)).

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

:-
    #count{P,A,Vars : body_literal(0,P,A,Vars)} !=1.
:-
    #count{P,A,Vars : body_literal(1,P,A,Vars)} !=2.
:-
    #count{P,A,Vars : body_literal(2,P,A,Vars)} !=1.
:-
    #count{P,A,Vars : body_literal(3,P,A,Vars)} !=4.

% :-
%     #count{A,Vars : body_literal(0,nullptr,A,Vars)} != 1.
%     :-
%     #count{A,Vars : body_literal(2,nullptr,A,Vars)} != 1.

:-
    head_literal(1,_,_,(Var1,)),
    not body_literal(1,next1,_,(Var1,_)).

:-
    head_literal(3,_,_,(Var1,)),
    not body_literal(3,next2,_,(Var1,_)).

:-
    head_literal(3,_,_,(Var1,)),
    not body_literal(3,pointto,_,(Var1,_)).

:-
    body_literal(3,pointto,_,Vars),
    body_literal(3,next2,_,Vars).

:-
    #count{A,Vars : body_literal(3,next2,A,Vars)} != 1.

:-
    #count{A,Vars : body_literal(3,pointto,A,Vars)} != 1.

:-
    #count{N,A,Vars : body_literal(N,p,A,Vars)} = 0.

:-
    head_literal(3,P,_,_),
    not body_literal(3,P,_,_).

% :-
%     body_literal(N,P1,_,Vars),
%     body_literal(N,P2,_,Vars),
%     head_literal(_,P1,_,_),
%     head_literal(_,P2,_,_).

ground_pred(p).
ground_pred(inv1).
ground_pred(nullptr).
ground_pred(pointto).
ground_pred(next1).
ground_pred(next2).