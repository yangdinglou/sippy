nullptr(X):- X = null.
anypointer(_).
next(p1, p2).
next(p2, p3).
next(p3, p4).
next(p4, null).

prev(p1, null).
prev(p2, p1).
prev(p3, p2).
prev(p4, p3).

next(n1, n2).
next(n2, n3).
next(n3, null).

prev(n1, null).
prev(n2, n1).
prev(n3, n2).

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

% dll(A,B):- nullptr(A),anypointer(B), !.
% dll(A,B):- next(A,C),prev(A,B),dll(C,A), !.