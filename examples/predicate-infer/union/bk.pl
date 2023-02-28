use_module(library(lists)).


empty([]).
zero(0).
one(1).


value(n1,1).
value(n2,2).
value(n3,3).
value(n4,4).

pointer(n1, n2).
pointer(n2, n3).
pointer(n3, n4).
pointer(n4, null).
nullptr(null).

my_min_list(List, Num):-
    ground(List), min_list(List, Num).

my_delete(List1, Elem, List2):-
    ground(List1),
    ground(Elem),
    delete(List1, Elem, List2).