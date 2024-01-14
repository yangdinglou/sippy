max_clauses(4).
enable_recursion.
enable_pi.

head_pred(p,1).

body_pred(nullptr,1).
inner_pointer(next2, pointer).
input_pointer(child, pointer).
input_pointer(next, pointer).

type(p,(pointer,)).

type(nullptr,(pointer,)).

direction(p,(in,)).
direction(nullptr,(in,)).


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
    body_literal(T, nullptr, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.

