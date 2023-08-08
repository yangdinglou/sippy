max_vars(10).
max_body(11).
max_clauses(2).
enable_recursion.

head_pred(p,2).
body_pred(value,2).
body_pred(left,2).
body_pred(right,2).

not_in(value, 0).
not_in(left, 0).
not_in(right, 0).

body_pred(anypointer, 1).
body_pred(nullptr,1).
body_pred(zero,1).
body_pred(diff_lessthanone,2).
body_pred(my_succ,2).
body_pred(my_prev,2).
body_pred(maxnum,3).
body_pred(minnum,3).

not_in(nullptr, 1).
not_in(zero, 1).
not_in(diff_lessthanone, 0).
not_in(maxnum, 0).
not_in(minnum, 0).

body_pred(empty,1).
body_pred(min_list,2).
body_pred(max_list,2).
body_pred(gt_list,2).
body_pred(lt_list,2).
body_pred(ord_union,3).
body_pred(insert,3).

not_in(empty, 1).
not_in(min_list, 0).
not_in(max_list, 0).
not_in(gt_list, 0).
not_in(lt_list, 0).
not_in(ord_union, 0).
not_in(insert, 0).



type(p,(pointer,set)).
type(value,(pointer,integer)).
type(left,(pointer,pointer)).
type(right,(pointer,pointer)).

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


direction(p,(in,out)).
direction(value,(in,out)).
direction(left,(in,out)).
direction(right,(in,out)).

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
    body_literal(T, anypointer, _, (A,)),
    not head_var(T, A).
:-
    body_literal(T, anypointer, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.

:-
	#count{A,Vars : body_literal(0,nullptr,A,Vars)} == 0.

:-
	#count{A,Var : body_literal(0,nullptr,A,(Var,)), head_var(0, Var)} == 0.

:-
    body_literal(T, nullptr, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.

:-
	#count{P,A,Vars : body_literal(0,P,A,Vars)} > 3.
:-
    not clause(1).


:-
    body_literal(1,lt_list,_,(A,B)),
    body_literal(1,gt_list,_,(A,B)).

exclusive_head(gt_list, lt_list).



func_head(min_list).




func_head(max_list).

func_head(ord_union).

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


partial_head(ord_union).

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

% More on partial order


:-
	body_literal(T, ord_union, _, (A1, B1, C1)),
	not A1 > B1.

symmetric_head(ord_union).



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

injective_head(ord_union).

:-
	body_literal(T, ord_union, _, (A1, A2, _)), 
	not A1 > A2.



func_head(insert).

:-
    body_literal(T, insert, _, (A1, B1, C1)),
    body_literal(T, insert, _, (A2, B2, C2)),
	C1 == A2,
	B1 == B2.

partial_head(insert).

:-
	body_literal(T, empty, _, (A1,)),
	body_literal(T, ord_union, _, (A2, B2, C2)),
	A1 == A2.
:-
	body_literal(T, empty, _, (A1,)),
	body_literal(T, ord_union, _, (A2, B2, C2)),
	A1 == B2.

% the buttom of partial order

:-
	body_literal(T, insert, _, (A, _, C)),
	body_literal(T, ord_union, _, (A, C, _)).

:-
	body_literal(T, insert, _, (A, _, C)),
	body_literal(T, ord_union, _, (C, A, _)).

% more on partial

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

% The semantic-specific

:-
	body_literal(T, empty, _, (A1,)),
	body_literal(T, insert, _, (A1, V, A2)),
	body_literal(T, max_list, _, (A2, V)).

:-
	body_literal(T, empty, _, (A1,)),
	body_literal(T, insert, _, (A1, V, A2)),
	body_literal(T, min_list, _, (A2, V)).

% Just avoid the empty list?

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

partial_head(maxnum).


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

% More on partial order

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

injective_head(maxnum).

:-
	body_literal(T, maxnum, _, (A1, A2, _)), 
	not A1 > A2.

symmetric_head(maxnum).


:-
	body_literal(T, diff_lessthanone, _, (A1, A2)), 
	not A1 > A2.

symmetric_head(diff_lessthanone).

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

% semantic-based

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

% partial_head(my_succ).
% partial_head(my_prev).

:-
	body_literal(T, my_succ, _, (A1, B1)),
	body_literal(T, my_succ, _, (A2, B2)),
	B1 == B2,
	A1 != A2.

injective_head(my_succ).





func_head(my_prev).



func_head(my_succ).

:-
	body_literal(T, my_succ, _, (A1, B)),
	body_literal(T, my_succ, _, (A2, B)),
	A1 != A2.

injective_head(my_succ).

:-
	body_literal(T, my_prev, _, (A1, B)),
	body_literal(T, my_prev, _, (A2, B)),
	A1 != A2.

injective_head(my_prev).

:-
	body_literal(T, my_succ, _, (_, A)),
	body_literal(T, my_prev, _, (A, _)).

:-
	body_literal(T, my_prev, _, (_, A)),
	body_literal(T, my_succ, _, (A, _)).

% semantic-based

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

partial_head(minnum).

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

% More on partial




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

injective_head(minnum).

:-
	body_literal(T, minnum, _, (A1, A2, _)), 
	not A1 > A2.

symmetric_head(minnum).

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

% Partial partial, more on partial

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

% Partial partial, more on partial

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

% Still

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

% TODO!

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
	body_literal(T, my_succ, _, (A1, A2)),
	body_literal(T, my_succ, _, (A3, A4)),
	body_literal(T, maxnum, _, (A2, A4, _)).

:-
	body_literal(T, my_prev, _, (A1, A2)),
	body_literal(T, my_prev, _, (A3, A4)),
	body_literal(T, minnum, _, (A2, A4, _)).

:-
    body_literal(T, lt_list, _, (V, S1)),
    body_literal(T, min_list, _, (S2, V)),
    body_literal(T, insert, _, (S1, V, S2)).

:-
    body_literal(T, gt_list, _, (V, S1)),
    body_literal(T, max_list, _, (S2, V)),
    body_literal(T, insert, _, (S1, V, S2)).

% semantic-based