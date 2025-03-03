%%%%%%%%%% EXAMPLE LOADING %%%%%%%%%%
:- dynamic
    neg_index/2.

load_examples:-
    load_pos,
    load_neg.

load_pos:-
    current_predicate(pos/1),!,
    findall(X, pos(X), Pos),
    assert_pos_aux(Pos,1).
load_pos.

load_neg:-
    current_predicate(neg/1),!,
    findall(X, neg(X), Neg),
    assert_neg_aux(Neg,-1).
load_neg.

assert_pos_aux([],_).
assert_pos_aux([H|T],I1):-
    assertz(pos_index(I1, H)),
    I2 is I1+1,
    assert_pos_aux(T,I2).

assert_neg_aux([],_).
assert_neg_aux([H|T],I1):-
    assertz(neg_index(I1, H)),
    I2 is I1-1,
    assert_neg_aux(T,I2).

%%%%%%%%%% EXAMPLE TESTING %%%%%%%%%%

ex_index(ID,Atom):-
    current_predicate(pos_index/2),
    pos_index(ID,Atom).
ex_index(ID,Atom):-
    current_predicate(neg_index/2),
    neg_index(ID,Atom).

%% test_ex(Atom):-
%%     current_predicate(timeout/1),!,
%%     timeout(T),
%%     catch(call_with_time_limit(T, call(Atom)),time_limit_exceeded,false),!.

test_ex(X):-
    current_predicate(timeout/1),!,
    timeout(T),
    catch(call_with_time_limit(T, call(X)),time_limit_exceeded,false),!.
    %% call_with_inference_limit(call(X), 100000, Result),!,
    %% call_with_inference_limit(call(X), 10000, Result),!,
    %% Result \= inference_limit_exceeded.

test_ex(Atom):-
    call(Atom),!.

pos_covered(Xs):-
    findall(ID, (pos_index(ID,Atom),test_ex(Atom)), Xs).

neg_covered(Xs):-
    findall(ID, (neg_index(ID,Atom),test_ex(Atom)), Xs).

inconsistent:-
    neg_index(_,Atom),
    test_ex(Atom),!.

sat:-
    pos_index(_,Atom),
    test_ex(Atom),!.

%% ========== FUNCTIONAL CHECKS ==========
non_functional:-
    pos(Atom),
    non_functional(Atom),!.

%% %% ========== REDUNDANCY CHECKS ==========

subsumes(C,D) :- \+ \+ (copy_term(D,D2), numbervars(D2,0,_), subset(C,D2)).

subset([], _D).
subset([A|B], D):-
    member(A, D),
    subset(B,D).

redundant_literal(C1):-
    select(_,C1,C2),
    subsumes(C1,C2),!.

redundant_clause(P1):-
    select(C1,P1,P2),
    member(C2,P2),
    subsumes(C1,C2),!.

%% %% TODO: ADD MEANINGFUL COMMENT
find_redundant_rule(P1,K1,K2):-
    select(K1-C1,P1,P2),
    member(K2-C2,P2),
    subsumes(C1,C2),!.


% new for positive only

countt(List, T, Count) :-
    include(=(T), List, Filtered),
    length(Filtered, Count).

eval_head(Ex, Inlist, 0, 0, Inlist) :- =(Ex, !), !.

eval_head(Ex, Inlist, 0, -10, Inlist) :- functor(Ex, P, _), my_call(Ex), member(P,[anypointer, anycolor, anynumber]), !.
eval_head(Ex, Inlist, 0, 4, Inlist) :- functor(Ex, P, _), my_call(Ex), member(P,[diff_lessthanone,ge,le]), !.
eval_head(Ex, Inlist, 0, 2, Inlist) :- functor(Ex, P, _), my_call(Ex), member(P,[black,red]), !.
eval_head(Ex, Inlist, 0, 8, Inlist) :- functor(Ex, P, _), my_call(Ex), member(P,[equal, min_list, delete, max_list, select, zero, one, minusone, add, minus, my_succ, my_prev, same_ptr, maxnum, minnum, gt_list, lt_list, gt_set, lt_set, ord_union, insert, cons, append, nullptr, empty, nil]), !.
eval_head(Ex, Inlist, FactV, 0, Outlist) :- clause(Ex, true), my_call(Ex), append(Inlist, [Ex], Outlist), countt(Outlist, Ex, Cnt), FactV is 1/Cnt, !.

eval_head(Ex, Inlist, FactV, SpecV, Outlist) :- my_clause(Ex, RawbodyList), eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist), !.

eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist) :- RawbodyList =..BodyList, first_rest(BodyList, ',', Bodyss), first_rest(Bodyss, H, Bodys), eval_head(H, Inlist, FactV0, SpecV0, Inlist1), first_rest(Bodys, Body, _), eval_body(Body, Inlist1, FactV1, SpecV1, Outlist), FactV is FactV0 + FactV1, SpecV is SpecV0 + SpecV1, !.

eval_body(RawbodyList, Inlist, FactV, SpecV, Outlist) :- RawbodyList =..BodyList, \+ first_rest(BodyList, ',', _), eval_head(RawbodyList, Inlist, FactV, SpecV, Outlist),!.

first_rest([Fst|Rst], Fst, Rst).

my_clause(Ex, Body) :- clause(Ex, Body), my_call(Body), !.
my_call(Ex):- call(Ex), !.


scores(Ex, FactNum, AllFactV, Callnum, SpecV) :- eval_head(Ex, [], AllFactV, SpecV, Outlist), length(Outlist, Callnum), list_to_set(Outlist, Outset), length(Outset, FactNum).