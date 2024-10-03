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


key(g0_n00,3).
next(g0_n00, null).

key(g1_n00,2).
next(g1_n00, null).

key(g2_n00,1).
next(g2_n00, null).

key(g3_n00,0).
next(g3_n00, null).

key(g4_n00,0).
key(g4_n01,0).
next(g4_n00,g4_n01).
next(g4_n01, null).

key(g5_n00,2).
key(g5_n01,2).
next(g5_n00,g5_n01).
next(g5_n01, null).

key(g6_n00,1).
key(g6_n01,2).
next(g6_n00,g6_n01).
next(g6_n01, null).

key(g7_n00,0).
key(g7_n01,2).
next(g7_n00,g7_n01).
next(g7_n01, null).

key(g8_n00,3).
key(g8_n01,3).
next(g8_n00,g8_n01).
next(g8_n01, null).

key(g9_n00,2).
key(g9_n01,3).
next(g9_n00,g9_n01).
next(g9_n01, null).

key(g10_n00,0).
key(g10_n01,3).
next(g10_n00,g10_n01).
next(g10_n01, null).

key(g11_n00,1).
key(g11_n01,3).
next(g11_n00,g11_n01).
next(g11_n01, null).

key(g12_n00,0).
key(g12_n01,1).
next(g12_n00,g12_n01).
next(g12_n01, null).

key(g13_n00,1).
key(g13_n01,1).
next(g13_n00,g13_n01).
next(g13_n01, null).

key(g14_n00,3).
key(g14_n01,3).
key(g14_n02,3).
next(g14_n00,g14_n01).
next(g14_n01,g14_n02).
next(g14_n02, null).

key(g15_n00,2).
key(g15_n01,3).
key(g15_n02,3).
next(g15_n00,g15_n01).
next(g15_n01,g15_n02).
next(g15_n02, null).

key(g16_n00,2).
key(g16_n01,2).
key(g16_n02,2).
next(g16_n00,g16_n01).
next(g16_n01,g16_n02).
next(g16_n02, null).

