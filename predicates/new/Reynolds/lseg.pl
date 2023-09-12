lseg(X, Y, S) :- same_ptr(X, Y), empty(S).
lseg(X, Y, S) :- value(X, V), next(X, Z), lseg(Z, Y, S1), insert(S1, V, S).

lseg(p1, p3, [1, 2]).

lseg(p1, null, [1,2,3,4]).

lseg(pp1, null, [5, 6, 8, 9, 12, 15, 19, 20]).

lseg(pp3, pp7, [6, 9, 12, 15]).

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
value(pp4,6).
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