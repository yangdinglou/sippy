% dll(A, B) :- nullptr(A).
% dll(A, B) :- next(A, C), prev(A, B), dll(C, A).

max_body(3).
max_vars(3).
max_clauses(2).
enable_recursion.
non_datalog.
allow_singletons.

head_pred(dll, 2).
body_pred(nullptr, 1).
body_pred(next, 2).
body_pred(prev, 2).


% direction(dll, (in, out)).
% direction(nullptr, (out, )).
% direction(next, (in, out)).
% direction(prev, (in, out)).

% :-
%     head_literal(0, dll, _, (A, _)),
%     not body_literal(0, next, _, (A,_)).

% :-
% 	#count{A,Vars : body_literal(0,next,A,Vars)} != 1.

% :-
%     head_literal(0, dll, _, (A, _)),
%     not body_literal(0, prev, _, (A,_)).

% :-
% 	#count{A,Vars : body_literal(0,prev,A,Vars)} != 1.

:-
	#count{A,Vars : body_literal(0,nullptr,A,Vars)} == 0.


:-
    head_literal(1, dll, _, (A, _)),
    not body_literal(1, next, _, (A,_)).

:-
	#count{A,Vars : body_literal(1,next,A,Vars)} != 1.

:-
    head_literal(1, dll, _, (A, _)),
    not body_literal(1, prev, _, (A,_)).

:-
	#count{A,Vars : body_literal(1,prev,A,Vars)} != 1.

% :-
%     body_literal(T, next, _, (A, B)),
%     body_literal(T, prev, _, (A, B)).