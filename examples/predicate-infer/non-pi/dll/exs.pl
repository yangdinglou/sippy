pos(p(p1,entry,[1,2,3,4])).
pos(p(p2,p1,[2,3,4])).
pos(p(p3,p2,[3,4])).
pos(p(p4,p3,[4])).
pos(p(null,p4,[])).
pos(p(n3,entry,[2,4])).
pos(p(n4,n3,[4])).
pos(p(null,n4,[])).

neg(p(n1,entry,[1,2,3,4])).
neg(p(n2,n1,[2,3,4])).
neg(p(n2,n3,[1,2,3,4])).
