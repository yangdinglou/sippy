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
body_pred(left,2).
body_pred(right,2).
body_pred(nullptr,1).


body_pred(empty,1).
body_pred(gt_list,2).
body_pred(lt_list,2).
body_pred(ord_union,3).
body_pred(insert,3).



type(p,(element,list)).
type(value,(element,integer)).
type(left,(element,element)).
type(right,(element,element)).
type(nullptr,(element,)).


type(empty,(list,)).
type(gt_list,(integer,list)).
type(lt_list,(integer,list)).
type(ord_union,(list,list,list)).
type(insert,(list,integer,list)).

direction(p,(in,out)).
direction(value,(in,out)).
direction(left,(in,out)).
direction(right,(in,out)).
direction(nullptr,(out,)).


direction(empty,(out,)).
direction(gt_list,(in,in)).
direction(lt_list,(in,in)).
direction(ord_union,(in,in,out)).
direction(insert,(in,in,out)).


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

% Not pruning a lot, but make the search faster a lot!
:-
    body_literal(1,left,_,(A,B)),
    body_literal(1,right,_,(A,B)).


:-
    body_literal(1,lt_list,_,(A,B)),
    body_literal(1,gt_list,_,(A,B)).



:-
    #count{A,Vars : body_literal(1,p,A,Vars)} != 2.



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