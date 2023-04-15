my_insert(A, B, C) :-
    ground(A),ground(B),
    ord_union([B], A, C).
my_union(A, B, C) :-
    ground(A),ground(B),
    ord_union(A,B,C).

empty([]).

nullptr(null).

value(p1,4).
value(p11,3).
value(p12,4).
value(p121,6).
value(p112,2).

next1(p1,q11).
next1(p11,q111).
next1(p12,q121).
next1(p121,null).
next1(p112,q1121).

next2(q11,q12).
next2(q12,null).
next2(q121,q122).
next2(q122,null).
next2(q111,q112).
next2(q112,null).
next2(q1121,null).

pointto(q11,p11).
pointto(q12,p12).
pointto(q121,p121).
pointto(q122,null).
pointto(q111,null).
pointto(q112,p112).
pointto(q1121,null).

p(A):-nullptr(A).
p(A):-next1(A,B),inv1(B).
inv1(A):-nullptr(A).
inv1(A):-pointto(A,C),next2(A,B),p(C),inv1(B).