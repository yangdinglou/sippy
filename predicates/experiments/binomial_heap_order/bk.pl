p(X, R) :- nullptr(X), zero(R).
p(X, R) :- key(X, V), child(X, C), p(C, R1), my_succ(R1, R), sibling(X, X1), p(X1, R2), anynumber(R2), anynumber(V).

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

my_succ(A, B) :-
    B is A + 1.

q(X, S) :- nullptr(X), empty(S).
q(X, S) :- key(X, V), child(X, C), q(C, S1), sibling(X, X1), q(X1, S2), ord_union(S1,S2,Tmp),insert(Tmp,V,S).

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