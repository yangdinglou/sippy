% f(A,B):-nullptr(A),empty(B).
% f(A,B):-min_list(B,D),value(A,D),q(E,C),pointer(A,E),delete(B,D,C).
%  python popper.py ./examples/predicate-infer/srtl2/ --info --eval-timeout=10 --stats

max_vars(6).
max_body(6).
max_clauses(2).
enable_recursion.

head_pred(p,2).
body_pred(value,2).
body_pred(pointer,2).
% body_pred(left,2).
% body_pred(right,2).

body_pred(nullptr,1).
body_pred(empty,1).
% body_pred(zero,1).
% body_pred(one,1).
body_pred(my_insert,3).
% body_pred(ord_union,3).
% body_pred(add,3).
% body_pred(minus,3).
% body_pred(succ,2).
% body_pred(prev,2).
% body_pred(maxnum,3).
% body_pred(minnum,3).
% body_pred(gt,2).
% body_pred(ge,2).
% body_pred(is,2).
body_pred(min_list,2).
body_pred(max_list,2).
body_pred(select,3).



type(p,(element,list)).
type(value,(element,integer)).
type(pointer,(element,element)).
% type(left,(pointer,pointer)).
% type(right,(pointer,pointer)).

type(nullptr,(element,)).
type(empty,(list,)).
% type(zero,(integer,)).
% type(one,(integer,)).
type(my_insert,(list,integer,list)).
% type(ord_union,(list,list,list)).
% type(add,(integer,integer,integer)).
% type(minus,(integer,integer,integer)).
% type(succ,(integer,integer)).
% type(prev,(integer,integer)).
% type(maxnum,(integer,integer,integer)).
% type(minnum,(integer,integer,integer)).
% type(gt,(integer,integer)).
% type(ge,(integer,integer)).
% type(is,(integer,integer)).
type(min_list,(list,integer)).
type(max_list,(list,integer)).
type(select,(integer,list,list)).

direction(p,(in,out)).
direction(value,(in,out)).
direction(pointer,(in,out)).
% direction(left,(in,out)).
% direction(right,(in,out)).

direction(nullptr,(out,)).
direction(empty,(out,)).
% direction(zero,(out,)).
% direction(one,(out,)).
direction(my_insert,(in,in,out)).
% direction(ord_union,(in,in,out)).
% direction(add,(out,in,in)).
% direction(minus,(out,in,in)).
% direction(succ,(in,out)).
% direction(prev,(in,out)).
% direction(maxnum,(out,in,in)).
% direction(minnum,(out,in,in)).
% direction(gt,(in,in)).
% direction(ge,(in,in)).
% direction(is,(in,out)).
direction(min_list,(in,out)).
direction(max_list,(in,out)).
direction(select,(in,in,out)).

% :-
%     body_size(0,1).

% :-
% 	body_literal(Rule1,q,_,_),
% 	body_literal(Rule2,q,_,_),
% 	Rule1 != Rule2.


:-
	not body_literal(0,nullptr,_,_).
:-
    not clause(1).

% :-
%     #count{A,Vars : body_literal(1,q,A,Vars)} != 1.
:-
	#count{A,Vars : body_literal(1,pointer,A,Vars)} != 1.
:-
	#count{A,Vars : body_literal(1,value,A,Vars)} != 1.
:-
	#count{A,Vars : body_literal(1,min_list,A,Vars)} != 1.
% :-
%     body_literal(T, select, _, (A, _, B)),
%     body_literal(T, select, _, (, A, _)).

:-
    body_literal(T, select, _, (A, B, C1)),
    body_literal(T, select, _, (A, B, C2)),
	C1 != C2.

:-
    body_literal(T, select, _, (A1, B, C)),
    body_literal(T, select, _, (A2, B, C)),
	A1 != A2.

:-
    body_literal(T, min_list, _, (A, B1)),
    body_literal(T, min_list, _, (A, B2)),
	B1 != B2.
% :-
%     body_literal(T, select, _, (_, B, C)),
%     body_literal(T, select, _, (_, B, C)).

:-
    #count{P,Vars : body_literal(0,P,_,Vars)} != 2.