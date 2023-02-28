%% expected predicate:
%% f(A,B):-nullptr(A),empty(B).
%% f(A,B):-my_min_list(B,D),value(A,D),q(E,C),pointer(A,E),my_delete(B,D,C).
%% bias
max_vars(5).
max_body(7).
max_clauses(2).

head_pred(f,2).
body_pred(nullptr,1).
body_pred(my_delete,3).
body_pred(my_min_list,2).
body_pred(empty,1).
body_pred(value,2).
body_pred(pointer,2).
body_pred(q,2).

type(f,(element,list)).
type(nullptr,(element,)).
type(my_delete,(list,integer,list)).
type(my_min_list,(list,integer)).
type(empty,(list,)).
type(value,(element,integer)).
type(pointer,(element,element)).
type(q,(element,list)).


direction(f,(in,in)).
direction(nullptr,(out,)).
direction(my_delete,(in,in,in)).
direction(my_min_list,(in,out)).
direction(empty,(out,)).
direction(value,(in,in)).
direction(pointer,(in,in)).
direction(q,(out,out)).

:-
	body_literal(0,q,_,_).
