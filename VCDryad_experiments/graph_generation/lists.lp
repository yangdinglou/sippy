{node(n0)}.
{node(n1)}:- node(n0).
node(n2):- node(n1).
node(n3):- node(n2).
{node(n4)}:- node(n3).
{node(n5)}:- node(n4).
{node(n6)}:- node(n5).
{node(n7)}:- node(n6).
{node(n8)}:- node(n7).
{node(n9)}:- node(n8).
% {node(n10)}:- node(n9).
start(n0):- node(n0).

#show start/1.
#show node/1.

{enable_prevptr}.
% {cyclic}.
#show enable_prevptr/0.
#show cyclic/0.


prev(N1,N2):- next(N2,N1), enable_prevptr.

prevnull(N):- node(N), not prev(N,_), enable_prevptr.

#show prev/2.
#show prevnull/1.

0{next(N,N1):node(N1),N1>N}1:- node(N), not cyclic.
0{next(N,N1):node(N1)}1:- node(N), cyclic.

:- next(N1,N3), next(N2,N3), N1<N2.

reachable(N1,N2):- next(N1,N2).
reachable(N1,N2):- next(N1,N3), reachable(N3,N2).

:- not reachable(n0,N2), node(n0), node(N2), N2>n0.

:- cyclic, #count{N:reachable(N,N)}==0.

nullnext(N):- node(N), not next(N,_).

#show next/2.
#show nullnext/1.

% TODO: make it random by python
% const(1..10).

1{value(N,V):const(V)}1:- node(N).

#show value/2.