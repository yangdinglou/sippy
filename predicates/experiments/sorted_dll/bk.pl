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

key(n1, 3).
key(n2, 6).
key(n3, 9).

    key(p6496432, 31).    next(p6496432, p6496464).    prev(p6496432, p6496400).
    key(p6496304, 4).    next(p6496304, p6496336).    prev(p6496304, p6496272).
    key(p6496336, 7).    next(p6496336, p6496368).    prev(p6496336, p6496304).
    key(p6496368, 14).    next(p6496368, p6496400).    prev(p6496368, p6496336).
    key(p6496400, 25).    next(p6496400, p6496432).    prev(p6496400, p6496368).
    key(p6496464, 38).    next(p6496464, p6496496).    prev(p6496464, p6496432).
    key(p6496496, 44).    next(p6496496, p6496528).    prev(p6496496, p6496464).
    key(p6496528, 51).    next(p6496528, p6496560).    prev(p6496528, p6496496).
    key(p6496560, 67).    next(p6496560, null).    prev(p6496560, p6496528).
    key(p6496272, 2).    next(p6496272, p6496304).    prev(p6496272, null).

% countt(List, T, Count) :-
%     include(=(T), List, Filtered),
%     length(Filtered, Count).

% eval_head(Ex, Inlist, 0, 0, Inlist) :- =(Ex, !), !.

% eval_head(Ex, Inlist, 0, 4, Inlist) :- functor(Ex, P, _), call(Ex), member(P,[diff_lessthanone]), !.
% eval_head(Ex, Inlist, 0, 8, Inlist) :- functor(Ex, P, _), call(Ex), member(P,[equal, min_list, delete, max_list, select, zero, one, minusone, add, minus, my_succ, my_prev, maxnum, minnum, gt_list, lt_list, ord_union, insert, nullptr]), !.
% eval_head(Ex, Inlist, FactV, 0, Outlist) :- clause(Ex, true), call(Ex), append(Inlist, [Ex], Outlist), countt(Outlist, Ex, Cnt), FactV is 1/Cnt, !.


% % eval_head(Ex, 4) :- functor(Ex, P, _), call(Ex), member(P,[diff_lessthanone]), !.

% eval_head(Ex, Inlist, FactV, SpecV, Outlist) :- clause(Ex, RawbodyList), call(RawbodyList), eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist).

% eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist) :- RawbodyList =..BodyList, first_rest(BodyList, ',', Bodyss), first_rest(Bodyss, H, Bodys), eval_head(H, Inlist, FactV0, SpecV0, Inlist1), first_rest(Bodys, Body, _), eval_body(Body, Inlist1, FactV1, SpecV1, Outlist), FactV is FactV0 + FactV1, SpecV is SpecV0 + SpecV1, !.

% eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist) :- RawbodyList =..BodyList, \+ first_rest(BodyList, ',', _), eval_head(RawbodyList, Inlist, FactV, SpecV, Outlist).

% first_rest([Fst|Rst], Fst, Rst).


% scores(Ex, FactNum, AllFactV, Callnum, SpecV) :- eval_head(Ex, [], AllFactV, SpecV, Outlist), length(Outlist, Callnum), list_to_set(Outlist, Outset), length(Outset, FactNum).

% dll(A,B,C):- nullptr(A),anypointer(B),empty(C), !.
% dll(A,B,C):- key(A,D),next(A,E),prev(A,B),dll(E,A,F),insert(F,D,C), min_list(C, D), !.