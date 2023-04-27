nullptr(null).

next(p1, p2).
next(p2, p3).
next(p3, null).

child(p1, p11).
child(p2, p21).
child(p3, p31).



next(p11, p12).
next(p12, p13).
next(p13, null).
next(p21, p22).
next(p22, null).
next(p31, p32).
next(p32, p33).
next(p33, null).

% value(p11, v).
% value(p12, v).
% value(p13, v).
% value(p21, v).
% value(p22, v).
% value(p31, v).
% value(p32, v).
% value(p33, v).

next(pp1, pp2).
next(pp2, pp3).
next(pp3, null).

child(pp1, null).
child(pp2, pp21).
child(pp3, pp31).




next(pp21, pp22).
next(pp22, null).
next(pp31, pp32).
next(pp32, pp33).
next(pp33, null).


% value(pp21, v).
% value(pp22, v).
% value(pp31, v).
% value(pp32, v).
% value(pp33, v).

% p(A):-nullptr(A).
% p(A):-inv1(B),child(A,B),next(A,C),p(C).
% inv1(A):-nullptr(A).
% inv1(A):-next(A,C),inv1(C).

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

% p(A):- nullptr(A), !.
% inv1(A):- nullptr(A), !.
% inv1(A):- next(A,B),inv1(B), !.
% p(A):- next(A,C),child(A,B),p(C),inv1(B), !.