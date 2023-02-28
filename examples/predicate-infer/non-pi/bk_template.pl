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