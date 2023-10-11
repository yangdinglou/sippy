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


next(p1, p2).
next(p2, p3).
next(p3, p4).
next(p4, null).

prev(p1, null).
prev(p2, p1).
prev(p3, p2).
prev(p4, p3).

key(p1, 1).
key(p2, 2).
key(p3, 3).
key(p4, 4).

next(n1, n2).
next(n2, n3).
next(n3, null).

prev(n1, n0).
prev(n2, n1).
prev(n3, n2).

key(n1, 6).
key(n2, 9).
key(n3, 3).

    key(p6496432, -665).    next(p6496432, p6496464).    prev(p6496432, p6496400).
    key(p6496304, -114).    next(p6496304, p6496336).    prev(p6496304, p6496272).
    key(p6496336, -223).    next(p6496336, p6496368).    prev(p6496336, p6496304).
    key(p6496368, -85).    next(p6496368, p6496400).    prev(p6496368, p6496336).
    key(p6496400, 793).    next(p6496400, p6496432).    prev(p6496400, p6496368).
    key(p6496464, 386).    next(p6496464, p6496496).    prev(p6496464, p6496432).
    key(p6496496, -508).    next(p6496496, p6496528).    prev(p6496496, p6496464).
    key(p6496528, -351).    next(p6496528, p6496560).    prev(p6496528, p6496496).
    key(p6496560, 421).    next(p6496560, null).    prev(p6496560, p6496528).
    key(p6496272, 383).    next(p6496272, p6496304).    prev(p6496272, null).

% dlseg(X, X1, Y, Y1, S) :- same_ptr(X, Y), same_ptr(X1, Y1), empty(S).
% dlseg(X, X1, Z, Z1, S) :- key(X, V), next(X, Y), prev(X, X1), dlseg(Y, X, Z, Z1, S1), insert(S1, V, S).