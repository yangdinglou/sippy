% type(left,pointer).
% type(right,pointer).
% type(value,int).
% type(extra,int).

type(children,pointer).
type(sibling,pointer).
type(key,int).
type(order,int).

% large:- type(X1,pointer), type(X2,pointer), X1<X2.
% :- node(n05), not large.

{node(n00)}.
{node(n01)}:- node(n00).
{node(n02)}:- node(n01).
{node(n03)}:- node(n02).
{node(n04)}:- node(n03).
% {node(n05)}:- node(n04).
% {node(n06)}:- node(n05).
% {node(n07)}:- node(n06).
% {node(n08)}:- node(n07).
% {node(n09)}:- node(n08).
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

% :- not relation(order,n00,2).
% :- not num_of_nodes(4).

% :- not relation(children,n01,n03).
% :- not relation(children,n00,n01).
% :- not relation(sibling,n01,n02).

% :- not relation(order,n00,2).
% :- not relation(order,n01,1).
% :- not relation(order,n02,0).
% :- not relation(order,n03,0).
% :- not relation(key,n00,0).
% :- not relation(key,n01,1).
% :- not relation(key,n02,2).