use_module(library(lists)).
empty([]).
nil([]).
zero(0).
nullptr(null).

cons(A, B, C) :-
    append([B], A, C).

gt_list(_, []).
gt_list(A, B) :-
    max_list(B, C), A >= C.
lt_list(_, []).
lt_list(A, B) :-
    min_list(B, C), A =< C.

gt_set(_, []).
gt_set(A, B) :-
    max_list(B, C), A >= C.
lt_set(_, []).
lt_set(A, B) :-
    min_list(B, C), A =< C.

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

ge(A, B) :-
    A >= B.


add(A, B, C) :-
    C is A + B.

next(p1, p2).
next(p2, p3).
next(p3, null).

child(p1, p11).
child(p2, p21).
child(p3, p31).



next2(p11, p12).
next2(p12, p13).
next2(p13, null).
next2(p21, p22).
next2(p22, null).
next2(p31, p32).
next2(p32, p33).
next2(p33, null).

value(p11, 4).
value(p12, 20).
value(p13, 3).
value(p21, 54).
value(p22, 6).
value(p31, 3).
value(p32, 12).
value(p33, 9).

next(pp1, pp2).
next(pp2, pp3).
next(pp3, null).

child(pp1, null).
child(pp2, pp21).
child(pp3, pp31).




next2(pp21, pp22).
next2(pp22, null).
next2(pp31, pp32).
next2(pp32, pp33).
next2(pp33, null).


value(pp21, 1).
value(pp22, 2).
value(pp31, 3).
value(pp32, 4).
value(pp33, 5).
