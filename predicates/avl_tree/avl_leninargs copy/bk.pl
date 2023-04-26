use_module(library(lists)).
empty([]).
zero(0).
one(1).
minusone(-1).
nullptr(null).
% height(null,-1).


% gt(A, B) :- A > B.
% ge(A, B) :- A >= B.
gt_list(_, []).
gt_list(A, B) :-
    max_list(B, C), A > C.
lt_list(_, []).
lt_list(A, B) :-
    min_list(B, C), A < C.

% prev(A, B) :- succ(B, A).

maxnum(A, B, C) :-
    C is max(A, B).

minnum(A, B, C) :-
    C is min(A, B).

value(aa, 10).
left(aa, bb).
right(aa, cc).
height(aa, 2).

value(bb, 5).
left(bb, null).
right(bb, null).
height(bb, 0).

value(cc, 15).
left(cc, dd).
right(cc, null).
height(cc, 1).

value(dd, 12).
left(dd, null).
right(dd, null).
height(dd, 0).

value(aaa, 10).
left(aaa, bbb).
right(aaa, ccc).
height(aaa, 2).

value(bbb, 5).
left(bbb, null).
right(bbb, null).
height(bbb, 0).

value(ccc, 15).
left(ccc, null).
right(ccc, ddd).
height(ccc, 1).

value(ddd, 17).
left(ddd, null).
right(ddd, null).
height(ddd, 0).

value(a, 50).
left(a, b).
right(a, i).
height(a, 3).

value(b, 30).
left(b, c).
right(b, f).
height(b, 2).

value(c, 20).
left(c, d).
right(c, e).
height(c, 1).

value(d, 10).
left(d, null).
right(d, null).
height(d, 0).

value(e, 25).
left(e, null).
right(e, null).
height(e, 0).

value(f, 40).
left(f, g).
right(f, h).
height(f, 1).

value(g, 35).
left(g, null).
right(g, null).
height(g, 0).

value(h, 45).
left(h, null).
right(h, null).
height(h, 0).

value(i, 60).
left(i, j).
right(i, null).
height(i, 1).

value(j, 55).
left(j, null).
right(j, null).
height(j, 0).



diff_lessthanone(A, B):-
    D is A - B, abs(D, AbsD), AbsD =< 1.

my_succ(A, B) :-
    B is A + 1.

my_prev(A, B) :-
    B is A - 1.

% countt(List, T, Count) :-
%     include(=(T), List, Filtered),
%     length(Filtered, Count).

% eval_head(Ex, Inlist, 0, 0, Inlist) :- =(Ex, !), !.
% eval_head(Ex, Inlist, 0, 8, Inlist) :- functor(Ex, P, _), call(Ex), member(P,[equal, diff_lessthanone, min_list, delete, max_list, select, zero, one, minusone, add, minus, my_succ, my_prev, maxnum, minnum, gt_list, lt_list, ord_union, insert, nullptr]), !.
% eval_head(Ex, Inlist, FactV, 0, Outlist) :- clause(Ex, true), call(Ex), append(Inlist, [Ex], Outlist), countt(Outlist, Ex, Cnt), FactV is 1/Cnt, !.


% % eval_head(Ex, 4) :- functor(Ex, P, _), call(Ex), member(P,[diff_lessthanone]), !.

% eval_head(Ex, Inlist, FactV, SpecV, Outlist) :- clause(Ex, RawbodyList), call(RawbodyList), eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist).

% eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist) :- RawbodyList =..BodyList, first_rest(BodyList, ',', Bodyss), first_rest(Bodyss, H, Bodys), eval_head(H, Inlist, FactV0, SpecV0, Inlist1), first_rest(Bodys, Body, _), eval_body(Body, Inlist1, FactV1, SpecV1, Outlist), FactV is FactV0 + FactV1, SpecV is SpecV0 + SpecV1, !.

% eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist) :- RawbodyList =..BodyList, \+ first_rest(BodyList, ',', _), eval_head(RawbodyList, Inlist, FactV, SpecV, Outlist).

% first_rest([Fst|Rst], Fst, Rst).


% scores(Ex, FactNum, AllFactV, Callnum, SpecV) :- eval_head(Ex, [], AllFactV, SpecV, Outlist), length(Outlist, Callnum), list_to_set(Outlist, Outset), length(Outset, FactNum).

% p(A, B):- nullptr(A), minusone(B).
% p(A, G):- right(A,F), left(A,E),p(E,C),p(F,B),maxnum(C,B,D),my_succ(D,G),diff_lessthanone(C,B).