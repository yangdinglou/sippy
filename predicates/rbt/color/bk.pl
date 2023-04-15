
red(0).
black(1).
zero(0).

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

nullptr(null).

anycolor(0).
anycolor(1).

my_succ(A, B) :-
    B is A + 1.

my_prev(A, B) :-
    B is A - 1.

% rbt(null, 1, 0).

% rbt(X, Col) :- nullptr(X), black(Col).
% rbt(X, Col) :- left(X, L), right(X, R), color(X, Col), inv1(L, R, Col).

% inv1(L, R, Col) :- red(Col), black(C), rbt(L, C), rbt(R, C).

% inv1(L, R, Col) :- black(Col), rbt(L, C1), rbt(R, C2), anycolor(C1), anycolor(C2).