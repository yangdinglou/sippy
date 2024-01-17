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
left(aa, bb).
right(aa, cc).

value(bb, 5).
left(bb, null).
right(bb, null).

value(cc, 15).
left(cc, dd).
right(cc, null).

value(dd, 12).
left(dd, null).
right(dd, null).

value(a, 50).
left(a, b).
right(a, i).

value(b, 30).
left(b, c).
right(b, f).

value(c, 20).
left(c, d).
right(c, e).

value(d, 10).
left(d, null).
right(d, null).

value(e, 25).
left(e, null).
right(e, null).

value(f, 40).
left(f, g).
right(f, h).

value(g, 50).
left(g, null).
right(g, null).

value(h, 45).
left(h, null).
right(h, null).

value(i, 5).
left(i, j).
right(i, k).

value(j, 55).
left(j, null).
right(j, null).

value(k, 70).
left(k, null).
right(k, null).


% Node 1
value(n_1, 50).
left(n_1, n_2).
right(n_1, n_3).

% Node 2
value(n_2, 25).
left(n_2, n_4).
right(n_2, n_5).

% Node 3
value(n_3, 75).
left(n_3, n_6).
right(n_3, n_7).

% Nodes 4-11
value(n_4, 15).
left(n_4, n_8).
right(n_4, n_9).

value(n_5, 35).
left(n_5, n_10).
right(n_5, n_11).

value(n_6, 60).
left(n_6, n_12).
right(n_6, n_13).

value(n_7, 90).
left(n_7, n_14).
right(n_7, n_15).

% Nodes 8-15
value(n_8, 10).
left(n_8, n_16).
right(n_8, n_17).

value(n_9, 20).
left(n_9, n_18).
right(n_9, n_19).

value(n_10, 30).
left(n_10, n_20).
right(n_10, n_21).

value(n_11, 40).
left(n_11, n_22).
right(n_11, n_23).

value(n_12, 55).
left(n_12, n_24).
right(n_12, n_25).

value(n_13, 65).
left(n_13, n_26).
right(n_13, n_27).

value(n_14, 80).
left(n_14, n_28).
right(n_14, n_29).

value(n_15, 95).
left(n_15, n_30).
right(n_15, n_31).

% Nodes 16-31 (Leaves)
value(n_16, 5).
							
left(n_16, null).
right(n_16, null).

value(n_17, 12).
left(n_17, null).
right(n_17, null).

value(n_18, 18).
left(n_18, null).
right(n_18, null).

value(n_19, 22).
left(n_19, null).
right(n_19, null).

value(n_20, 28).
left(n_20, null).
right(n_20, null).

value(n_21, 32).
left(n_21, null).
right(n_21, null).

value(n_22, 38).
left(n_22, null).
right(n_22, null).

value(n_23, 42).
left(n_23, null).
right(n_23, null).

value(n_24, 53).
left(n_24, null).
right(n_24, null).

value(n_25, 58).
left(n_25, null).
right(n_25, null).

value(n_26, 62).
left(n_26, null).
right(n_26, null).

value(n_27, 68).
left(n_27, null).
right(n_27, null).

value(n_28, 82).
left(n_28, null).
right(n_28, null).

value(n_29, 88).
left(n_29, null).
right(n_29, null).

value(n_30, 93).
left(n_30, null).
right(n_30, null).

value(n_31, 97).
left(n_31, null).
right(n_31, null).

% btree(A,B):- nullptr(A),empty(B), !.
% btree(A,B):- value(A,E),right(A,C),left(A,D),btree(D,F),btree(C,G),ord_union(F,G,H),insert(H,E,B), !.