dlseg(X, X1, Y, Y1, S) :- equal(X, Y), equal(X1, Y1), empty(S).
dlseg(X, X1, Z, Z1, S) :- value(X, V), next(X, Y), prev(X, X1), dlseg(Y, X, Z, Z1, S1), insert(S1, V, S).