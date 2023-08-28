lseg(X, Y, S) :- equal(X, Y), empty(S).
lseg(X, Y, S) :- value(X, V), next(X, Z), lseg(Z, Y, S1), insert(S1, V, S).