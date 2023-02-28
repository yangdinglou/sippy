empty([]).
nullptr(null).
zero(0).
one(1).

maxnum(A, B, C) :-
    A is max(B, C).

minnum(A, B, C) :-
    A is min(B, C).

add(A, B, C) :-
    A is B + C.

minus(A, B, C) :-
    A is B - C.

insert(A, B, C) :-
    union([B], C, A).
% insert(A, B, C) :-
%     member(B, A), A = C.

% insert(A, B, C) :-
%     select(B, A, C).

% reverse_union(A, B, C) :-
%     subtract(A, B, D), D = C.