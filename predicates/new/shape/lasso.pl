lasso(X, Y, S) :- empty(S), same_ptr(X, Y).
lasso(X, Y, S) :- next(X, X1), value(X, V), lasso(X1, Y, S1), insert(S1, V, S).