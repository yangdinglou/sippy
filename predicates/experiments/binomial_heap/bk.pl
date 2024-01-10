use_module(library(lists)).
empty([]).
zero(0).
nullptr(null).

gt_list(_, []).
gt_list(A, B) :-
    max_list(B, C), A >= C.
lt_list(_, []).
lt_list(A, B) :-
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


value(aa, 10).
left(aa, bb).
right(aa, cc).
height(aa, 2).

value(bb, 5).
left(bb, null).
right(bb, null).
height(bb, 0).

value(cc, 15).
left(cc, dd).
right(cc, null).
height(cc, 1).

value(dd, 12).
left(dd, null).
right(dd, null).
height(dd, 0).

value(aaa, 10).
left(aaa, bbb).
right(aaa, ccc).
height(aaa, 2).

value(bbb, 5).
left(bbb, null).
right(bbb, null).
height(bbb, 0).

value(ccc, 15).
left(ccc, null).
right(ccc, ddd).
height(ccc, 1).

value(ddd, 17).
left(ddd, null).
right(ddd, null).
height(ddd, 0).

value(a, 50).
left(a, b).
right(a, i).
height(a, 3).

value(b, 30).
left(b, c).
right(b, f).
height(b, 2).

value(c, 20).
left(c, d).
right(c, e).
height(c, 1).

value(d, 10).
left(d, null).
right(d, null).
height(d, 0).

value(e, 25).
left(e, null).
right(e, null).
height(e, 0).

value(f, 40).
left(f, g).
right(f, h).
height(f, 1).

value(g, 35).
left(g, null).
right(g, null).
height(g, 0).

value(h, 45).
left(h, null).
right(h, null).
height(h, 0).

value(i, 60).
left(i, j).
right(i, null).
height(i, 1).

value(j, 55).
left(j, null).
right(j, null).
height(j, 0).



diff_lessthanone(A, B):-
    D is A - B, abs(D, AbsD), AbsD =< 1.

my_succ(A, B) :-
    B is A + 1.

my_prev(A, B) :-
    B is A - 1.

insert(A, B, C) :-
    is_ordset(A), ord_union([B], A, C).


p(X, R) :- key(X, V), child(X, C), p(C, R1), my_succ(R1, R), sibling(X, X1), p(X1, R2), anynumber(R2), anynumber(V).

p(X, S) :- key(X, V), child(X, C), p(C, S1), sibling(X, X1), p(X1, S2),  