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
value(aa, 10).
back(aa, null).
left(aa, bb).
right(aa, cc).
height(aa, 2).

value(bb, 5).
back(bb, aa).
left(bb, null).
right(bb, null).
height(bb, 0).

value(cc, 15).
back(cc, aa).
left(cc, dd).
right(cc, null).
height(cc, 1).

value(dd, 12).
back(dd, cc).
left(dd, null).
right(dd, null).
height(dd, 0).

value(a, 50).
back(a, null).
left(a, b).
right(a, i).
height(a, 3).

value(b, 30).
back(b, a).
left(b, c).
right(b, f).
height(b, 2).

value(c, 20).
back(c, b).
left(c, d).
right(c, e).
height(c, 1).

value(d, 10).
back(d, c).
left(d, null).
right(d, null).
height(d, 0).

value(e, 25).
back(e, c).
left(e, null).
right(e, null).
height(e, 0).

value(f, 40).
back(f, b).
left(f, g).
right(f, h).
height(f, 1).

value(g, 50).
back(g, f).
left(g, null).
right(g, null).
height(g, 0).

value(h, 45).
back(h, f).
left(h, null).
right(h, null).
height(h, 0).

value(i, 5).
back(i, a).
left(i, j).
right(i, k).
height(i, 1).

value(j, 55).
back(j, i).
left(j, null).
right(j, null).
height(j, 0).

value(k, 70).
back(k, i).
left(k, null).
right(k, null).
height(k, 0).
