% type(left,pointer).
% type(right,pointer).
% type(value,int).
% type(extra,int).

type(next,pointer).
type(key,int).

#show type/2.

{node(n00)}.
{node(n01)}:- node(n00).
{node(n02)}:- node(n01).
{node(n03)}:- node(n02).
{node(n04)}:- node(n03).
num_of_nodes(X):- X = #count{N1:node(N1)}.
#show num_of_nodes/1.

% :-not num_of_nodes(3).

start(n00):- node(n00).

#show node/1.
#show start/1.

0{relation(P,N,N1):node(N1),N1>N}1:- node(N),type(P,pointer).

% :- relation(P,N1,N),relation(P,N2,N),N1<N2, type(P,pointer).

:- node(N), #count{P,F:relation(P,F,N),type(P,pointer)}>1.

reachable(N1,N2):- relation(_,N1,N2).
reachable(N1,N2):- reachable(N1,N3), reachable(N3,N2).

:- not reachable(n00,N2), node(n00), node(N2), n00<N2.


% null(P,N):- node(N), type(P,pointer), not relation(P,N,_).

#show relation/3.

const(0..3).

1{relation(P,N,V):const(V)}1:- node(N),type(P,int).