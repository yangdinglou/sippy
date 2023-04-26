% From
% p(A):-nullptr(A).
% p(A):-next1(A,B),inv1(B).
% inv1(A):-nullptr(A).
% inv1(A):-pointto(A,C),next2(A,B),p(C),inv1(B).
% To
% p(A, S):-nullptr(A), empty(S).
% p(A, S):-next1(A,B),inv1(B, S1), value(A, v), insert(S1, v, S).
% inv1(A, S):-nullptr(A), empty(S).
% inv1(A, S):-pointto(A,C),next2(A,B),p(C, S1),inv1(B, S2), union(S1, S2, S).

max_vars(6).
max_body(5).
max_clauses(4).
enable_recursion.
enable_pi.

head_pred(p,2).

body_pred(nullptr,1).
body_pred(empty,1).
body_pred(p,2).
body_pred(pointto,2).
body_pred(next1,2).
body_pred(next2,2).
body_pred(value,2).

body_pred(my_insert,3).
body_pred(my_union,3).

type(p,(pointer,set)).

type(nullptr,(pointer,)).
type(empty,(set,)).
type(pointto,(pointer,pointer)).
type(next1,(pointer,pointer)).
type(next2,(pointer,pointer)).
type(value,(pointer,integer)).
type(my_insert,(set,integer,set)).
type(my_union,(set,set,set)).

% From
% p(A):-nullptr(A).
% p(A):-next1(A,B),inv1(B).
% inv1(A):-nullptr(A).
% inv1(A):-pointto(A,C),next2(A,B),p(C),inv1(B).

:-
    not clause(1).
:-
    not clause(2).
:-
    not clause(3).

:-
    #count{A,Vars : body_literal(0,nullptr,A,Vars)} != 1.
:-
    #count{A,Vars : body_literal(2,nullptr,A,Vars)} != 1.



:-
    head_literal(2,P,_,_),
    not body_literal(1,P,_,_).
:-
    not head_literal(2,_,2,_).

:-
    head_literal(0,P,_,_),
    not head_literal(1,P,_,_).

:-
    head_literal(1,P,_,_),
    head_literal(2,P,_,_).

:-
    head_literal(2,P,_,_),
    not head_literal(3,P,_,_).

%1
:-
    #count{A,Vars : body_literal(1,next1,A,Vars)} != 1.
:-
    #count{A,Vars : body_literal(1,pointto,A,Vars)} != 0.
:-
    #count{A,Vars : body_literal(1,value,A,Vars)} != 1.
:-
    #count{A,Vars : body_literal(1,next2,A,Vars)} != 0.


:-
    head_literal(1,_,_,(Var1,_)),
    not body_literal(1,next1,_,(Var1,_)).
:-
    body_literal(1,next1,_,(_,Var2)),
    head_literal(2,P,_,_),
    not body_literal(1,P,_,(Var2,_)).
:-
    head_literal(2,P,_,_),
    not body_literal(1,P,_,_).

%3
:-
    head_literal(3,_,_,(Var1,_)),
    not body_literal(3,pointto,_,(Var1,_)).
:-
    head_literal(3,_,_,(Var1,_)),
    not body_literal(3,next2,_,(Var1,_)).

:-
    body_literal(3,pointto,_,Vars),
    body_literal(3,next2,_,Vars).
:-
    #count{A,Vars : body_literal(3,pointto,A,Vars)} != 1.
:-
    #count{A,Vars : body_literal(3,next1,A,Vars)} != 0.

:-
    #count{A,Vars : body_literal(3,next2,A,Vars)} != 1.

:-
    #count{A,Vars : body_literal(3,value,A,Vars)} != 0.

:-
    #count{N,A,Vars : body_literal(N,p,A,Vars)} != 1.
:-
    #count{A,Vars : body_literal(3,p,A,Vars)} != 1.

:-
    head_literal(3,P,_,_),
    not #count{A,Vars : body_literal(3,P,A,Vars)} = 1.

:-
    body_literal(3,next2,_,(_,Var)),
    body_literal(3,inv1,_,(Var,_)).
:-
    body_literal(3,pointto,_,(_,Var)),
    body_literal(3,p,_,(Var,_)).

:-
    #count{P,A,Vars : body_literal(0,P,A,Vars)} !=2.
:-
    #count{P,A,Vars : body_literal(1,P,A,Vars)} !=4.
:-
    #count{P,A,Vars : body_literal(2,P,A,Vars)} !=2.
:-
    #count{P,A,Vars : body_literal(3,P,A,Vars)} !=5.





:-
    head_literal(1,_,_,(Var1,_)),
    not body_literal(1,value,_,(Var1,_)).

:-
    head_literal(1,_,_,(_,Var2)),
    not body_literal(1,my_insert,_,(Var2,_,_)).

:-
    head_literal(3,_,_,(_,Var2)),
    not body_literal(3,my_union,_,(Var2,_,_)).













