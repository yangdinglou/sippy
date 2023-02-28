% python ./popper.py ./predicates/srtl/pure/ --threshold 300 --stats
% ********** SOLUTION **********
% Precision:1.00 Recall:1.00 TP:2 FN:0 TN:0 FP:0 Size:9
% f(A,B):- nullptr(A),empty(B).
% f(A,B):- pointer(A,E),value(A,C),f(E,D),insert(D,C,B),delete(B,C,D).
% ******************************
% Num. programs: 1356
% Test:
%         Called: 1356 times       Total: 45.11    Mean: 0.033     Max: 0.298      Percentage: 53%
% Find Mucs:
%         Called: 1354 times       Total: 36.58    Mean: 0.027     Max: 1.183      Percentage: 43%
% Constrain:
%         Called: 1355 times       Total: 0.87     Mean: 0.001     Max: 0.002      Percentage: 1%
% Generate:
%         Called: 1364 times       Total: 0.56     Mean: 0.000     Max: 0.028      Percentage: 0%
% Ground:
%         Called: 1355 times       Total: 0.50     Mean: 0.000     Max: 0.026      Percentage: 0%
% Init:
%         Called: 9 times          Total: 0.01     Mean: 0.001     Max: 0.008      Percentage: 0%
% Combine:
%         Called: 2 times          Total: 0.01     Mean: 0.003     Max: 0.003      Percentage: 0%
% Total operation time: 83.63s
% Total execution time: 84.30s

max_vars(5).
max_body(5).
max_clauses(2).
enable_recursion.

head_pred(f,2).
body_pred(nullptr,1).
% body_pred(plus,3).
body_pred(delete,3).
body_pred(min_list,2).
body_pred(zero,1).
% body_pred(one,1).
body_pred(empty,1).
body_pred(value,2).
body_pred(pointer,2).
body_pred(insert,3).


type(f,(element,list)).
type(nullptr,(element,)).
% type(plus,(integer,integer,integer)).
% type(delete,(list,integer,list)).
type(min_list,(list,integer)).
type(empty,(list,)).
% type(zero,(integer,)).
% type(one,(integer,)).
type(value,(element,integer)).
type(pointer,(element,element)).
type(insert,(list,integer,list)).

direction(f,(in,out)).
direction(nullptr,(out,)).
direction(delete,(in,in,out)).
% direction(min_list,(in,in)).
direction(empty,(out,)).
% direction(zero,(out,)).
% direction(one,(out,)).
direction(value,(out,out)).
direction(pointer,(out,out)).
direction(insert,(in,in,out)).

% :-
%     body_size(0,1).

% :-
% 	body_literal(Rule1,q,_,_),
% 	body_literal(Rule2,q,_,_),
% 	Rule1 != Rule2.


:-
	head_literal(0, f, _, (X, _)),
	not body_literal(0, nullptr, _, (X,)).
:-
    not clause(1).

% :-
%     #count{A,Vars : body_literal(1,q,A,Vars)} != 1.
:-
	#count{A,Vars : body_literal(1,pointer,A,Vars)} != 1.

:-
	head_literal(1, f, _, (X, _)),
	body_literal(1, pointer, _, (X, Y)),
	not body_literal(1, f, _, (Y, _)).

:-
	#count{A,Vars : body_literal(1,value,A,Vars)} != 1.
