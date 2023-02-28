max_vars(8).
max_body(7).
max_clauses(4).
enable_recursion.

head_pred(p,2).

body_pred(nullptr,1).
body_pred(empty,1).
body_pred(zero,1).
body_pred(one,1).
body_pred(insert,3).
body_pred(ord_union,3).
body_pred(add,3).
body_pred(minus,3).
body_pred(succ,2).
body_pred(prev,2).
body_pred(maxnum,3).
body_pred(minnum,3).
body_pred(gt,2).
body_pred(ge,2).
body_pred(is,2).

type(nullptr,(pointer,)).
type(empty,(list,)).
type(zero,(integer,)).
type(one,(integer,)).
type(insert,(list,integer,list)).
type(ord_union,(list,list,list)).
type(add,(integer,integer,integer)).
type(minus,(integer,integer,integer)).
type(succ,(integer,integer)).
type(prev,(integer,integer)).
type(maxnum,(integer,integer,integer)).
type(minnum,(integer,integer,integer)).
type(gt,(integer,integer)).
type(ge,(integer,integer)).
type(is,(integer,integer)).