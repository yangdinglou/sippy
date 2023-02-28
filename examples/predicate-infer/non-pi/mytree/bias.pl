%% p(A):- left(A, B), right(A, B), null(B).
%% p(A):- left(A, B), right(A, C), p(B), p(C).

%learned:
% BEST PROG 314:
%p(A):-left(A,B),right(A,B).
%p(A):-q(B),q(C),left(A,C),right(A,B).
% Precision:1.00, Recall:1.00, TP:26, FN:0, TN:5, FP:0
max_vars(3).
max_body(4).
max_clauses(3).


head_pred(p,1).
body_pred(left,2).
body_pred(right,2).
% body_pred(node,1).
body_pred(q,1).
body_pred(null,1).

type(p,(element,)).
type(left,(element,element)).
type(right,(element,element)).
type(q,(element,)).
type(null,(element,)).

