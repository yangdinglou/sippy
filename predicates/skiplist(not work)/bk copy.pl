equal(A, B):- =(A, B).

forward(phead1, p12).
forward(p12, ptail1).
forward(ptail1, ptail1).

forward(phead2, p22).
forward(p22, p29).
forward(p29, ptail2).
forward(ptail2, ptail2).

forward(phead3, p32).
forward(p32, p39).
forward(p39, ptail3).
forward(ptail3, ptail3).

forward(phead4, p42).
forward(p42, p45).
forward(p45, p46).
forward(p46, p49).
forward(p49, ptail4).
forward(ptail4, ptail4).



forward(phead5, p51).
forward(p51, p52).
forward(p52, p53).
forward(p53, p54).
forward(p54, p55).
forward(p55, p56).
forward(p56, p57).
forward(p57, p58).
forward(p58, p59).
forward(p59, p510).
forward(p510, ptail5).
forward(ptail5, ptail5).


down(phead1, phead2).
down(phead2, phead3).
down(phead3, phead4).
down(phead4, phead5).
down(phead5, phead5).

down(p51, p51). %4

down(p12, p22). %12
down(p22, p32).
down(p32, p42).
down(p42, p52).
down(p52, p52).

down(p53, p53). %20

down(p54, p54). %26

down(p45, p55). %27
down(p55, p55).

down(p46, p56). %34
down(p56, p56). 

down(p57, p57). %37

down(p58, p58). %43

down(p29, p39). %45
down(p39, p49).
down(p49, p59).
down(p59, p59).

down(p510, p510). %60

down(ptail1, ptail2).
down(ptail2, ptail3).
down(ptail3, ptail4).
down(ptail4, ptail5).
down(ptail5, ptail5).

forward(qhead1, q11).
forward(q11, qtail1).
forward(qtail1, qtail1).

forward(qhead2, q21).
forward(q21, qtail2).
forward(qtail2, qtail2).

forward(qhead3, q31).
forward(q31, q34).
forward(q34, q35).
forward(q35, q38).
forward(q38, qtail3).
forward(qtail3, qtail3).

forward(qhead4, q41).
forward(q41, q42).
forward(q42, q43).
forward(q43, q44).
forward(q44, q45).
forward(q45, q46).
forward(q46, q47).
forward(q47, q48).
forward(q48, qtail4).

down(qhead1, qhead2).
down(qhead2, qhead3).
down(qhead3, qhead4).
down(qhead4, qhead4).

down(q11, q21). %3
down(q21, q31).
down(q31, q41).
down(q41, q41).

down(q42, q42). %6

down(q43, q43). %9

down(q34, q44). %26
down(q44, q44).

down(q35, q45). %30
down(q45, q45).

down(q46, q46). %41

down(q47, q47). %58

down(q38, q48). %72
down(q48, q48).

down(qtail1, qtail2).
down(qtail2, qtail3).
down(qtail3, qtail4).
down(qtail4, qtail4).



eval_head(Ex, Inlist, 0, Inlist) :- =(Ex, !), !.
eval_head(Ex, Inlist, V, Outlist) :- clause(Ex, true), call(Ex), append(Inlist, [Ex], Outlist), countt(Outlist, Ex, Cnt), V is 1/Cnt, !.


% eval_head(Ex, 4) :- functor(Ex, P, _), call(Ex), member(P,[diff_lessthanone]), !.
eval_head(Ex, Inlist, 8, Inlist) :- functor(Ex, P, _), call(Ex), member(P,[equal, diff_lessthanone, min_list, delete, max_list, select, zero, one, add, minus, my_succ, my_prev, maxnum, minnum, gt_list, lt_list, ord_union, insert]), !.
eval_head(Ex, Inlist, V, Outlist) :- clause(Ex, RawbodyList), call(RawbodyList), eval_body(RawbodyList, Inlist, V, Outlist).

eval_body(RawbodyList, Inlist, V, Outlist) :- RawbodyList =..BodyList, first_rest(BodyList, ',', Bodyss), first_rest(Bodyss, H, Bodys), eval_head(H, Inlist, V0, Inlist1), first_rest(Bodys, Body, _), eval_body(Body, Inlist1, V1, Outlist), V is V0 + V1, !.

eval_body(RawbodyList, Inlist, V, Outlist) :- RawbodyList =..BodyList, \+ first_rest(BodyList, ',', _), eval_head(RawbodyList, Inlist, V, Outlist).

first_rest([Fst|Rst], Fst, Rst).

% teval_all(Vs):- 
%     catch(call_with_time_limit(1, eval_all(Vs)),time_limit_exceeded,=(Vs, 0)),!.

% eval_all(Vs):-
%     findall(V, (pos(Atom), eval_phead(Atom, V)), Vs_list), sum_list(Vs_list, Vs).

skiplist(X, P) :- equal(X, P), !.
skiplist(X, P) :- down(X, Y), equal(X, Y), forward(X, Z), equal(Z, P), !.
skiplist(X, P) :- down(X, Y), forward(X, Z), down(Z, ZD), skiplist(Z, P), skiplist(Y, ZD).

% skiplist(A,B):- equal(B,A), !.
% skiplist(A,B):- down(A,B),forward(A,C),skiplist(C,A), !.
% skiplist(A,B):- down(A,D),down(D,E),forward(A,C),skiplist(D,E),skiplist(B,C), !.


count(List, Condition, Count) :-
    include(Condition, List, Filtered),
    length(Filtered, Count).

countt(List, T, Count) :-
    include(equal(T), List, Filtered),
    length(Filtered, Count).

f(Ex, X, OutSet, Cnt):- eval_head(Ex, [], X, Outlist), list_to_set(Outlist, OutSet), maplist(countt(Outlist),OutSet,Cnt).