% p(X, Y, R) :- nullptr(X), zero(R), anypointer(Y).
% p(X, Y, R) :- key(X, V), child(X, C), parent(X, Y), p(C, X, R1), my_succ(R1, R), sibling(X, X1), p(X1, Y, R2), anynumber(R2), anynumber(V).

nullptr(null).
anynumber(_).

next(x00,x01).
next(x01,null).

tree_root(x00,x0).
tree_root(x01,x1).


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

sibling(x0,null).
sibling(x1,null).
sibling(x2,x4).
sibling(x3,null).
sibling(x4,null).



my_succ(A, B) :-
    B is A + 1.

% q(X, Y, S) :- nullptr(X), empty(S), anypointer(Y).
% q(X, Y, S) :- key(X, V), child(X, C), parent(X, Y), q(C, X, S1), sibling(X, X1), q(X1, Y, S2), ord_union(S1,S2,Tmp),insert(Tmp,V,S).

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

next(p00,p01).
next(p01,null).

tree_root(p00,p1).
tree_root(p01,p5).

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

sibling(p1, null).
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



% q(A,B):- empty(B),nullptr(A), !.
% q(A,B):- next(A,C),tree_root(A,D), tree(D,E),q(C,F),ord_union(E,F,B), !.

% tree(A,C):- empty(C),nullptr(A), !.
% tree(A,C):- sibling(A,I),child(A,D),key(A,G),tree(D,E),tree(I,F),ord_union(E,F,H),insert(H,G,C), !. %gt