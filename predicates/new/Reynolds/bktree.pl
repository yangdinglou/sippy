bktree(X,S,B):- back(X,B), empty(S), !.
bktree(X,S,B):- back(X,B), left(X, L), right(X, R), value(X,T),zero(Zero),one(One),bktree(L,S1,X,Zero), bktree(R,S2,X,One), union(S1,S2,S), !.