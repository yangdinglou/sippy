pos(btree(aa,[5,10,12,15])). %4
pos(btree(a, [5,10,20,25,30,40,45,50,55,70])). %11
pos(btree(n_1, [5, 10, 12, 15, 18, 20, 22, 25, 28, 30, 32, 35, 38, 40, 42, 50, 53, 55, 58, 60, 62, 65, 68, 75, 80, 82, 88, 90, 93, 95, 97])).

% neg(f(n1,[1,2,3,4])).

% 16*2+7+16n+7n  44*2+14+44n+21n

% arg = 4, score = 131+362
% arg = 8, score = 223+622
% arg = 12, score = 315+882

% n*(2+arg)+ arg*n/2