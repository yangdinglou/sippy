:- use_module(library(lists)).

my_value(p1,1).
my_value(p2,2).
my_value(p3,3).
my_value(p4,4).

my_dis(p1, p2, 1).
my_dis(p2, p3, 1).
my_dis(p3, p4, 1).
my_dis(p4, null, 1).


my_value(n1,1).
my_value(n2,3).
my_value(n3,2).
my_value(n4,4).

my_dis(n1, n2, 1).
my_dis(n2, n3, 1).
my_dis(n3, n4, 1).
my_dis(n4, null, 1).
addone(A, B) :-
    ground(A),
    plus(1,B,A).

my_subset(PTR, A, B):-
    ground(A),
    ground(PTR),
    ground(V),
    value(PTR, V),
    delete(A, V, B).

isof(A, B):- 
    ground(A),
    my_value(A, C), member(C, B).

nextone(A, B):-
    my_dis(A, B, 1).

zero(0).
empty([]).
nullptr(null).

