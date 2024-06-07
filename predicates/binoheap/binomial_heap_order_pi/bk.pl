
nullptr(null).
anynumber(_).

key(x0,67).
key(x1,1).
key(x2,4).
key(x3,7).
key(x4,4).

child(x0,null).
child(x1,x2).
child(x2,x3).
child(x3,null).
child(x4,null).

sibling(x0,x1).
sibling(x1,null).
sibling(x2,x4).
sibling(x3,null).
sibling(x4,null).

parent(x0,null).
parent(x1,null).
parent(x2,x1).
parent(x3,x2).
parent(x4,x1).



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

key(p1, 3).
key(p2, 7).
key(p3, 21).
key(p4, 21).
key(p5, 4).
key(p6, 6).
key(p7, 13).
key(p8, 27).
key(p9, 7).
key(p10, 13).
key(p11, 62).
key(p12, 22).

child(p1, p2).
child(p2, p4).
child(p3, null).
child(p4, null).
child(p5, p6).
child(p6, p9).
child(p7, p11).
child(p8, null).
child(p9, p12).
child(p10, null).
child(p11, null).
child(p12, null).

sibling(p1, p5).
sibling(p2, p3).
sibling(p3, null).
sibling(p4, null).
sibling(p5, null).
sibling(p6, p7).
sibling(p7, p8).
sibling(p8, null).
sibling(p9, p10).
sibling(p10, null).
sibling(p11, null).
sibling(p12, null).

parent(p1, null).
parent(p2, p1).
parent(p3, p1).
parent(p4, p2).
parent(p5, null).
parent(p6, p5).
parent(p7, p5).
parent(p8, p5).
parent(p9, p6).
parent(p10, p6).
parent(p11, p7).
parent(p12, p9).

