% p(A,B):-nullptr(A),empty(B).
% p(A,B) :- left(A,L),right(A,R), 
% height(L, H1), height(R, H2), diff_lessthanone(H1,H2),height(A,H), my_prev(H, MaxH), maxnum(MaxH, H1, H2),
% p(L,C),p(R,E), value(A,D),gt_list(D, C),lt_list(D, E),ord_union(C,E,Tmp),insert(Tmp,D,B).
%  python popper.py ./examples/predicate-infer/srtl2/ --info --eval-timeout=10 --stats

max_vars(8).
max_body(9).
max_clauses(2).
enable_recursion.

head_pred(p,2).
body_pred(value,2).
% body_pred(pointer,2).
body_pred(left,2).
body_pred(right,2).
% body_pred(height,2).
body_pred(nullptr,1).

% % body_pred(zero,1).
% % body_pred(one,1).
% body_pred(diff_lessthanone,2).
% % body_pred(add,3).
% % body_pred(minus,3).
% % body_pred(my_succ,2).
% body_pred(my_prev,2).
% body_pred(maxnum,3).
% % body_pred(minnum,3).
% % body_pred(gt,2).
% % body_pred(ge,2).

body_pred(empty,1).
body_pred(gt_list,2).
body_pred(lt_list,2).
% body_pred(is,2).
% body_pred(min_list,2).
% body_pred(max_list,2).
% body_pred(select,3).
body_pred(ord_union,3).
body_pred(insert,3).



type(p,(element,list)).
type(value,(element,integer)).
% type(pointer,(element,element)).
type(left,(element,element)).
type(right,(element,element)).
% type(height,(element,integer)).
type(nullptr,(element,)).

% % type(zero,(integer,)).
% % type(one,(integer,)).
% type(diff_lessthanone,(integer,integer)).
% % type(add,(integer,integer,integer)).
% % type(minus,(integer,integer,integer)).
% % type(my_succ,(integer,integer)).
% type(my_prev,(integer,integer)).
% type(maxnum,(integer,integer,integer)).
% % type(minnum,(integer,integer,integer)).
% % type(gt,(integer,integer)).
% % type(ge,(integer,integer)).

type(empty,(list,)).
type(gt_list,(integer,list)).
type(lt_list,(integer,list)).
% type(is,(integer,integer)).
% type(min_list,(list,integer)).
% type(max_list,(list,integer)).
% type(select,(integer,list,list)).
type(ord_union,(list,list,list)).
type(insert,(list,integer,list)).

direction(p,(in,out)).
direction(value,(in,out)).
% direction(pointer,(in,out)).
direction(left,(in,out)).
direction(right,(in,out)).
% direction(height,(in, out)).
direction(nullptr,(out,)).

% % direction(zero,(out,)).
% % direction(one,(out,)).
% direction(diff_lessthanone,(in,in)).
% % direction(add,(out,in,in)).
% % direction(minus,(out,in,in)).
% % direction(my_succ,(in,out)).
% direction(my_prev,(in,out)).
% direction(maxnum,(out,in,in)).
% % direction(minnum,(out,in,in)).
% % direction(gt,(in,in)).
% % direction(ge,(in,in)).

direction(empty,(out,)).
direction(gt_list,(in,in)).
direction(lt_list,(in,in)).
% direction(is,(in,out)).
% direction(min_list,(in,out)).
% direction(max_list,(in,out)).
% direction(select,(in,in,in)).
direction(ord_union,(in,in,out)).
direction(insert,(in,in,out)).

% :-
%     body_size(0,1).

% :-
% 	body_literal(Rule1,q,_,_),
% 	body_literal(Rule2,q,_,_),
% 	Rule1 != Rule2.


:-
	not body_literal(0,nullptr,_,_).
:-
	#count{A,Vars : body_literal(0,left,A,Vars)} != 0.
:-
	#count{A,Vars : body_literal(0,right,A,Vars)} != 0.
:-
	#count{A,Vars : body_literal(0,value,A,Vars)} != 0.

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
	body_literal(1,left,_,(Var,L)),
    not body_literal(1, p, _, (L,_)).
:-
	body_literal(1,right,_,(Var,R)),
    not body_literal(1, p, _, (R,_)).

:-
    body_literal(1,left,_,(A,B)),
    body_literal(1,right,_,(A,B)).

:-
    body_literal(1,lt_list,_,(A,B)),
    body_literal(1,gt_list,_,(A,B)).



:-
    #count{A,Vars : body_literal(1,p,A,Vars)} != 2.

% :-
%     #count{A,Vars : body_literal(1,gt_list,A,Vars)} != 1.
% :-
%     #count{A,Vars : body_literal(1,lt_list,A,Vars)} != 1.

:-
	head_literal(1, p, _,(Var,_)),
	not body_literal(1,value,_,(Var,_)).
:-
	#count{A,Vars : body_literal(1,value,A,Vars)} != 1.



:-
    #count{P,Vars : body_literal(0,P,_,Vars)} != 2.

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
    body_literal(T, ord_union, _, (A2, B2, C2)),
	B1 == A2,
	A1 == B2.




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