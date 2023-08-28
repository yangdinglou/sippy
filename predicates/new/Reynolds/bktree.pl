bktree(X,S,B,T):- back(X,B), value(X,T), empty(S), !.
bktree(X,S,B,T):- back(X,B), left(X, L), right(X, R), value(X,T),zero(Zero),one(One),bktree(L,S1,X,Zero), bktree(R,S2,X,One), union(S1,S2,S), !.