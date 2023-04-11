% skiplist(X, P) :- equal(X, P), !.
% skiplist(X, P) :- down(X, Y), equal(X, Y), forward(X, Z), equal(Z, P), !.
% skiplist(X, P) :- down(X, Y), forward(X, Z), down(Z, ZD), skiplist(Z, P), skiplist(Y, ZD).


max_vars(5).
max_body(5).
max_clauses(3).
enable_recursion.

head_pred(skiplist,2).
body_pred(forward,2).
body_pred(down,2).
body_pred(equal,2).

type(skiplist,(pointer,pointer)).
type(forward,(pointer,pointer)).
type(down,(pointer,pointer)).
type(equal,(pointer,pointer)).

direction(skiplist,(in,in)).
direction(forward,(in,out)).
direction(down,(in,out)).
direction(equal,(out,out)).

% :-
%     body_literal(T, down, _, (X, _)),
%     not head_literal(T, skiplist, _, (X, _)).

% :-
%     body_literal(T, forward, _, (X, _)),
%     not head_literal(T, skiplist, _, (X, _)).



:-
    #count{P,Vars : body_literal(0,P,_,Vars)} != 1.

:-
	not body_literal(0,equal,_,_).

:-
    not clause(1).
:-
    not clause(2).

:-
    head_literal(1,skiplist,_,(X, _)),
    not body_literal(1,down,_,(X, _)).

:-
    head_literal(1,skiplist,_,(X, _)),
    not body_literal(1,forward,_,(X, _)).

:-
    head_literal(2,skiplist,_,(X, _)),
    not body_literal(2,down,_,(X, _)).

:-
    head_literal(2,skiplist,_,(X, _)),
    not body_literal(2,forward,_,(X, _)).

% :-
%     #count{A,Vars : body_literal(2,skiplist,A,Vars)} != 2.

% :-
%     #count{A,Vars : body_literal(1,down,A,Vars)} != 1.

% :-
%     #count{A,Vars : body_literal(1,forward,A,Vars)} != 1.

% :-
%     #count{A,Vars : body_literal(2,down,A,Vars)} != 2.

% :-
%     #count{A,Vars : body_literal(2,forward,A,Vars)} != 1.

:-
    body_literal(T, equal, _, (A, B)),
    A < B.

:-
    body_literal(T, down, _, (A, B)),
    body_literal(T, down, _, (A, C)),
    B != C.

:-
    body_literal(T, skiplist, _, (A, B)),
    body_literal(T, skiplist, _, (A, C)),
    B != C.