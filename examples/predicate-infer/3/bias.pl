%% The expected predicate is 
%% f(Num, Lst) :- my_succ (A, Num), min_list(Lst, A).
%% bias.pl as follows
max_vars(3).
max_body(3).
max_clauses(2).

head_pred(f,2).
body_pred(min_list,2).
body_pred(my_min_list,2).
body_pred(succ,2).

type(f,(interger, list)).
type(my_min_list,(list, interger)).
type(min_list,(list, interger)).
type(succ,(interger, interger)).
