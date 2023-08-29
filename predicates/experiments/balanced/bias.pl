max_vars(7).
max_body(7).
max_clauses(2).
enable_recursion.

head_pred(p,2).
body_pred(left,2).
body_pred(right,2).
body_pred(anypointer, 1).

not_in(value, 0).
not_in(left, 0).
not_in(right, 0).

body_pred(nullptr,1).
body_pred(zero,1).
body_pred(diff_lessthanone,2).
body_pred(my_succ,2).
body_pred(my_prev,2).
body_pred(maxnum,3).

not_in(nullptr, 1).
not_in(zero, 1).
not_in(diff_lessthanone, 0).
not_in(maxnum, 0).

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


type(p,(pointer,integer)).
type(left,(pointer,pointer)).
type(right,(pointer,pointer)).
type(anypointer,(pointer,)).

type(nullptr,(pointer,)).
type(zero,(integer,)).
type(diff_lessthanone,(integer,integer)).
type(my_succ,(integer,integer)).
type(my_prev,(integer,integer)).
type(maxnum,(integer,integer,integer)).
% type(minnum,(integer,integer,integer)).

type(empty,(set,)).
type(min_list,(set,integer)).
type(max_list,(set,integer)).
type(gt_list,(integer,set)).
type(lt_list,(integer,set)).
type(ord_union,(set,set,set)).
type(insert,(set,integer,set)).


direction(p,(in,out)).
direction(left,(in,out)).
direction(right,(in,out)).
direction(anypointer, (out,)).

direction(nullptr,(out,)).
direction(zero,(out,)).
direction(diff_lessthanone,(in,in)).
direction(my_succ,(in,out)).
direction(my_prev,(in,out)).
direction(maxnum,(in,in,out)).
% direction(minnum,(in,in,out)).

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
	head_literal(1, p, _,(Var,_)),
	not body_literal(1,left,_,(Var,_)).
:-
	#count{A,Vars : body_literal(1,left,A,Vars)} != 1.

:-
    body_literal(T, left, _, (A, B1)),
    body_literal(T, left, _, (A, B2)),
	B1 != B2.

:-
	head_literal(1, p, _,(Var,_)),
	not body_literal(1,right,_,(Var,_)).
:-
	#count{A,Vars : body_literal(1,right,A,Vars)} != 1.

:-
    body_literal(T, right, _, (A, B1)),
    body_literal(T, right, _, (A, B2)),
	B1 != B2.

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

func_head(min_list).
func_head(max_list).
func_head(ord_union).
partial_head(ord_union).
symmetric_head(ord_union).
injective_head(ord_union).




func_head(insert).

:-
    body_literal(T, insert, _, (A1, B1, C1)),
    body_literal(T, insert, _, (A2, B2, C2)),
	C1 == A2,
	B1 == B2.


:-
	body_literal(T, insert, _, (_, _, C)),
	body_literal(T, ord_union, _, (_, C, _)).

:-
	body_literal(T, insert, _, (_, _, C)),
	body_literal(T, ord_union, _, (C, _, _)).

% semantics-based

func_head(maxnum).
partial_head(maxnum).
injective_head(maxnum).
symmetric_head(maxnum).

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
	body_literal(T, my_prev, _, (_, A2)),
	body_literal(T, my_prev, _, (_, A4)),
	body_literal(T, diff_lessthanone, _, (A2, A4)).

:-
	body_literal(T, my_succ, _, (_, A2)),
	body_literal(T, my_succ, _, (_, A4)),
	body_literal(T, diff_lessthanone, _, (A2, A4)).

:-
    body_literal(C, maxnum, _, (_, _, V)),
    #count{P,Vars : body_literal(C,P,_,Vars), var_pos(V, Vars, Pos), direction_(P, Pos, in)} > 1.

func_head(my_prev).
func_head(my_succ).
injective_head(my_succ).
injective_head(my_prev).

:-
	body_literal(T, my_succ, _, (_, A)),
	body_literal(T, my_prev, _, (A, _)).

:-
	body_literal(T, my_prev, _, (_, A)),
	body_literal(T, my_succ, _, (A, _)).

func_head(zero).

:-
	body_literal(T, my_succ, _, (A1, A2)),
	body_literal(T, my_succ, _, (A3, A4)),
	body_literal(T, maxnum, _, (A2, A4, _)).



:-
    body_literal(T, lt_list, _, (V, S1)),
    body_literal(T, min_list, _, (S2, V)),
    body_literal(T, insert, _, (S1, V, S2)).

:-
    body_literal(T, gt_list, _, (V, S1)),
    body_literal(T, max_list, _, (S2, V)),
    body_literal(T, insert, _, (S1, V, S2)).

% semantic-based

:-
	body_literal(T, value, _, (_, B)),
	body_literal(T, my_prev, _, (B, _)).

:-
	body_literal(T, value, _, (_, B)),
	body_literal(T, my_succ, _, (B, _)).

:-
	body_literal(T, insert, _, (_, B, C)),
	body_literal(T, max_list, _, (C, B)).

:-
	body_literal(T, insert, _, (_, B, C)),
	body_literal(T, min_list, _, (C, B)).

% extra, useful if user provides

:-
    body_literal(1,left,_,(A,B)),
    body_literal(1,right,_,(A,B)).

:-
	head_literal(1, p, _, (A, B1)),
	body_literal(1, p, _, (_, B2)),
	not partial_le(1, B2, B1).