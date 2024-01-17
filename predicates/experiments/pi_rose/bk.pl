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

next1(p1,q11).
next1(p11,q111).
next1(p12,q121).
next1(p121,null).
next1(p112,q1121).

value(p1,1).
value(p11,3).
value(p12,2).
value(p121,6).
value(p112,1).

next2(q11,q12).
next2(q12,null).
next2(q121,q122).
next2(q122,null).
next2(q111,q112).
next2(q112,null).
next2(q1121,null).

pointto(q11,p11).
pointto(q12,p12).
pointto(q121,p121).
pointto(q122,null).
pointto(q111,null).
pointto(q112,p112).
pointto(q1121,null).



% rose_tree(A,S):- nullptr(A),empty(S).
% rose_tree(A,S):- next1(A,B),buds(B,S1),value(A,C),insert(S1,C,S).
% buds(A,S):- nullptr(A),empty(S).
% buds(A,S):- pointto(A,C),rose_tree(C,S1),next2(A,B),buds(B,S2), ord_union(S1,S2,S).


next1(r1, r1_s11).
next1(s11, s11_t111).
next1(s12, s12_t121).
next1(s13, s13_t131).
next1(t111,null).
next1(t112,null).
next1(t121,null).
next1(t122,null).
next1(t131,null).
next1(t132,null).


value(r1, 10).
value(s11, 5).
value(s12, 8).
value(s13, 7).
value(t111, 2).
value(t112, 3).
value(t121, 6).
value(t122, 4).
value(t131, 9).
value(t132, 1).

next2(r1_s11, r1_s12).
next2(r1_s12, r1_s13).
next2(r1_s13, null).
next2(s11_t111, s11_t112).
next2(s11_t112, null).
next2(s12_t121, s12_t122).
next2(s12_t122, null).
next2(s13_t131, s13_t132).
next2(s13_t132, null).

pointto(r1_s11, s11).
pointto(r1_s12, s12).
pointto(r1_s13, s13).
pointto(s11_t111, t111).
pointto(s11_t112, t112).
pointto(s12_t121, t121).
pointto(s12_t122, t122).
pointto(s13_t131, t131).
pointto(s13_t132, t132).
