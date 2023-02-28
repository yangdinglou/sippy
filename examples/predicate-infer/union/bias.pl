%% p(This, S) :- nullptr(This),  empty(S).
%% p(This, S) :- delete(S, v, S1), min_list(S, v), pointer(This, Nxt), value(This, v), p(Nxt, S1).

max_vars(5).
max_body(5).
max_clauses(2).
enable_recursion.

head_pred(f,2).
body_pred(nullptr,1).
% body_pred(plus,3).
body_pred(my_delete,3).
body_pred(my_min_list,2).
% body_pred(zero,1).
% body_pred(one,1).
body_pred(empty,1).
body_pred(value,2).
body_pred(pointer,2).


type(f,(element,list)).
type(nullptr,(element,)).
% type(plus,(integer,integer,integer)).
type(my_delete,(list,integer,list)).
type(my_min_list,(list,integer)).
type(empty,(list,)).
% type(zero,(integer,)).
% type(one,(integer,)).
type(value,(element,integer)).
type(pointer,(element,element)).

% direction(f,(in,in)).
% direction(nullptr, (out,)).
% direction(empty, (out,)).
% direction(value,(in,out)).
% direction(pointer,(in,out)).
% direction(my_delete, (in, in, out)).
% direction(my_min_list, (in, in)).