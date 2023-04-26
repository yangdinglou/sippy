% ********** SOLUTION **********
% Precision:1.00 Recall:1.00 TP:2 FN:0 TN:0 FP:0 Size:13
% p(A):- nullptr(A).
% p(A):- height(A,C),my_prev(C,F),left(A,D),height(D,B),right(A,E),height(E,G),diff_lessthanone(B,G),maxnum(F,B,G),p(E),p(D).
% ******************************
% Num. programs: 7019
% Generate:
%         Called: 7031 times       Total: 15.01    Mean: 0.002     Max: 2.823      Percentage: 33%
% Constrain:
%         Called: 7018 times       Total: 8.71     Mean: 0.001     Max: 0.084      Percentage: 19%
% Find Mucs:
%         Called: 232 times        Total: 7.41     Mean: 0.032     Max: 0.371      Percentage: 16%
% Ground:
%         Called: 7018 times       Total: 7.24     Mean: 0.001     Max: 0.432      Percentage: 16%
% Test:
%         Called: 7019 times       Total: 3.24     Mean: 0.000     Max: 0.022      Percentage: 7%
% Init:
%         Called: 13 times         Total: 2.68     Mean: 0.206     Max: 2.577      Percentage: 6%
% Combine:
%         Called: 6783 times       Total: 0.21     Mean: 0.000     Max: 0.001      Percentage: 0%
% Total operation time: 44.50s
% Total execution time: 51.27s

max_vars(12).
max_body(15).
max_clauses(2).
enable_recursion.

head_pred(p,2).
body_pred(value,2).
body_pred(left,2).
body_pred(right,2).
body_pred(height,2).

body_pred(nullptr,1).
body_pred(diff_lessthanone,2).
body_pred(my_succ,2).
body_pred(my_prev,2).
body_pred(maxnum,3).
body_pred(minnum,3).

body_pred(empty,1).
body_pred(gt_list,2).
body_pred(lt_list,2).
body_pred(ord_union,3).
body_pred(insert,3).



type(p,(element,list)).
type(value,(element,value)).
type(left,(element,element)).
type(right,(element,element)).
type(height,(element,integer)).

type(nullptr,(element,)).
type(diff_lessthanone,(integer,integer)).
type(my_succ,(integer,integer)).
type(my_prev,(integer,integer)).
type(maxnum,(integer,integer,integer)).
type(minnum,(integer,integer,integer)).

type(empty,(list,)).
type(gt_list,(value,list)).
type(lt_list,(value,list)).
type(ord_union,(list,list,list)).
type(insert,(list,value,list)).

direction(p,(in,out)).
direction(value,(in,out)).
direction(left,(in,out)).
direction(right,(in,out)).
direction(height,(in, out)).

direction(nullptr,(out,)).
direction(diff_lessthanone,(in,in)).
direction(my_succ,(in,out)).
direction(my_prev,(in,out)).
direction(maxnum,(in,in,out)).
direction(minnum,(in,in,out)).

direction(empty,(out,)).
direction(gt_list,(in,in)).
direction(lt_list,(in,in)).
direction(ord_union,(in,in,out)).
direction(insert,(in,in,out)).


:-
    #count{P,Vars : body_literal(0,P,_,Vars)} != 2.

:-
	not body_literal(0,nullptr,_,_).
:-
    not clause(1).



:-
	head_literal(1, p, _,(Var,_)),
	not body_literal(1,left,_,(Var,_)).
:-
	#count{A,Vars : body_literal(1,left,A,Vars)} != 1.

:-
	head_literal(1, p, _,(Var,_)),
	not body_literal(1,right,_,(Var,_)).
:-
	#count{A,Vars : body_literal(1,right,A,Vars)} != 1.

:-
    body_literal(1,left,_,(A,B)),
    body_literal(1,right,_,(A,B)).

:-
    body_literal(T, height, _, (A, B1)),
    body_literal(T, height, _, (A, B2)),
	B1 != B2.


:-
	head_literal(1, p, _,(Var,_)),
	not body_literal(1,value,_,(Var,_)).
:-
	#count{A,Vars : body_literal(1,value,A,Vars)} != 1.



% {'body_literal(1, diff_lessthanone, 2, (2,1,))', 'body_literal(1, p, 1, (3,))', 'body_literal(1, height, 2, (3,1,))', 'body_literal(0, nullptr, 1, (0,))', 'body_literal(1, left, 2, (0,3,))', 'body_literal(1, maxnum, 3, (2,1,6,))', 'head_literal(0, p, 1, (0,))', 'body_literal(1, height, 2, (4,2,))', 'head_literal(1, p, 1, (0,))', 'body_literal(1, right, 2, (0,4,))', 'body_literal(1, my_prev, 2, (5,6,))', 'body_literal(1, p, 1, (4,))', 'body_literal(1, height, 2, (0,5,))'}


:-
	head_literal(1, p, _,(A,_)),
	not body_literal(1, left, _,(A,_)).

:-
	head_literal(1, p, _,(A,_)),
	not body_literal(1, right, _,(A,_)).


:-
	head_literal(1, p, _,(A,_)),
	not body_literal(1, height, _,(A,_)).

:-
	body_literal(1, left, _,(_,B)),
	not body_literal(1, height, _,(B,_)).

:-
	body_literal(1, left, _,(_,B)),
	not body_literal(1, p, _,(B,_)).

:-
	body_literal(1, right, _,(_,B)),
	not body_literal(1, height, _,(B,_)).

:-
	body_literal(1, right, _,(_,B)),
	not body_literal(1, p, _,(B,_)).

:-
	head_literal(1, p, _,(A,_)),
	body_literal(1, height, _,(A,B)),
	not body_literal(1, my_prev, _,(B,_)).

:-
	body_literal(1, left, _,(A1,B1)),
	body_literal(1, height, _,(B1,C1)),
	body_literal(1, right, _,(A2,B2)),
	body_literal(1, height, _,(B2,C2)),
	not body_literal(1, diff_lessthanone, _,(C1,C2)).

:-
	body_literal(1, left, _,(A1,B1)),
	body_literal(1, height, _,(B1,C1)),
	body_literal(1, right, _,(A2,B2)),
	body_literal(1, height, _,(B2,C2)),
	not body_literal(1, maxnum, _,(C1,C2,_)).

:-
    #count{A,Vars : body_literal(1,p,A,Vars)} != 2.

:-
	#count{A,Vars : body_literal(1,my_prev,A,Vars)} != 1.

:-
	#count{A,Vars : body_literal(1,height,A,Vars)} != 3.

:-
	#count{A,Vars : body_literal(1,maxnum,A,Vars)} != 1.

:-
	#count{A,Vars : body_literal(1,diff_lessthanone,A,Vars)} != 1.




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

