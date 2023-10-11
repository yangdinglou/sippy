use_module(library(lists)).
empty([]).
zero(0).
nullptr(null).

gt_list(_, []).
gt_list(A, B) :-
    max_list(B, C), A > C.
lt_list(_, []).
lt_list(A, B) :-
    min_list(B, C), A < C.

maxnum(A, B, C) :-
    C is max(A, B).

minnum(A, B, C) :-
    C is min(A, B).

diff_lessthanone(A, B):-
    D is A - B, abs(D, AbsD), AbsD =< 1.

my_succ(A, B) :-
    B is A + 1.

my_prev(A, B) :-
    B is A - 1.

insert(A, B, C) :-
    is_ordset(A), ord_union([B], A, C).

anypointer(_).
anynumber(_).

same_ptr(A, A).


value(p1,1).
value(p2,2).
value(p3,3).
value(p4,4).

next(p1, p2).
next(p2, p3).
next(p3, p4).
next(p4, null).


value(pp1,5).
value(pp2,8).
value(pp3,9).
value(pp4,2).
value(pp5,12).
value(pp6,15).
value(pp7,19).
value(pp8,20).

next(pp1, pp2).
next(pp2, pp3).
next(pp3, pp4).
next(pp4, pp5).
next(pp5, pp6).
next(pp6, pp7).
next(pp7, pp8).
next(pp8, null).
