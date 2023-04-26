max_vars(2).
max_body(2).
max_clauses(3).
enable_recursion.
enable_pi.

head_pred(even,1).
body_pred(zero,1).
body_pred(prev,2).
% body_pred(succ,2).

% type(odd,(int,)).
% type(zero,(int,)).
% type(prev,(int,int)).
% type(succ,(int,int)).

% direction(even,(in,)).
% direction(zero,(in,)).
% direction(prev,(in,out)).
% % direction(succ,(in,out)).

:-
    not clause(1).
:-
    not clause(2).

:-
    head_literal(0,P,_,_),
    not head_literal(1,P,_,_).

:-
    head_literal(1,P,_,_),
    head_literal(2,P,_,_).

% :-
%     head_literal(T, P, A, _),
%     body_literal(T, P, A, _).

% :-
%     #count{A,Vars : body_literal(2,even,A,Vars)} == 0.

:-
    not head_literal(2, _, 2, _).

%% EXTRA BIAS TO REDUCE LEARNING TIME
% only_once(head).
% only_once(tail).
% only_once(prepend).
% :-
%     only_once(P),
%     clause(C),
%     #count{Vars : body_literal(C,P,A,Vars)} > 1.
% :-
%     body_literal(0,_,2,_).
% :-
%     body_literal(0,_,3,_).
% :-
%     body_literal(1,empty,_,_).

% prop(antitransitive,decrement).
% prop(antitransitive,decrement).
% prop(antitransitive,increment).
% prop(antitransitive,increment).
% prop(antitransitive,tail).
% prop(antitransitive,tail).
% prop(antitriangular,decrement).
% prop(antitriangular,decrement).
% prop(antitriangular,increment).
% prop(antitriangular,increment).
% prop(antitriangular,tail).
% prop(antitriangular,tail).
% prop(asymmetric_ab_ba,decrement).
% prop(asymmetric_ab_ba,decrement).
% prop(asymmetric_ab_ba,geq).
% prop(asymmetric_ab_ba,geq).
% prop(asymmetric_ab_ba,increment).
% prop(asymmetric_ab_ba,increment).
% prop(asymmetric_ab_ba,tail).
% prop(asymmetric_ab_ba,tail).
% prop(asymmetric_abc_acb,prepend).
% prop(asymmetric_abc_acb,prepend).
% prop(countk,empty,1).
% prop(countk,empty_out,1).
% prop(countk,even,3).
% prop(countk,odd,2).
% prop(countk,one,1).
% prop(countk,zero,1).
% prop(postcon,(element,zero)).
% prop(postcon,(head,zero)).
% prop(postcon,(increment,zero)).
% prop(pre_postcon,(empty,element,even)).
% prop(pre_postcon,(empty,element,odd)).
% prop(pre_postcon,(empty,element,one)).
% prop(pre_postcon,(empty,element,zero)).
% prop(pre_postcon,(empty,head,even)).
% prop(pre_postcon,(empty,head,odd)).
% prop(pre_postcon,(empty,head,one)).
% prop(pre_postcon,(empty,head,zero)).
% prop(pre_postcon,(empty,tail,empty)).
% prop(pre_postcon,(empty,tail,empty_out)).
% prop(pre_postcon,(empty_out,element,even)).
% prop(pre_postcon,(empty_out,element,odd)).
% prop(pre_postcon,(empty_out,element,one)).
% prop(pre_postcon,(empty_out,element,zero)).
% prop(pre_postcon,(empty_out,head,even)).
% prop(pre_postcon,(empty_out,head,odd)).
% prop(pre_postcon,(empty_out,head,one)).
% prop(pre_postcon,(empty_out,head,zero)).
% prop(pre_postcon,(empty_out,tail,empty)).
% prop(pre_postcon,(empty_out,tail,empty_out)).
% prop(pre_postcon,(even,decrement,even)).
% prop(pre_postcon,(even,decrement,zero)).
% prop(pre_postcon,(even,increment,even)).
% prop(pre_postcon,(even,increment,zero)).
% prop(pre_postcon,(odd,decrement,odd)).
% prop(pre_postcon,(odd,decrement,one)).
% prop(pre_postcon,(odd,increment,odd)).
% prop(pre_postcon,(odd,increment,one)).
% prop(pre_postcon,(odd,increment,zero)).
% prop(pre_postcon,(one,decrement,odd)).
% prop(pre_postcon,(one,decrement,one)).
% prop(pre_postcon,(one,increment,odd)).
% prop(pre_postcon,(one,increment,one)).
% prop(pre_postcon,(one,increment,zero)).
% prop(pre_postcon,(zero,decrement,even)).
% prop(pre_postcon,(zero,decrement,odd)).
% prop(pre_postcon,(zero,decrement,one)).
% prop(pre_postcon,(zero,decrement,zero)).
% prop(pre_postcon,(zero,geq,odd)).
% prop(pre_postcon,(zero,geq,one)).
% prop(pre_postcon,(zero,increment,even)).
% prop(pre_postcon,(zero,increment,zero)).
% prop(precon,(empty,element)).
% prop(precon,(empty,head)).
% prop(precon,(empty,tail)).
% prop(precon,(empty_out,element)).
% prop(precon,(empty_out,head)).
% prop(precon,(empty_out,tail)).
% prop(precon,(zero,decrement)).
% prop(unique_a_b,decrement).
% prop(unique_a_b,decrement).
% prop(unique_a_b,head).
% prop(unique_a_b,head).
% prop(unique_a_b,increment).
% prop(unique_a_b,increment).
% prop(unique_a_b,tail).
% prop(unique_a_b,tail).
% prop(unique_ab_c,prepend).
% prop(unique_ab_c,prepend).
% prop(unique_ac_b,prepend).
% prop(unique_ac_b,prepend).
% prop(unique_b_a,decrement).
% prop(unique_b_a,decrement).
% prop(unique_b_a,increment).
% prop(unique_b_a,increment).
% prop(unique_bc_a,prepend).
% prop(unique_bc_a,prepend).
% prop(unique_c_ab,prepend).
% prop(unique_c_ab,prepend).
% prop(unsat_pair,increment,decrement).
% prop(unsat_pair,increment,decrement).
% prop(unsat_pair,increment,geq).
% prop(unsat_pair,increment,geq).
% prop(unsat_pair,odd,even).
% prop(unsat_pair,odd,even).
% prop(unsat_pair,one,even).
% prop(unsat_pair,one,even).
% prop(unsat_pair,zero,odd).
% prop(unsat_pair,zero,odd).
% prop(unsat_pair,zero,one).
% prop(unsat_pair,zero,one).