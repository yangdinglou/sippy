node(p1).
node(p2).
node(p3).

next(p1, p2).
next(p2, p3).
next(p3, null).

child(p1, p11).
child(p2, p21).
child(p3, p31).

node(p11).
node(p12).
node(p13).
node(p21).
node(p22).
node(p31).
node(p32).
node(p33).


next(p11, p12).
next(p12, p13).
next(p13, null).
next(p21, p22).
next(p22, null).
next(p31, p32).
next(p32, p33).
next(p33, null).

value(p11, v).
value(p12, v).
value(p13, v).
value(p21, v).
value(p22, v).
value(p31, v).
value(p32, v).
value(p33, v).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
node(n1).
node(n2).
node(n3).

next(n1, n2).
next(n2, n3).
next(n3, null).

child(n1, n11).
child(n2, n21).
child(n3, n31).

node(n11).
node(n12).
node(n13).
node(n14).%
node(n21).
node(n22).
node(n31).
node(n32).
node(n33).
node(n33).


next(n11, n12).
next(n12, n13).
next(n13, n14).%
next(n21, n22).
next(n22, null).
next(n31, n32).
next(n32, n33).
next(n33, null).

value(n11, v).
value(n12, v).
value(n13, v).
value(n21, v).
value(n22, v).
value(n31, v).
value(n32, v).
value(n33, v).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
node(np1).
node(np2).
node(np3).

next(np1, np2).
next(np2, np3).
next(np3, null).

child(np1, np11).
child(np2, np21).
child(np3, np31).

node(np11).
node(np12).
node(np13).
node(np14).%
node(np21).
node(np22).
node(np31).
node(np32).
node(np33).


next(np11, np12).
next(np12, np13).
next(np13, null).
next(np21, np22).
next(np22, null).
next(np31, np32).
next(np32, np33).
next(np33, null).

value(np11, np14).%
value(np12, v).
value(np13, v).
value(np21, v).
value(np22, v).
value(np31, v).
value(np32, v).
value(np33, v).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
node(npp1).
node(npp2).
node(npp3).
node(npp4).%

next(npp1, npp2).
next(npp2, npp3).
next(npp3, npp4).%

child(npp1, npp11).
child(npp2, npp21).
child(npp3, npp31).

node(npp11).
node(npp12).
node(npp13).
node(npp21).
node(npp22).
node(npp31).
node(npp32).
node(npp33).


next(npp11, npp12).
next(npp12, npp13).
next(npp13, null).
next(npp21, npp22).
next(npp22, null).
next(npp31, npp32).
next(npp32, npp33).
next(npp33, null).

value(npp11, v).
value(npp12, v).
value(npp13, v).
value(npp21, v).
value(npp22, v).
value(npp31, v).
value(npp32, v).
value(npp33, v).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
node(pp1).
node(pp2).
node(pp3).

next(pp1, pp2).
next(pp2, pp3).
next(pp3, null).

child(pp1, null).
child(pp2, pp21).
child(pp3, pp31).


node(pp21).
node(pp22).
node(pp31).
node(pp32).
node(pp33).



next(pp21, pp22).
next(pp22, null).
next(pp31, pp32).
next(pp32, pp33).
next(pp33, null).


value(pp21, v).
value(pp22, v).
value(pp31, v).
value(pp32, v).
value(pp33, v).

nullptr(null).

is_value(v).
zero(0).