:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	B1 == A2,
	C1 == B2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	A1 == A2,
	C1 == B2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	B1 == B2,
	C1 == A2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	A1 == B2,
	C1 == A2.


:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	C1 == B2,
	C2 == B1.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	C1 == B2,
	C2 == A1.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	C1 == A2,
	C2 == A1.


:-
	body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	B1 == A2,
	A1 == B2.




:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	A1 != A2,
	B1 == B2,
	C1 == C2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	B1 == A2,
	C1 == C2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	B1 != B2,
	C1 == C2,
	A1 == A2.


:-
	body_literal(T, minnum, _, (A1, A2, _)), 
	not A1 > A2.

:-
	body_literal(T, my_prev, _, (X, Y)), 
	body_literal(T, minnum, _, (X, Y, _)).

:-
	body_literal(T, my_prev, _, (X, Y)), 
	body_literal(T, minnum, _, (Y, X, _)).

:-
	body_literal(T, my_succ, _, (X, Y)), 
	body_literal(T, minnum, _, (X, Y, _)).

:-
	body_literal(T, my_succ, _, (X, Y)), 
	body_literal(T, minnum, _, (Y, X, _)).

:-
	body_literal(T, my_succ, _, (A1, A2)),
	body_literal(T, my_succ, _, (A2, A3)),
	body_literal(T, minnum, _, (A1, A3, _)).

:-
	body_literal(T, my_succ, _, (A1, A2)),
	body_literal(T, my_succ, _, (A2, A3)),
	body_literal(T, maxnum, _, (A1, A3, _)).

:-
	body_literal(T, my_prev, _, (A1, A2)),
	body_literal(T, my_prev, _, (A2, A3)),
	body_literal(T, minnum, _, (A1, A3, _)).

:-
	body_literal(T, my_prev, _, (A1, A2)),
	body_literal(T, my_prev, _, (A2, A3)),
	body_literal(T, maxnum, _, (A1, A3, _)).

:-
	body_literal(T, my_succ, _, (A1, A2)),
	body_literal(T, my_succ, _, (A2, A3)),
	body_literal(T, minnum, _, (A3, A1, _)).

:-
	body_literal(T, my_succ, _, (A1, A2)),
	body_literal(T, my_succ, _, (A2, A3)),
	body_literal(T, maxnum, _, (A3, A1, _)).

:-
	body_literal(T, my_prev, _, (A1, A2)),
	body_literal(T, my_prev, _, (A2, A3)),
	body_literal(T, minnum, _, (A3, A1, _)).

:-
	body_literal(T, my_prev, _, (A1, A2)),
	body_literal(T, my_prev, _, (A2, A3)),
	body_literal(T, maxnum, _, (A3, A1, _)).

:-
	body_literal(T, my_succ, _, (A1, A2)),
	body_literal(T, my_prev, _, (A1, A3)),
	body_literal(T, minnum, _, (A2, A3, _)).

:-
	body_literal(T, my_succ, _, (A1, A2)),
	body_literal(T, my_prev, _, (A1, A3)),
	body_literal(T, maxnum, _, (A2, A3, _)).

:-
	body_literal(T, my_succ, _, (A1, A2)),
	body_literal(T, my_prev, _, (A1, A3)),
	body_literal(T, minnum, _, (A3, A2, _)).

:-
	body_literal(T, my_succ, _, (A1, A2)),
	body_literal(T, my_prev, _, (A1, A3)),
	body_literal(T, maxnum, _, (A3, A2, _)).