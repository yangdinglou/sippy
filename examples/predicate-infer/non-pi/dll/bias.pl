%% p(This, Prev, S) :- nullptr(This), empty(S).
%% p(This, Prev, S) :- subset(S1, S), value(This, v), member(v, S), next(This, Nxt), prev(This, prev), q(Nxt, This, S1).   % heapoffset(This, Nxt, 1), heapoffset(This, Prev, 2),

max_vars(6).
max_body(6).
max_clauses(2).
non_datalog.
% allow_singletons.

head_pred(p,3).
body_pred(q,3).
body_pred(subset,2).
body_pred(my_value,2).
body_pred(member,2).
body_pred(nullptr,1).
% body_pred(entryp,1).
% body_pred(zero,1).
body_pred(empty,1).
body_pred(next,2).
body_pred(prev,2).
% body_pred(select,3).

type(p,(element, element, list)).
type(q,(element, element, list)).
type(subset,(list, list)).
type(my_value,(element,value)).
type(member,(value,list)).
type(nullptr,(element,)).
type(entryp,(element,)).
type(zero,(value,)).
type(empty,(list,)).
type(next,(element,element)).
type(prev,(element,element)).
type(select,(value,list,list)).

direction(p,(in,in,in)).
direction(q,(out,out,out)).
direction(member,(in,in)).
direction(subset,(in,in)).
direction(my_value,(out,out)).
direction(nullptr,(out,)).
direction(entryp,(out,)).
direction(zero,(out,)).
direction(next,(out,out)).
direction(prev,(out,out)).
direction(empty,(out,)).
direction(select,(in,in,out)).


:-
	body_literal(0,q,_,_).
% :-
% 	body_literal(0,next,_,_).
% :-
% 	body_literal(0,prev,_,_).
% :-
% 	body_literal(0,member,_,_).
% :-
% 	body_literal(0,subset,_,_).
% :-
% 	body_literal(0,my_value,_,_).

% :-
%     #count{A,Vars : body_literal(0,nullptr,A,Vars)} != 1.
% :-
%     #count{A,Vars : body_literal(0,empty,A,Vars)} != 1.
% :-
%     body_literal(1,empty,_,_).
% :-
%     body_literal(1,nullptr,_,_).
:-
    not clause(1).
    
:-
    #count{A,Vars : body_literal(1,q,A,Vars)} != 1.



% :-
%     #count{A,Vars : body_literal(1,member,A,Vars)} != 1.

% :-
%     #count{A,Vars : body_literal(1,subset,A,Vars)} != 1.

:-
    #count{A,Vars : body_literal(1,next,A,Vars)} != 1.
:-
    #count{A,Vars : body_literal(1,prev,A,Vars)} != 1.
:-
    #count{A,Vars : body_literal(1,my_value,A,Vars)} != 1.

% :-
%     not (body_literal(1,next,_,(A,_)), body_literal(1,prev,_,(A,_)).)
