use_module(library(lists)).
empty([]).
zero(0).
one(1).

value(p1,1).
value(p2,2).
value(p3,3).
value(p4,4).
value(n1,2).
value(n2,1).
value(n3,3).
value(n4,4).

pointer(p1, p2).
pointer(p2, p3).
pointer(p3, p4).
pointer(p4, null).
pointer(n1, n2).
pointer(n2, n3).
pointer(n3, n4).
pointer(n4, null).
nullptr(null).

q(p2,[4,3,2]).
q(p3,[4,3]).
q(p4,[4]).
q(null,[]).
q(n2,[4,3,1]).
q(n3,[4,3]).
q(n4,[4]).

my_min_list(List, Num):-
    ground(List), min_list(List, Num).
my_delete(List1, Elem, List2):-
    ground(List1),
    ground(Elem),
    select(Elem, List1, List2).