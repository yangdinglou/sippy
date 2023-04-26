nullptr(null).

next1(p1,q11).
next1(p11,q111).
next1(p12,q121).
next1(p121,null).
next1(p112,q1121).

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

% p(A):- nullptr(A), !.
% inv1(A):- nullptr(A), !.
% inv1(A):- next2(A,B),inv1(B), !.
% p(A):- next1(A,B),pointto(B,C),p(C),inv1(B), !.

% p(A):- nullptr(A), !.
% inv1(A):- nullptr(A), !.
% inv1(A):- next2(A,B), pointto(A, C), p(C), inv1(B), !.
% p(A):- next1(A,B),inv1(B), !.

% countt(List, T, Count) :-
%     include(=(T), List, Filtered),
%     length(Filtered, Count).

% eval_head(Ex, Inlist, 0, 0, Inlist) :- =(Ex, !), !.


% eval_head(Ex, Inlist, 0, -4, Inlist) :- functor(Ex, P, _), call(Ex), member(P,[anypointer, anycolor, anynumber]), !.
% eval_head(Ex, Inlist, 0, 4, Inlist) :- functor(Ex, P, _), call(Ex), member(P,[diff_lessthanone]), !.
% eval_head(Ex, Inlist, 0, 8, Inlist) :- functor(Ex, P, _), call(Ex), member(P,[equal, min_list, delete, max_list, select, zero, one, minusone, add, minus, my_succ, my_prev, maxnum, minnum, gt_list, lt_list, ord_union, insert, nullptr, empty, <, >]), !.
% eval_head(Ex, Inlist, FactV, 0, Outlist) :- clause(Ex, true), call(Ex), append(Inlist, [Ex], Outlist), countt(Outlist, Ex, Cnt), FactV is 1/Cnt, !.


% % eval_head(Ex, 4) :- functor(Ex, P, _), call(Ex), member(P,[diff_lessthanone]), !.

% eval_head(Ex, Inlist, FactV, SpecV, Outlist) :- clause(Ex, RawbodyList), call(RawbodyList), eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist).

% eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist) :- RawbodyList =..BodyList, first_rest(BodyList, ',', Bodyss), first_rest(Bodyss, H, Bodys), eval_head(H, Inlist, FactV0, SpecV0, Inlist1), first_rest(Bodys, Body, _), eval_body(Body, Inlist1, FactV1, SpecV1, Outlist), FactV is FactV0 + FactV1, SpecV is SpecV0 + SpecV1, !.

% eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist) :- RawbodyList =..BodyList, \+ first_rest(BodyList, ',', _), eval_head(RawbodyList, Inlist, FactV, SpecV, Outlist).

% first_rest([Fst|Rst], Fst, Rst).


% scores(Ex, FactNum, AllFactV, Callnum, SpecV) :- eval_head(Ex, [], AllFactV, SpecV, Outlist), length(Outlist, Callnum), list_to_set(Outlist, Outset), length(Outset, FactNum).