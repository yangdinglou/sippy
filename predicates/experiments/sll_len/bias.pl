max_clauses(2).
enable_recursion.

head_pred(sll_len,2).
type(sll_len,(pointer,integer)).


input_pointer(next,pointer).
input_pointer(value,integer).



body_pred(anypointer, 1).
body_pred(anynumber, 1).
body_pred(nullptr,1).
body_pred(zero,1).
body_pred(diff_lessthanone,2).
body_pred(my_succ,2).
body_pred(my_prev,2).
body_pred(maxnum,3).
body_pred(same_ptr,2).

not_in(anypointer, 1).
not_in(anynumber, 0).
not_in(nullptr, 1).
not_in(zero, 1).
not_in(diff_lessthanone, 0).
not_in(maxnum, 0).
not_in(same_ptr, 1).

body_pred(empty,1).
 
body_pred(gt_list,2).
body_pred(lt_list,2).
body_pred(ord_union,3).
body_pred(insert,3).

not_in(empty, 1).
 
not_in(gt_list, 0).
not_in(lt_list, 0).
not_in(ord_union, 0).
not_in(insert, 0).

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
 
type(gt_list,(integer,set)).
type(lt_list,(integer,set)).
type(ord_union,(set,set,set)).
type(insert,(set,integer,set)).




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
    body_literal(T, anynumber, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.

:-
    body_literal(T, anynumber, _, (A,)),
    not out_from_this(T, A).

:-
    body_literal(T, anynumber, _, (A,)),
    not out_from_this(T, A).


:-
    body_literal(T, nullptr, _, (A,)),
    #count{P,Vars : var_in_literal(T,P,Vars,A)} != 2.

:-
	#count{P,A,Vars : body_literal(0,P,A,Vars)} > 3.



 
func_head(ord_union).
partial_head(ord_union).
symmetric_head(ord_union).
injective_head(ord_union).

symmetric_head(same_ptr).


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
	body_literal(T, my_succ, _, (_, A)),
	body_literal(T, gt_list, _, (A, _)).

:-
	body_literal(T, my_prev, _, (_, A)),
	body_literal(T, lt_list, _, (A, _)).

:-
	body_literal(T, insert, _, (_, B, C)),
	body_literal(T, gt_list, _, (B, C)).

:-
	body_literal(T, insert, _, (_, B, C)),
	body_literal(T, lt_list, _, (B, C)).
