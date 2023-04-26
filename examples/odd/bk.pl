%% :-table (f/2) as incremental.
%% :-dynamic([f/2], [incremental(true)]).



succ(A,B):-
    B is A+1.

prev(A,B):-
    B is A-1.   

zero(0).

% odd(1).
% odd(3).
% odd(5).
% odd(7).
% odd(9).

% even(2).
% even(4).
% even(6).
% even(8).
% even(10).

% even(X):- zero(X).
% even(X):- prev(X, Y), odd(Y).
% odd(X):- prev(X, Y), even(Y).