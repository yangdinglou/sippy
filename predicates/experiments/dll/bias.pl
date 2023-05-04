% dll(A, B) :- nullptr(A).
% dll(A, B) :- next(A, C), prev(A, B), dll(C, A).

max_body(5).
max_vars(6).
max_clauses(2).
enable_recursion.

head_pred(dll, 3).
body_pred(next, 2).
body_pred(prev, 2).
body_pred(key, 2).
body_pred(anypointer, 1).

body_pred(nullptr,1).
body_pred(zero,1).
body_pred(diff_lessthanone,2).
body_pred(my_succ,2).
body_pred(my_prev,2).
body_pred(maxnum,3).
body_pred(minnum,3).


body_pred(empty,1).
body_pred(min_list,2).
body_pred(max_list,2).
body_pred(gt_list,2).
body_pred(lt_list,2).
body_pred(ord_union,3).
body_pred(insert,3).

type(dll,(pointer,pointer,set)).
type(next,(pointer,pointer)).
type(prev,(pointer,pointer)).
type(key, (pointer, integer)).
type(anypointer,(pointer,)).

type(nullptr,(pointer,)).
type(zero,(integer,)).
type(diff_lessthanone,(integer,integer)).
type(my_succ,(integer,integer)).
type(my_prev,(integer,integer)).
type(maxnum,(integer,integer,integer)).
type(minnum,(integer,integer,integer)).

type(empty,(set,)).
type(min_list,(set,integer)).
type(max_list,(set,integer)).
type(gt_list,(integer,set)).
type(lt_list,(integer,set)).
type(ord_union,(set,set,set)).
type(insert,(set,integer,set)).

direction(dll, (in, out, out)).
direction(next, (in, out)).
direction(prev, (in, out)).
direction(key, (in, out)).
direction(anypointer, (out,)).

direction(nullptr,(out,)).
direction(zero,(out,)).
direction(diff_lessthanone,(in,in)).
direction(my_succ,(in,out)).
direction(my_prev,(in,out)).
direction(maxnum,(in,in,out)).
direction(minnum,(in,in,out)).

direction(empty,(out,)).
direction(min_list,(in,in)).
direction(max_list,(in,in)).
direction(gt_list,(in,in)).
direction(lt_list,(in,in)).
direction(ord_union,(in,in,out)).
direction(insert,(in,in,out)).


:-
	#count{A,Vars : body_literal(0,nullptr,A,Vars)} == 0.

:-
	#count{A,Var : body_literal(0,nullptr,A,(Var,)), head_var(0, Var)} == 0.

:-
    body_literal(T, nullptr, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.


:-
    head_literal(1, dll, 3, (Var,_,_)),
    not body_literal(1, key, _, (Var,_)).
:-
    #count{A, Vars: body_literal(1, key, A, Vars)} != 1.
:-
    body_literal(T, key, _, (A, B1)),
    body_literal(T, key, _, (A, B2)),
    B1 != B2.


:-
    head_literal(1, dll, 3, (Var,_,_)),
    not body_literal(1, next, _, (Var,_)).
:-
    #count{A, Vars: body_literal(1, next, A, Vars)} != 1.
:-
    body_literal(T, next, _, (A, B1)),
    body_literal(T, next, _, (A, B2)),
    B1 != B2.


:-
    head_literal(1, dll, 3, (Var,_,_)),
    not body_literal(1, prev, _, (Var,_)).
:-
    #count{A, Vars: body_literal(1, prev, A, Vars)} != 1.
:-
    body_literal(T, prev, _, (A, B1)),
    body_literal(T, prev, _, (A, B2)),
    B1 != B2.

:-
    body_literal(T, anypointer, _, (A,)),
    not head_var(T, A).
:-
    body_literal(T, anypointer, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.

% :-
%     body_literal(T, next, _, (A, B)),
%     body_literal(T, prev, _, (A, B)).

:-
	#count{P,A,Vars : body_literal(0,P,A,Vars)} > 3.
:-
    not clause(1).


:-
    body_literal(1,lt_list,_,(A,B)),
    body_literal(1,gt_list,_,(A,B)).

:-
    body_literal(T, min_list, _, (A, B1)),
    body_literal(T, min_list, _, (A, B2)),
	B1 != B2.

:-
    body_literal(T, max_list, _, (A, B1)),
    body_literal(T, max_list, _, (A, B2)),
	B1 != B2.

:-
    body_literal(T, ord_union, _, (A1, B1, C1)),
    body_literal(T, ord_union, _, (A2, B2, C2)),
	B1 == A2,
	C1 == B2.

:-
    body_literal(T, ord_union, _, (A1, B1, C1)),
    body_literal(T, ord_union, _, (A2, B2, C2)),
	A1 == A2,
	C1 == B2.

:-
    body_literal(T, ord_union, _, (A1, B1, C1)),
    body_literal(T, ord_union, _, (A2, B2, C2)),
	B1 == B2,
	C1 == A2.

:-
    body_literal(T, ord_union, _, (A1, B1, C1)),
    body_literal(T, ord_union, _, (A2, B2, C2)),
	A1 == B2,
	C1 == A2.


:-
    body_literal(T, ord_union, _, (A1, B1, C1)),
    body_literal(T, ord_union, _, (A2, B2, C2)),
	C1 == B2,
	C2 == B1.

:-
    body_literal(T, ord_union, _, (A1, B1, C1)),
    body_literal(T, ord_union, _, (A2, B2, C2)),
	C1 == B2,
	C2 == A1.

:-
    body_literal(T, ord_union, _, (A1, B1, C1)),
    body_literal(T, ord_union, _, (A2, B2, C2)),
	C1 == A2,
	C2 == A1.


:-
	body_literal(T, ord_union, _, (A1, B1, C1)),
	not A1 > B1.



:-
    body_literal(T, ord_union, _, (A1, B1, C1)),
    body_literal(T, ord_union, _, (A2, B2, C2)),
	A1 != A2,
	B1 == B2,
	C1 == C2.

:-
    body_literal(T, ord_union, _, (A1, B1, C1)),
    body_literal(T, ord_union, _, (A2, B2, C2)),
	B1 == A2,
	C1 == C2.

:-
    body_literal(T, ord_union, _, (A1, B1, C1)),
    body_literal(T, ord_union, _, (A2, B2, C2)),
	B1 != B2,
	C1 == C2,
	A1 == A2.

:-
	body_literal(T, ord_union, _, (A1, A2, _)), 
	not A1 > A2.

:-
    body_literal(T, insert, _, (A1, B1, C1)),
    body_literal(T, insert, _, (A2, B2, C2)),
	A1 == A2,
	B1 == B2,
	C1 != C2.

:-
    body_literal(T, insert, _, (A1, B1, C1)),
    body_literal(T, insert, _, (A2, B2, C2)),
	C1 == A2,
	B1 == B2.

:-
	body_literal(T, empty, _, (A1,)),
	body_literal(T, ord_union, _, (A2, B2, C2)),
	A1 == A2.
:-
	body_literal(T, empty, _, (A1,)),
	body_literal(T, ord_union, _, (A2, B2, C2)),
	A1 == B2.

:- 
	body_literal(T, empty, _, (A1,)),
	body_literal(T, gt_list, _, (A2, B2)),
	A1 == B2.

:- 
	body_literal(T, empty, _, (A1,)),
	body_literal(T, lt_list, _, (A2, B2)),
	A1 == B2.

:- 
	body_literal(T, empty, _, (A1,)),
	body_literal(T, min_list, _, (A2, B2)),
	A1 == A2.

:- 
	body_literal(T, empty, _, (A1,)),
	body_literal(T, max_list, _, (A2, B2)),
	A1 == A2.

:-
	body_literal(T, empty, _, (A1,)),
	body_literal(T, insert, _, (A1, V, A2)),
	body_literal(T, max_list, _, (A2, V)).

:-
	body_literal(T, empty, _, (A1,)),
	body_literal(T, insert, _, (A1, V, A2)),
	body_literal(T, min_list, _, (A2, V)).



:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == A2,
	C1 == B2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	A1 == A2,
	C1 == B2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == B2,
	C1 == A2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	A1 == B2,
	C1 == A2.




:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	C1 == B2,
	C2 == B1.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	C1 == B2,
	C2 == A1.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	C1 == A2,
	C2 == A1.


:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	A1 != A2,
	B1 == B2,
	C1 == C2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == A2,
	C1 == C2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 != B2,
	C1 == C2,
	A1 == A2.

:-
	body_literal(T, maxnum, _, (A1, A2, _)), 
	not A1 > A2.




:-
	body_literal(T, diff_lessthanone, _, (A1, A2)), 
	not A1 > A2.

:-
	body_literal(T, diff_lessthanone, _, (A1, A2)),
	body_literal(T, maxnum, _, (A1, _, A2)).

:-
	body_literal(T, diff_lessthanone, _, (A1, A2)),
	body_literal(T, maxnum, _, (A2, _, A1)).

:-
	body_literal(T, diff_lessthanone, _, (A1, A2)),
	body_literal(T, maxnum, _, (_, A1, A2)).

:-
	body_literal(T, diff_lessthanone, _, (A1, A2)),
	body_literal(T, maxnum, _, (_, A2, A1)).

:-
	body_literal(T, diff_lessthanone, _, (A1, A2)),
	body_literal(T, minnum, _, (A1, _, A2)).

:-
	body_literal(T, diff_lessthanone, _, (A1, A2)),
	body_literal(T, minnum, _, (A2, _, A1)).

:-
	body_literal(T, diff_lessthanone, _, (A1, A2)),
	body_literal(T, minnum, _, (_, A1, A2)).

:-
	body_literal(T, diff_lessthanone, _, (A1, A2)),
	body_literal(T, minnum, _, (_, A2, A1)).


:-
	body_literal(T, my_prev, _, (A1, A2)), 
	body_literal(T, diff_lessthanone, _, (A1, A2)).

:-
	body_literal(T, my_prev, _, (A1, A2)), 
	body_literal(T, diff_lessthanone, _, (A2, A1)).

:-
	body_literal(T, my_succ, _, (A1, A2)), 
	body_literal(T, diff_lessthanone, _, (A1, A2)).

:-
	body_literal(T, my_succ, _, (A1, A2)), 
	body_literal(T, diff_lessthanone, _, (A2, A1)).


:-
	body_literal(T, my_prev, _, (X, Y)), 
	body_literal(T, maxnum, _, (X, Y, _)).

:-
	body_literal(T, my_prev, _, (X, Y)), 
	body_literal(T, maxnum, _, (Y, X, _)).

:-
	body_literal(T, my_succ, _, (X, Y)), 
	body_literal(T, maxnum, _, (X, Y, _)).

:-
	body_literal(T, my_succ, _, (X, Y)), 
	body_literal(T, maxnum, _, (Y, X, _)).

:-
	body_literal(T, my_succ, _, (A1, B1)),
	body_literal(T, my_succ, _, (A2, B2)),
	B1 == B2,
	A1 != A2.

:-
    body_literal(T, min_list, _, (A, B1)),
    body_literal(T, min_list, _, (A, B2)),
	B1 != B2.

:-
    body_literal(T, my_prev, _, (A, B1)),
    body_literal(T, my_prev, _, (A, B2)),
	B1 != B2.

:-
    body_literal(T, my_succ, _, (A, B1)),
    body_literal(T, my_succ, _, (A, B2)),
	B1 != B2.

:-
	body_literal(T, my_succ, _, (A1, B)),
	body_literal(T, my_succ, _, (A2, B)),
	A1 != A2.

:-
	body_literal(T, my_prev, _, (A1, B)),
	body_literal(T, my_prev, _, (A2, B)),
	A1 != A2.

:-
	body_literal(T, my_succ, _, (_, A)),
	body_literal(T, my_prev, _, (A, _)).

:-
	body_literal(T, my_prev, _, (_, A)),
	body_literal(T, my_succ, _, (A, _)).


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


:-
	body_literal(T, maxnum, _, (A1, B1, C1)),
	body_literal(T, my_succ, _, (C1, B2)),
	body_literal(T, maxnum, _, (A1, B2, _)).

:-
	body_literal(T, maxnum, _, (A1, B1, C1)),
	body_literal(T, my_succ, _, (C1, B2)),
	body_literal(T, maxnum, _, (B1, B2, _)).

:-
	body_literal(T, maxnum, _, (A1, B1, C1)),
	body_literal(T, my_succ, _, (C1, B2)),
	body_literal(T, maxnum, _, (B2, A1, _)).

:-
	body_literal(T, maxnum, _, (A1, B1, C1)),
	body_literal(T, my_succ, _, (C1, B2)),
	body_literal(T, maxnum, _, (B2, B1, _)).

:-
	body_literal(T, minnum, _, (A1, B1, C1)),
	body_literal(T, my_prev, _, (C1, B2)),
	body_literal(T, minnum, _, (A1, B2, _)).

:-
	body_literal(T, minnum, _, (A1, B1, C1)),
	body_literal(T, my_prev, _, (C1, B2)),
	body_literal(T, minnum, _, (B1, B2, _)).

:-
	body_literal(T, minnum, _, (A1, B1, C1)),
	body_literal(T, my_prev, _, (C1, B2)),
	body_literal(T, minnum, _, (B2, A1, _)).

:-
	body_literal(T, minnum, _, (A1, B1, C1)),
	body_literal(T, my_prev, _, (C1, B2)),
	body_literal(T, minnum, _, (B2, B1, _)).


:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	B1 == A2,
	C1 == B2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	A1 == A2,
	C1 == B2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	B1 == B2,
	C1 == A2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	A1 == B2,
	C1 == A2.


:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	C1 == B2,
	C2 == B1.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	C1 == B2,
	C2 == A1.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	C1 == A2,
	C2 == A1.


:-
	body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	B1 == A2,
	A1 == B2.





:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == A2,
	C1 == B2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	A1 == A2,
	C1 == B2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == B2,
	C1 == A2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	A1 == B2,
	C1 == A2.


:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	C1 == B2,
	C2 == B1.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	C1 == B2,
	C2 == A1.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	C1 == A2,
	C2 == A1.


:-
	body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == A2,
	A1 == B2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == B2,
	C1 == C2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	B1 == A2,
	C1 == C2.

:-
    body_literal(T, maxnum, _, (A1, B1, C1)),
    body_literal(T, minnum, _, (A2, B2, C2)),
	B1 == A2,
	C1 == C2.

:-
    body_literal(T, minnum, _, (A1, B1, C1)),
    body_literal(T, maxnum, _, (A2, B2, C2)),
	C1 == C2,
	A1 == A2.

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, maxnum, _, (A1, A2, _)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, minnum, _, (A1, A2, _)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, diff_lessthanone, _, (A2, A1)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_prev, _, (A1, A3)),
	body_literal(T, maxnum, _, (A2, A3, _)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_prev, _, (A1, A3)),
	body_literal(T, minnum, _, (A2, A3, _)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_prev, _, (A1, A3)),
	body_literal(T, diff_lessthanone, _, (A2, A3)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_succ, _, (A1, A3)),
	body_literal(T, maxnum, _, (A2, A3, _)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_succ, _, (A1, A3)),
	body_literal(T, minnum, _, (A2, A3, _)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_succ, _, (A1, A3)),
	body_literal(T, diff_lessthanone, _, (A2, A3)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_prev, _, (A1, A3)),
	body_literal(T, maxnum, _, (A3, A2, _)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_prev, _, (A1, A3)),
	body_literal(T, minnum, _, (A3, A2, _)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_prev, _, (A1, A3)),
	body_literal(T, diff_lessthanone, _, (A3, A2)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_succ, _, (A1, A3)),
	body_literal(T, maxnum, _, (A3, A2, _)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_succ, _, (A1, A3)),
	body_literal(T, minnum, _, (A3, A2, _)).

:-
	body_literal(T, zero, _, (A1,)),
	body_literal(T, zero, _, (A2, )),
	body_literal(T, my_succ, _, (A1, A3)),
	body_literal(T, diff_lessthanone, _, (A3, A2)).



:-
    body_literal(T, lt_list, _, (V, S1)),
    body_literal(T, min_list, _, (S2, V)),
    body_literal(T, insert, _, (S1, V, S2)).

:-
    body_literal(T, gt_list, _, (V, S1)),
    body_literal(T, max_list, _, (S2, V)),
    body_literal(T, insert, _, (S1, V, S2)).