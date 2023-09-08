
red(0).
black(1).

left(p1, p2).
left(p2, null).
left(p3, p5).
left(p4, null).
left(p5, null).
left(p6, null).
left(p7, null).
left(p8, null).


right(p1, p3).
right(p2, p4).
right(p3, p6).
right(p4, null).
right(p5, p7).
right(p6, p8).
right(p7, null).
right(p8, null).

color(p1, 1).
color(p2, 1).
color(p3, 0).
color(p4, 0).
color(p5, 1).
color(p6, 1).
color(p7, 0).
color(p8, 0).


left(pp1, pp3).
left(pp2, null).
left(pp3, pp5).
left(pp4, null).
left(pp5, null).
left(pp6, null).
left(pp7, null).
left(pp8, null).


right(pp1, pp2).
right(pp2, pp4).
right(pp3, pp6).
right(pp4, null).
right(pp5, pp7).
right(pp6, pp8).
right(pp7, null).
right(pp8, null).

color(pp1, 1).
color(pp2, 1).
color(pp3, 0).
color(pp4, 0).
color(pp5, 1).
color(pp6, 1).
color(pp7, 0).
color(pp8, 0).

nullptr(null).

anycolor(0).
anycolor(1).


% rbt(null, 1, 0).

% rbt(X, Col) :- nullptr(X), black(Col).
% rbt(X, Col) :- left(X, L), right(X, R), color(X, Col), inv1(L, R, Col).

% inv1(L, R, Col) :- red(Col), black(C), rbt(L, C), rbt(R, C).

% inv1(L, R, Col) :- black(Col), rbt(L, C1), rbt(R, C2), anycolor(C1), anycolor(C2).



% rbt(A,B):- nullptr(A),black(B), !.
% rbt(A,B):- right(A,C),color(A,B),left(A,D),inv1(D,C,B), !.
% inv1(A,B,C):- red(C),rbt(B,D),rbt(A,D),black(D), !.
% inv1(A,B,C):- black(C),rbt(A,D),anycolor(D),rbt(B,E),anycolor(E), !.

% countt(List, T, Count) :-
%     include(=(T), List, Filtered),
%     length(Filtered, Count).

% eval_head(Ex, Inlist, 0, 0, Inlist) :- =(Ex, !), !.

% eval_head(Ex, Inlist, 0, -10, Inlist) :- functor(Ex, P, _), call(Ex), member(P,[anypointer, anycolor, anynumber]), !.
% eval_head(Ex, Inlist, 0, 4, Inlist) :- functor(Ex, P, _), call(Ex), member(P,[diff_lessthanone,ge,le]), !.
% eval_head(Ex, Inlist, 0, 8, Inlist) :- functor(Ex, P, _), call(Ex), member(P,[equal, min_list, delete, max_list, select, zero, one, minusone, add, minus, my_succ, my_prev, same_ptr, maxnum, minnum, gt_list, lt_list, ord_union, insert, nullptr, empty, add, black, red]), !.
% eval_head(Ex, Inlist, FactV, 0, Outlist) :- clause(Ex, true), call(Ex), append(Inlist, [Ex], Outlist), countt(Outlist, Ex, Cnt), FactV is 1/Cnt, !.

% eval_head(Ex, Inlist, FactV, SpecV, Outlist) :- clause(Ex, RawbodyList), call(RawbodyList), eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist).

% eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist) :- RawbodyList =..BodyList, first_rest(BodyList, ',', Bodyss), first_rest(Bodyss, H, Bodys), eval_head(H, Inlist, FactV0, SpecV0, Inlist1), first_rest(Bodys, Body, _), eval_body(Body, Inlist1, FactV1, SpecV1, Outlist), FactV is FactV0 + FactV1, SpecV is SpecV0 + SpecV1, !.

% eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist) :- RawbodyList =..BodyList, \+ first_rest(BodyList, ',', _), eval_head(RawbodyList, Inlist, FactV, SpecV, Outlist).

% first_rest([Fst|Rst], Fst, Rst).


% scores(Ex, FactNum, AllFactV, Callnum, SpecV) :- eval_head(Ex, [], AllFactV, SpecV, Outlist), length(Outlist, Callnum), list_to_set(Outlist, Outset), length(Outset, FactNum).


% rbt(A,B):- nullptr(A),red(B), !.
% inv1(A,B,C):- left(A,D),rbt(B,C),rbt(D,C), !.
% rbt(A,B):- color(A,B),left(A,C),right(A,D),inv1(D,C,B), !.
% inv1(A,B,C):- red(E),rbt(B,E),black(C),left(A,D),rbt(D,E), !.