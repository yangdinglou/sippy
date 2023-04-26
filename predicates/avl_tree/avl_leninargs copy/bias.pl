
max_vars(7).
max_body(7).
max_clauses(2).
enable_recursion.

head_pred(p,2).
% body_pred(value,2).
% body_pred(pointer,2).
body_pred(left,2).
body_pred(right,2).
% body_pred(height,2).

body_pred(nullptr,1).
body_pred(zero,1).
% body_pred(one,1).
% body_pred(minusone,1).
body_pred(diff_lessthanone,2).
% body_pred(add,3).
% body_pred(minus,3).
body_pred(my_succ,2).
body_pred(my_prev,2).
body_pred(maxnum,3).
body_pred(minnum,3).
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



type(p,(element,integer)).
% type(value,(element,integer)).
% type(pointer,(element,element)).
type(left,(element,element)).
type(right,(element,element)).
% type(height,(element,integer)).

type(nullptr,(element,)).
type(zero,(integer,)).
% type(one,(integer,)).
% type(minusone,(integer,)).
type(diff_lessthanone,(integer,integer)).
% type(add,(integer,integer,integer)).
% type(minus,(integer,integer,integer)).
type(my_succ,(integer,integer)).
type(my_prev,(integer,integer)).
type(maxnum,(integer,integer,integer)).
type(minnum,(integer,integer,integer)).
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

direction(p,(in, out)).
direction(value,(in,out)).
% direction(pointer,(in,out)).
direction(left,(in,out)).
direction(right,(in,out)).
% direction(height,(in, out)).

direction(nullptr,(out,)).
direction(zero,(out,)).
% direction(one,(out,)).
% direction(minusone,(out,)).

direction(diff_lessthanone,(in,in)).
% direction(add,(out,in,in)).
% direction(minus,(out,in,in)).
direction(my_succ,(in,out)).
direction(my_prev,(in,out)).
direction(maxnum,(in,in,out)).
direction(minnum,(in,in,out)).
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


:-
    #count{P,Vars : body_literal(0,P,_,Vars)} > 4.

:-
	head_literal(0, p, _,(Var,_)),
	not body_literal(0,nullptr,_,(Var,)).
:-
    not clause(1).

% :-
% 	body_literal(1, nullptr, _, (_,)).

% :-
% 	body_literal(1, zero, _, (_,)).

% :-
% 	body_literal(1, minusone, _, (_,)).

% :-
%     #count{A,Vars : body_literal(1,p,A,Vars)} != 2.

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

%% height-based predicates
:-
	body_literal(T, diff_lessthanone, _, (X, Y)),
	not body_literal(T, p, _, (_, X)),
	not head_literal(T, p, _, (_, X)).

:-
	body_literal(T, diff_lessthanone, _, (X, Y)),
	not body_literal(T, p, _, (_, Y)),
	not head_literal(T, p, _, (_, Y)).



:-
	body_literal(T, diff_lessthanone, _, (A1, A2)), 
	not A1 > A2.


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
    body_literal(T, lt_list, _, (V, S1)),
    body_literal(T, min_list, _, (S2, V)),
    body_literal(T, insert, _, (S1, V, S2)).

:-
    body_literal(T, gt_list, _, (V, S1)),
    body_literal(T, max_list, _, (S2, V)),
    body_literal(T, insert, _, (S1, V, S2)).
% :-
% 	head_literal(1, p, _,(A,_)),
% 	not body_literal(1, left, _,(A,_)).

% :-
% 	head_literal(1, p, _,(A,_)),
% 	not body_literal(1, right, _,(A,_)).


% :-
% 	head_literal(1, p, _,(A,)),
% 	not body_literal(1, height, _,(A,_)).

% :-
% 	body_literal(1, left, _,(_,B)),
% 	not body_literal(1, height, _,(B,_)).

% :-
% 	body_literal(1, left, _,(_,B)),
% 	not body_literal(1, p, _,(B,)).

% :-
% 	body_literal(1, right, _,(_,B)),
% 	not body_literal(1, height, _,(B,_)).

% :-
% 	body_literal(1, right, _,(_,B)),
% 	not body_literal(1, p, _,(B,)).

% :-
% 	head_literal(1, p, _,(A,)),
% 	body_literal(1, height, _,(A,B)),
% 	not body_literal(1, my_prev, _,(B,_)).

% :-
% 	body_literal(1, left, _,(A1,B1)),
% 	body_literal(1, height, _,(B1,C1)),
% 	body_literal(1, right, _,(A2,B2)),
% 	body_literal(1, height, _,(B2,C2)),
% 	not body_literal(1, diff_lessthanone, _,(C1,C2)).

% :-
% 	body_literal(1, left, _,(A1,B1)),
% 	body_literal(1, height, _,(B1,C1)),
% 	body_literal(1, right, _,(A2,B2)),
% 	body_literal(1, height, _,(B2,C2)),
% 	not body_literal(1, maxnum, _,(C1,C2,_)).

% extra, useful if user provides

% :-
%     body_literal(1,left,_,(A,B)),
%     body_literal(1,right,_,(A,B)).