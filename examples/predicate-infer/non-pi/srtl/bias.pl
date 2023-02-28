%% p(This, len, S) :- nullptr(This), zero(len), empty(S).
%% p(This, len, S) :- addone(len, len1), my_delete(S, v, S1), my_min_list(S, v), pointer(This, Nxt), value(This, v), q(Nxt, len1, S1).

max_vars(7).
max_body(6).
max_clauses(2).

head_pred(f,3).
body_pred(nullptr,1).
body_pred(addone,2).
body_pred(my_delete,3).
body_pred(my_min_list,2).
body_pred(zero,1).
% body_pred(one,1).
body_pred(empty,1).
body_pred(value,2).
body_pred(pointer,2).
body_pred(q,3).


type(f,(element,integer,list)).
type(nullptr,(element,)).
type(addone,(integer,integer)).
type(my_delete,(list,integer,list)).
type(my_min_list,(list,integer)).
% type(min_list,(list,integer)).
type(empty,(list,)).
type(zero,(integer,)).
% type(one,(integer,)).
type(value,(element,integer)).
type(pointer,(element,element)).
type(q,(element,integer,list)).

% :-
% 	body_literal(Rule1,q,_,_),
% 	body_literal(Rule2,q,_,_),
% 	Rule1 != Rule2.
:-
	body_literal(0,q,_,_).
:-
    not clause(1).

:-
    #count{A,Vars : body_literal(1,q,A,Vars)} != 1.

% :-
%     #count{A,Vars : body_literal(1,addone,A,Vars)} != 1.

% :-
%     #count{A,Vars : body_literal(1,my_delete,A,Vars)} != 1.

% :-
%     #count{A,Vars : body_literal(1,my_min_list,A,Vars)} != 1.

:-
    #count{A,Vars : body_literal(1,pointer,A,Vars)} != 1.

% :-
%     #count{A,Vars : body_literal(1,value,A,Vars)} != 1.