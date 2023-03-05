direction(maxnum,(out,in,in)).

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == C2,
	A1 == B2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	C1 == C2,
	A1 == B2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == B2,
	A1 == C2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	C1 == B2,
	A1 == C2.




:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	A2 == B1,
	A1 == B2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	A2 == B1,
	A1 == C2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	A2 == C1,
	A1 == C2.


:-
	body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == C2,
	C1 == B2.




:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	C1 != C2,
	B1 == B2,
	A1 == A2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == C2,
	A1 == A2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 != B2,
	C1 == C2,
	A1 == A2.


:-
	body_literal(T, maxnum, _, (_, A1, A2)), 
	not A1 > A2.

:-
	body_literal(T, my_prev, _, (X, Y)), 
	body_literal(T, maxnum, _, (_, Y, X)).

:-
	body_literal(T, my_prev, _, (X, Y)), 
	body_literal(T, maxnum, _, (_, X, Y)).

:-
	body_literal(T, my_succ, _, (X, Y)), 
	body_literal(T, maxnum, _, (_, Y, X)).

:-
	body_literal(T, my_succ, _, (X, Y)), 
	body_literal(T, maxnum, _, (_, X, Y)).