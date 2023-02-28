%% p(This, len, S) :- nullptr(This), zero(len), empty(S).
%% p(This, len, S) :- addone(len, len1), my_subset(This, S1, S), nextone(This, Nxt), isof(This, S), p(Nxt, len1, S1).

max_vars(6).
max_body(5).
max_clauses(2).
enable_recursion.

head_pred(p,3).
body_pred(addone,2).
body_pred(my_subset,3).
body_pred(nextone,2).
body_pred(isof,2).
body_pred(nullptr,1).
body_pred(zero,1).
body_pred(empty,1).

type(p,(element, number, list)).
type(addone,(number, number)).
type(my_subset,(element, list, list)).
type(nextone,(element,element)).
type(isof,(element, list)).
type(nullptr,(element,)).
type(zero,(number,)).
type(empty,(list,)).
