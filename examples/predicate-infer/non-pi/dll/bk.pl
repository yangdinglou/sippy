:- use_module(library(lists)).
next(p1,p2).
next(p2,p3).
next(p3,p4).
next(p4,null).

prev(p1,entry).
prev(p2,p1).
prev(p3,p2).
prev(p4,p3).
prev(null,p4).


my_value(p1,1).
my_value(p2,2).
my_value(p3,3).
my_value(p4,4).

next(n1,n2).
next(n2,n3).
next(n3,n4).
next(n4,null).

prev(n1,entry).
prev(n2,n1).
prev(n3,entry).
prev(n4,n3).
prev(null,n4).


my_value(n1,1).
my_value(n2,3).
my_value(n3,2).
my_value(n4,4).

% q(p1,entry,[1,2,3,4]).
q(p2,p1,[2,3,4]).
q(p3,p2,[3,4]).
q(p4,p3,[4]).
q(null,p4,[]).

q(n3,entry,[3,4]).
q(n4,n3,[4]).
q(null,n4,[]).




zero(0).
empty([]).
nullptr(null).
entryp(entry).
