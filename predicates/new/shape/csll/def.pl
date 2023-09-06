p(X, P1) :- next(X, Next), p(Next, P1).
p(X, P1) :- next(X, P1).