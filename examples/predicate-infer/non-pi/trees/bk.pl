empty([]).
zero(0).
one(1).

gt(A, B) :- A > B.
ge(A, B) :- A >= B.

prev(A, B) :- succ(B, A).

maxnum(A, B, C) :-
    A is max(B, C).

minnum(A, B, C) :-
    A is min(B, C).

add(A, B, C) :-
    A is B + C.

minus(A, B, C) :-
    A is B - C.

insert(A, B, C) :-
    ord_union([B], A, C).


nullptr(null1).
nullptr(null2).
nullptr(null3).
nullptr(null4).
nullptr(null5).
nullptr(null6).
nullptr(null7).
nullptr(null8).
nullptr(null9).

value(p1,4).
value(p2,8).
value(p3,1).
value(p4,9).
value(p5,6).
value(p6,2).
value(p7,6).
value(p8,8).

left(p1,p2).
left(p2,p4).
left(p3,p6).
left(p4,null1).
left(p5,null2).
left(p6,null3).
left(p7,null4).
left(p8,null5).

right(p1,p3).
right(p2,p5).
right(p3,p7).
right(p4,null6).
right(p5,p8).
right(p6,null7).
right(p7,null8).
right(p8,null9).