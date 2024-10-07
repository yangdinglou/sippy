max_vars(10).

max_clauses(2).
enable_recursion.

head_pred(p,3).
type(p,(pointer,pointer,set)).

input_pointer(left,pointer).
input_pointer(right,pointer).
input_pointer(back,pointer).
input_pointer(value,integer).

exclusive_head(left,right).
exclusive_head(left,back).
exclusive_head(right,back).
recur_num(2).

body_pred(anypointer, 1):- not unopt.
body_pred(anynumber, 1):- not unopt.
body_pred(nullptr,1).
body_pred(zero,1):-inv_pure(integer).
body_pred(diff_lessthanone,2):-inv_pure(integer).
body_pred(my_succ,2):-inv_pure(integer).
body_pred(my_prev,2):-inv_pure(integer).
body_pred(maxnum,3):-inv_pure(integer).
body_pred(same_ptr,2).
not_in(anypointer, 1).
not_in(anypointer, 3):-enable_pi.
not_in(nullptr, 1).
not_in(nullptr, 3):-enable_pi.
not_in(zero, 1).
not_in(zero, 3):-enable_pi.
not_in(diff_lessthanone, 0).
not_in(diff_lessthanone, 2):-enable_pi.
not_in(maxnum, 0).
not_in(maxnum, 2):-enable_pi.
not_in(same_ptr, 1).
not_in(same_ptr, 3):-enable_pi.

body_pred(empty,1):-inv_pure(set).
body_pred(gt_set,2):-inv_pure(set).
body_pred(lt_set,2):-inv_pure(set).
body_pred(ord_union,3):-inv_pure(set).
body_pred(insert,3):-inv_pure(set).

body_pred(nil,1):-inv_pure(list).
body_pred(gt_list,2):-inv_pure(list).
body_pred(lt_list,2):-inv_pure(list).
body_pred(append,3):-inv_pure(list).
body_pred(cons,3):-inv_pure(list).

not_in(empty, 1).
not_in(empty, 3):-enable_pi.
not_in(gt_set, 0).
not_in(gt_set, 2):-enable_pi.
not_in(lt_set, 0).
not_in(lt_set, 2):-enable_pi.
not_in(ord_union, 0).
not_in(ord_union, 2):-enable_pi.
not_in(insert, 0).
not_in(insert, 2):-enable_pi.

not_in(nil, 1).
not_in(nil, 3):-enable_pi.
not_in(gt_list, 0).
not_in(gt_list, 2):-enable_pi.
not_in(lt_list, 0).
not_in(lt_list, 2):-enable_pi.
not_in(append, 0).
not_in(append, 2):-enable_pi.
not_in(cons, 0).
not_in(cons, 2):-enable_pi.

type(anypointer,(pointer,)).
type(anynumber,(integer,)).
type(nullptr,(pointer,)).
type(zero,(integer,)).
type(diff_lessthanone,(integer,integer)).
type(my_succ,(integer,integer)).
type(my_prev,(integer,integer)).
type(maxnum,(integer,integer,integer)).
type(same_ptr,(pointer,pointer)).


type(empty,(set,)).
type(gt_set,(integer,set)).
type(lt_set,(integer,set)).
type(ord_union,(set,set,set)).
type(insert,(set,integer,set)).

type(nil,(list,)).
type(gt_list,(integer,list)).
type(lt_list,(integer,list)).
type(append,(list,list,list)).
type(cons,(list,integer,list)).




direction(anypointer, (in,)).
direction(anynumber, (in,)).
direction(nullptr,(in,)).
direction(zero,(out,)).
direction(diff_lessthanone,(in,in)).
direction(my_succ,(in,out)).
direction(my_prev,(in,out)).
direction(maxnum,(in,in,out)).
direction(same_ptr,(in,in)).


direction(empty,(out,)).
direction(gt_set,(in,in)).
direction(lt_set,(in,in)).
direction(ord_union,(in,in,out)).
direction(insert,(in,in,out)).

direction(nil,(out,)).
direction(lt_list,(in,in)).
direction(gt_list,(in,in)).
direction(append,(in,in,out)).
direction(cons,(in,in,out)).

 
:-
    body_literal(T, anypointer, _, (A,)),
    not head_var(T, A).

:-
    body_literal(T, anypointer, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.

:-
    body_literal(T, anynumber, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.

:-
	body_literal(T, my_succ, _, (_, A)),
	body_literal(T, anynumber, _, (A,)).

:-
	body_literal(T, my_prev, _, (_, A)),
	body_literal(T, anynumber, _, (A,)).

:-
	body_literal(T, maxnum, _, (_,_, A)),
	body_literal(T, anynumber, _, (A,)).

:-
	body_literal(T, zero, _, (A,)),
	body_literal(T, anynumber, _, (A,)).




:-
	#count{P,A,Vars : body_literal(0,P,A,Vars)} > 3.



func_head(ord_union).
partial_head(ord_union).
symmetric_head(ord_union).
injective_head(ord_union).

func_head(append).
injective_head(append).

injective_head(ord_union).

symmetric_head(same_ptr).


func_head(insert).
func_head(cons).

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


% semantic-based

:-
	body_literal(T, my_succ, _, (_, A)),
	body_literal(T, gt_set, _, (A, _)).

:-
	body_literal(T, my_prev, _, (_, A)),
	body_literal(T, lt_set, _, (A, _)).

:-
	body_literal(T, my_succ, _, (_, A)),
	body_literal(T, gt_list, _, (A, _)).

:-
	body_literal(T, my_prev, _, (_, A)),
	body_literal(T, lt_list, _, (A, _)).


:-
	body_literal(T, insert, _, (_, B, C)),
	body_literal(T, gt_set, _, (B, C)).

:-
	body_literal(T, insert, _, (_, B, C)),
	body_literal(T, lt_set, _, (B, C)).


:-
	body_literal(T, cons, _, (_, B, C)),
	body_literal(T, gt_list, _, (B, C)).

:-
	body_literal(T, cons, _, (_, B, C)),
	body_literal(T, lt_list, _, (B, C)).

:-
	body_literal(T, lt_list, _, (_, C)),
	repeat_in_list(T, _, C).

:-
	body_literal(T, gt_list, _, (_, C)),
	repeat_in_list(T, _, C).