use_module(library(lists)).
empty([]).
zero(0).
one(1).
nullptr(null).

value(p1,1).
value(p2,2).
value(p3,3).
value(p4,4).

pointer(p1, p2).
pointer(p2, p3).
pointer(p3, p4).
pointer(p4, null).


value(pp1,5).
value(pp2,8).
value(pp3,9).
value(pp4,11).
value(pp5,12).
value(pp6,15).
value(pp7,19).
value(pp8,20).

pointer(pp1, pp2).
pointer(pp2, pp3).
pointer(pp3, pp4).
pointer(pp4, pp5).
pointer(pp5, pp6).
pointer(pp6, pp7).
pointer(pp7, pp8).
pointer(pp8, null).

my_min_list(List, Num):-
    ground(List), min_list(List, Num).
my_delete(List1, Elem, List2):-
    ground(List1),
    ground(Elem),
    select(Elem, List1, List2).
    % delete(List1, Elem, List2).

insert(A, B, C) :-
    is_ordset(A), ord_union([B], A, C).