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

max_vars(8).
max_body(11).
max_clauses(2).
enable_recursion.

head_pred(p,1).
% body_pred(value,2).
% body_pred(pointer,2).
body_pred(left,2).
body_pred(right,2).
body_pred(height,2).

body_pred(nullptr,1).
% body_pred(zero,1).
% body_pred(one,1).
body_pred(diff_lessthanone,2).
% body_pred(add,3).
% body_pred(minus,3).
body_pred(my_succ,2).
body_pred(my_prev,2).
body_pred(maxnum,3).
% body_pred(minnum,3).
% body_pred(gt,2).
% body_pred(ge,2).

% body_pred(empty,1).
% body_pred(gt_list,2).
% body_pred(lt_list,2).
% % body_pred(is,2).
% % body_pred(min_list,2).
% % body_pred(max_list,2).
% body_pred(select,3).
% body_pred(ord_union,3).
% % body_pred(insert,3).



type(p,(element,)).
% type(value,(element,integer)).
% type(pointer,(element,element)).
type(left,(element,element)).
type(right,(element,element)).
type(height,(element,integer)).

type(nullptr,(element,)).
% type(zero,(integer,)).
% type(one,(integer,)).
type(diff_lessthanone,(integer,integer)).
% type(add,(integer,integer,integer)).
% type(minus,(integer,integer,integer)).
type(my_succ,(integer,integer)).
type(my_prev,(integer,integer)).
type(maxnum,(integer,integer,integer)).
% type(minnum,(integer,integer,integer)).
% type(gt,(integer,integer)).
% type(ge,(integer,integer)).

% type(empty,(list,)).
% type(gt_list,(integer,list)).
% type(lt_list,(integer,list)).
% % type(is,(integer,integer)).
% % type(min_list,(list,integer)).
% % type(max_list,(list,integer)).
% type(select,(integer,list,list)).
% type(ord_union,(list,list,list)).
% % type(insert,(list,integer,list)).

direction(p,(in,)).
direction(value,(in,out)).
% direction(pointer,(in,out)).
direction(left,(in,out)).
direction(right,(in,out)).
direction(height,(in, out)).

direction(nullptr,(out,)).
% direction(zero,(out,)).
% direction(one,(out,)).

direction(diff_lessthanone,(in,in)).
% direction(add,(out,in,in)).
% direction(minus,(out,in,in)).
direction(my_succ,(in,out)).
direction(my_prev,(in,out)).
direction(maxnum,(out,in,in)).
% direction(minnum,(out,in,in)).
% direction(gt,(in,in)).
% direction(ge,(in,in)).

% direction(empty,(out,)).
% direction(gt_list,(in,in)).
% direction(lt_list,(in,in)).
% % direction(is,(in,out)).
% % direction(min_list,(in,out)).
% % direction(max_list,(in,out)).
% direction(select,(in,in,out)).
% direction(ord_union,(in,in,out)).
% % direction(insert,(in,in,out)).

% :-
%     body_size(0,1).

% :-
% 	body_literal(Rule1,q,_,_),
% 	body_literal(Rule2,q,_,_),
% 	Rule1 != Rule2.
:-
    #count{P,Vars : body_literal(0,P,_,Vars)} != 1.

:-
	not body_literal(0,nullptr,_,_).
:-
    not clause(1).

:-
    #count{A,Vars : body_literal(1,p,A,Vars)} != 2.

:-
	head_literal(1, p, _,(Var,)),
	not body_literal(1,left,_,(Var,_)).
:-
	#count{A,Vars : body_literal(1,left,A,Vars)} != 1.

:-
	head_literal(1, p, _,(Var,)),
	not body_literal(1,right,_,(Var,_)).
:-
	#count{A,Vars : body_literal(1,right,A,Vars)} != 1.

% :-
%     body_literal(T, height, _, (A1, _)),
%     body_literal(T, height, _, (A2, _)),
% 	A1 == A2.
:-
    body_literal(T, height, _, (A, B1)),
    body_literal(T, height, _, (A, B2)),
	B1 != B2.

:-
	#count{A,Vars : body_literal(1,height,A,Vars)} != 3.


% ********** SOLUTION **********
% Precision:1.00 Recall:1.00 TP:2 FN:0 TN:0 FP:0 Size:13
% p(A):- nullptr(A).
% p(A):- right(A,G),height(G,F),left(A,D),height(D,E),maxnum(C,F,E),diff_lessthanone(C,E),height(A,B),my_prev(B,C),p(G),p(D).
% ******************************
% Num. programs: 96
% Generate:
%         Called: 108 times        Total: 131.61   Mean: 1.219     Max: 127.290    Percentage: 87%
% Find Mucs:
%         Called: 63 times         Total: 7.38     Mean: 0.117     Max: 0.407      Percentage: 4%
% Constrain:
%         Called: 95 times         Total: 5.57     Mean: 0.059     Max: 0.334      Percentage: 3%
% Ground:
%         Called: 95 times         Total: 5.48     Mean: 0.058     Max: 0.369      Percentage: 3%
% Test:
%         Called: 96 times         Total: 0.19     Mean: 0.002     Max: 0.056      Percentage: 0%
% Combine:
%         Called: 33 times         Total: 0.01     Mean: 0.000     Max: 0.003      Percentage: 0%
% Init:
%         Called: 13 times         Total: 0.00     Mean: 0.000     Max: 0.000      Percentage: 0%
% Total operation time: 150.23s
% Total execution time: 150.75s

% Seems making the solver slow.

% :-
% 	#count{A,Vars : body_literal(1,diff_lessthanone,A,Vars)} != 1.

% :-
% 	#count{A,Vars : body_literal(1,my_prev,A,Vars)} != 1.

% :-
% 	#count{A,Vars : body_literal(1,maxnum,A,Vars)} != 1.

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


% ********** SOLUTION **********
% Precision:1.00 Recall:1.00 TP:2 FN:0 TN:0 FP:0 Size:13
% p(A):- nullptr(A).
% p(A):- right(A,C),height(A,E),left(A,G),height(G,F),my_prev(E,B),height(C,D),diff_lessthanone(F,D),maxnum(B,D,F),p(G),p(C).
% ******************************
% Num. programs: 6789
% Generate:
%         Called: 6801 times       Total: 39.95    Mean: 0.006     Max: 8.116      Percentage: 40%
% Constrain:
%         Called: 6788 times       Total: 17.88    Mean: 0.003     Max: 0.226      Percentage: 18%
% Find Mucs:
%         Called: 196 times        Total: 13.19    Mean: 0.067     Max: 0.622      Percentage: 13%
% Ground:
%         Called: 6788 times       Total: 11.77    Mean: 0.002     Max: 0.310      Percentage: 11%
% Test:
%         Called: 6789 times       Total: 9.62     Mean: 0.001     Max: 0.291      Percentage: 9%
% Init:
%         Called: 13 times         Total: 5.40     Mean: 0.415     Max: 5.183      Percentage: 5%
% Combine:
%         Called: 6593 times       Total: 0.63     Mean: 0.000     Max: 0.004      Percentage: 0%
% Total operation time: 98.43s
% Total execution time: 110.66s

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

%% height-based predicates
:-
	body_literal(T, diff_lessthanone, _, (X, Y)),
	not body_literal(T, height, _, (_, X)).

:-
	body_literal(T, diff_lessthanone, _, (X, Y)),
	not body_literal(T, height, _, (_, Y)).





:-
	body_literal(T, diff_lessthanone, _, (A1, A2)), 
	body_literal(T, diff_lessthanone, _, (A2, A1)).

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
	body_literal(T, my_succ, _, (_, A)),
	body_literal(T, my_prev, _, (A, _)).

:-
	body_literal(T, my_prev, _, (_, A)),
	body_literal(T, my_succ, _, (A, _)).