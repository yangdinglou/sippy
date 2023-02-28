% f(This, sz, S) :- zero(sz), empty(S)/
% f(This, sz, S) :- plus(sz1, sz2，n), addone(sz, n)  value(This, v), member(v, S), q(Nxt1, sz1, S1), q(Nxt2, sz2, S2), lower(v2, S2), upper(v1, S1), v<v2, v>v1, subset(S1, S), subset(S2, S).

max_vars(5).
max_body(5).
max_clauses(2).

head_pred(f,3).
body_pred(nullptr,1).
body_pred(plus,3).
body_pred(delete,3).
body_pred(min_list,2).
body_pred(zero,1).
% body_pred(one,1).
body_pred(empty,1).
body_pred(value,2).
body_pred(pointer,2).
body_pred(q,3).


type(f,(element,list)).
type(nullptr,(element,)).
type(plus,(integer,integer,integer)).
type(addone,(integer,integer)).
type(delete,(list,integer,list)).
type(min_list,(list,integer)).
type(empty,(list,)).
type(zero,(integer,)).
type(one,(integer,)).
type(value,(element,integer)).
type(pointer,(element,element)).
type(q,(element,list)).

direction(f,(in,in,in)).
direction(nullptr,(out,)).
direction(plus,(in,in,out)).
direction(delete,(in,in,out)).
direction(min_list,(in,out)).
direction(empty,(in,)).
direction(zero,(in,)).
direction(one,(in,)).
direction(value,(in,out)).
direction(pointer,(in,out)).
direction(q,(out,out,out)).

% :-
%     body_size(0,1).

:-
	body_literal(0,q,_,_).
	% body_literal(Rule2,q,_,_),
	% Rule1 != Rule2.

:-
    not clause(1).