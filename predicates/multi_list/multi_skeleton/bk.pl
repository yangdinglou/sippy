nullptr(null).

next(p1, p2).
next(p2, p3).
next(p3, null).

child(p1, p11).
child(p2, p21).
child(p3, p31).



next(p11, p12).
next(p12, p13).
next(p13, null).
next(p21, p22).
next(p22, null).
next(p31, p32).
next(p32, p33).
next(p33, null).

% value(p11, v).
% value(p12, v).
% value(p13, v).
% value(p21, v).
% value(p22, v).
% value(p31, v).
% value(p32, v).
% value(p33, v).

next(pp1, pp2).
next(pp2, pp3).
next(pp3, null).

child(pp1, null).
child(pp2, pp21).
child(pp3, pp31).




next(pp21, pp22).
next(pp22, null).
next(pp31, pp32).
next(pp32, pp33).
next(pp33, null).


% value(pp21, v).
% value(pp22, v).
% value(pp31, v).
% value(pp32, v).
% value(pp33, v).

p(A):-nullptr(A).
p(A):-inv1(B),child(A,B),next(A,C),p(C).
inv1(A):-nullptr(A).
inv1(A):-next(A,C),inv1(C).