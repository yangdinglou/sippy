max_vars(8).
max_body(7).
max_clauses(4).
enable_recursion.

head_pred(p,1).

body_pred(nullptr,1).
body_pred(p,1).
body_pred(pointto,2).
body_pred(next,2).

type(p,(pointer,)).

type(nullptr,(pointer,)).
type(pointto,(pointer,pointer)).
type(next,(pointer,pointer)).

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
    #count{A,Vars : body_literal(1,next,A,Vars)} = 0.

:-
    #count{A,Vars : body_literal(3,next,A,Vars)} = 0.

:-
    #count{A,Vars : body_literal(3,pointto,A,Vars)} = 0.