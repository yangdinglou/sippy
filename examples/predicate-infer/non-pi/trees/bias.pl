% BEST PROG 9:
% p(A,B):-nullptr(A),empty(B).
% p(A,B):-left(A,E),right(A,D),value(A,G),p(E,H),p(D,C),ord_union(H,C,F),insert(F,G,B).
% Precision:1.00, Recall:1.00, TP:9, FN:0, TN:5, FP:0

max_vars(8).
max_body(7).
max_clauses(2).
enable_recursion.

head_pred(p,2).
body_pred(value,2).
body_pred(left,2).
body_pred(right,2).

body_pred(nullptr,1).
body_pred(empty,1).
body_pred(zero,1).
body_pred(one,1).

body_pred(insert,3).
body_pred(ord_union,3).

% body_pred(subset,2).
% body_pred(select,3).
% body_pred(member,2).
% body_pred(min_list,2).
% body_pred(max_list,2).

body_pred(add,3).
body_pred(minus,3).
body_pred(succ,2).
body_pred(prev,2).
body_pred(maxnum,3).
body_pred(minnum,3).
body_pred(gt,2).
body_pred(ge,2).
body_pred(is,2).



type(p,(pointer,list)).
type(value,(pointer,integer)).
type(left,(pointer,pointer)).
type(right,(pointer,pointer)).

type(nullptr,(pointer,)).
type(empty,(list,)).
type(zero,(integer,)).
type(one,(integer,)).

type(insert,(list,integer,list)).
type(ord_union,(list,list,list)).


% type(subset,(list,list)).
% type(select,(integer,list,list)).
% type(member,(integer,list)).
% type(min_list,(list,integer)).
% type(max_list,(list,integer)).

type(add,(integer,integer,integer)).
type(minus,(integer,integer,integer)).
type(succ,(integer,integer)).
type(prev,(integer,integer)).
type(maxnum,(integer,integer,integer)).
type(minnum,(integer,integer,integer)).
type(gt,(integer,integer)).
type(ge,(integer,integer)).
type(is,(integer,integer)).


direction(p,(in,out)).
direction(value,(in,out)).
direction(left,(in,out)).
direction(right,(in,out)).

direction(nullptr,(out,)).
direction(empty,(out,)).
direction(zero,(out,)).
direction(one,(out,)).

direction(insert,(in,in,out)).
direction(ord_union,(in,in,out)).

% direction(subset,(in,in)).
% direction(select,(in,in,out)).
% direction(member,(in,in)).
% direction(min_list,(in,out)).
% direction(max_list,(in,out)).

direction(add,(out,in,in)).
direction(minus,(out,in,in)).
direction(succ,(in,out)).
direction(prev,(in,out)).
direction(maxnum,(out,in,in)).
direction(minnum,(out,in,in)).
direction(gt,(in,in)).
direction(ge,(in,in)).
direction(is,(out,in)).


:-
    not clause(1).


% :-
%     #count{P,A,Vars : body_literal(0,P,A,Vars)} != 2.
% :-
%     #count{A,Vars : body_literal(0,nullptr,A,Vars)} != 1.
% :-
%     #count{A,Vars : body_literal(0,empty,A,Vars)} != 1.

:-
    #count{A,Vars : body_literal(1,p,A,Vars)} != 2.



% :-
%     #count{P,A,Vars : body_literal(1,P,A,Vars)} != 7.

:-
    head_literal(1,p,_,(Var1,Var2)),
    not body_literal(1,left,_,(Var1,_)).

:-
    head_literal(1,p,_,(Var1,Var2)),
    not body_literal(1,right,_,(Var1,_)).
:-
    head_literal(1,p,_,(Var1,Var2)),
    not body_literal(1,value,_,(Var1,_)).


:-
    #count{A : body_literal(1,left,A,(Vars))} != 1.
:-
    #count{A : body_literal(1,right,A,Vars)} != 1.
:-
    #count{A,Vars : body_literal(1,value,A,Vars)} != 1.

% :-
%     #count{A,Vars : body_literal(1,ord_union,A,Vars)} != 1.
% :-
%     head_literal(1,p,_,(Var1,Var2)),
%     not body_literal(1,insert,_,(_,_,Var2)).

% :-
%     body_literal(1,ord_union,_,(_,_,Var1)),
%     not body_literal(1,insert,_,(Var1,_,_)).

:-
    #count{A,Vars : body_literal(1,insert,A,Vars)} != 1.

% :-
%     body_literal(C,P,2,Vars1),
%     body_literal(C,P,2,Vars2),
%     Vars1 = (Var11,_),
%     Vars2 = (Var11,_),
%     Vars1 < Vars2.


% :-
%     #count{A,Vars : body_literal(1,value,A,Vars)} != 1.





% :-
%     body_literal(1,p,_,(_,Var1)),
%     not body_literal(1,ord_union,_,(Var1,_,_)).
% :-
%     body_literal(1,p,_,(_,Var2)),
%     not body_literal(1,ord_ord_union,_,(_,Var2,_)).