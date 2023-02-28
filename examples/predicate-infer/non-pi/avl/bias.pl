


head_pred(p,3).
body_pred(value,2).

body_pred(nullptr,1).
body_pred(empty,1).
body_pred(zero,1).
body_pred(one,1).
body_pred(subset,2).
body_pred(select,3).
body_pred(member,2).
body_pred(min_list,2).
body_pred(max_list,2).
body_pred(add,3).
body_pred(minus,3).
body_pred(succ,2).
body_pred(maxnum,3).
body_pred(minnum,3).
body_pred(>,2).
body_pred(>=,2).
body_pred(is,2).



type(p,(pointer,integer,integer)).
type(value,(pointer,integer)).

type(nullptr,(pointer,)).
type(empty,(list,)).
type(zero,(integer,)).
type(one,(integer,)).
type(subset,(list,list)).
type(select,(integer,list,list)).
type(member,(integer,list)).
type(min_list,(list,integer)).
type(max_list,(list,integer)).
type(add,(integer,integer,integer)).
type(minus,(integer,integer,integer)).
type(succ,(integer,integer)).
type(maxnum,(integer,integer,integer)).
type(minnum,(integer,integer,integer)).
type(>,(integer,integer)).
type(>=,(integer,integer)).
type(is,(integer,integer)).


direction(p,(in,in,in)).
direction(value,(in,out)).

direction(nullptr,(out,)).
direction(empty,(out,)).
direction(zero,(out,)).
direction(one,(out,)).
direction(subset,(in,in)).
direction(select,(in,in,out)).
direction(member,(in,in)).
direction(min_list,(in,out)).
direction(max_list,(in,out)).
direction(add,(out,in,in)).
direction(minus,(out,in,in)).
direction(succ,(out,out)).
direction(maxnum,(out,in,in)).
direction(minnum,(out,in,in)).
direction(>,(out,out)).
direction(>=,(out,out)).
direction(is,(out,in)).
