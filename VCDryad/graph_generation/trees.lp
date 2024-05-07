{node(n00)}.
node(n01):- node(n00).
node(n02):- node(n01).
node(n03):- node(n02).
node(n04):- node(n03).
{node(n05)}:- node(n04).
{node(n06)}:- node(n05).
{node(n07)}:- node(n06).
{node(n08)}:- node(n07).
{node(n09)}:- node(n08).
{node(n10)}:- node(n09).
{node(n11)}:- node(n10).
{node(n12)}:- node(n11).
{node(n13)}:- node(n12).
{node(n14)}:- node(n13).
{node(n15)}:- node(n14).
{node(n16)}:- node(n15).
{node(n17)}:- node(n16).
{node(n18)}:- node(n17).
{node(n19)}:- node(n18).
start(n00):- node(n00).

#show node/1.
#show start/1.

0{left(N,N1):node(N1),N1>N}1:- node(N).
0{right(N,N1):node(N1),N1>N}1:- node(N).

:- left(N1,N3), left(N2,N3), N1<N2.
:- right(N1,N3), right(N2,N3), N1<N2.

reachable(N1,N2):- left(N1,N2).
reachable(N1,N2):- reachable(N1,N3), reachable(N3,N2).
reachable(N1,N2):- right(N1,N2).
reachable(N1,N2):- reachable(N1,N3), reachable(N3,N2).

:- not reachable(n00,N2), node(n00), node(N2), n00<N2.


nullleft(N):- node(N), not left(N,_).
nullright(N):- node(N), not right(N,_).

#show left/2.
#show nullleft/1.
#show right/2.
#show nullright/1.

const(1..3).

1{value(N,V):const(V)}1:- node(N).

#show value/2.

height(0..3).

{extra(N,V):const(V)}1:- node(N).