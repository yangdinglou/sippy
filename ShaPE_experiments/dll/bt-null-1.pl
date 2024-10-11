node(p1).
node(p2).
node(p3).
node(p4).

next(p1, p2).
next(p2, p3).
next(p3, p4).
next(p4, null).

prev(p1, null).
prev(p2, p1).
prev(p3, p2).
prev(p4, p3).



entrypoint(p1).