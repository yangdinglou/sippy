use_module(library(lists)).
empty([]).
nil([]).
zero(0).
nullptr(null).

cons(A, B, C) :-
    append([B], A, C).

gt_list(_, []).
gt_list(A, B) :-
    max_list(B, C), A >= C.
lt_list(_, []).
lt_list(A, B) :-
    min_list(B, C), A =< C.

gt_set(_, []).
gt_set(A, B) :-
    max_list(B, C), A >= C.
lt_set(_, []).
lt_set(A, B) :-
    min_list(B, C), A =< C.

maxnum(A, B, C) :-
    C is max(A, B).

minnum(A, B, C) :-
    C is min(A, B).

diff_lessthanone(A, B):-
    D is A - B, abs(D, AbsD), AbsD =< 1.

my_succ(A, B) :-
    B is A + 1.

my_prev(A, B) :-
    B is A - 1.

insert(A, B, C) :-
    is_ordset(A), ord_union([B], A, C).

anypointer(_).
anynumber(_).

same_ptr(A, A).

ge(A, B) :-
    A >= B.


add(A, B, C) :-
    C is A + B.


value(p1,1).
value(p2,2).
value(p3,3).
value(p4,4).

next(p1, p2).
next(p2, p3).
next(p3, p4).
next(p4, p2).


value(pp1,5).
value(pp2,8).
value(pp3,9).
value(pp4,6).
value(pp5,12).
value(pp6,15).
value(pp7,19).
value(pp8,20).

next(pp1, pp2).
next(pp2, pp3).
next(pp3, pp4).
next(pp4, pp5).
next(pp5, pp6).
next(pp6, pp7).
next(pp7, pp8).
next(pp8, pp5).

value(node_1,86).
next(node_1,node_2).
value(node_2,45).
next(node_2,node_3).
value(node_3,84).
next(node_3,node_4).
value(node_4,20).
next(node_4,node_5).
value(node_5,83).
next(node_5,node_6).
value(node_6,24).
next(node_6,node_7).
value(node_7,88).
next(node_7,node_8).
value(node_8,65).
next(node_8,node_9).
value(node_9,57).
next(node_9,node_10).
value(node_10,70).
next(node_10,node_11).
value(node_11,87).
next(node_11,node_12).
value(node_12,52).
next(node_12,node_13).
value(node_13,26).
next(node_13,node_14).
value(node_14,60).
next(node_14,node_15).
value(node_15,90).
next(node_15,node_16).
value(node_16,24).
next(node_16,node_17).
value(node_17,83).
next(node_17,node_18).
value(node_18,51).
next(node_18,node_19).
value(node_19,77).
next(node_19,node_20).
value(node_20,20).
next(node_20,node_21).
value(node_21,88).
next(node_21,node_22).
value(node_22,88).
next(node_22,node_23).
value(node_23,63).
next(node_23,node_24).
value(node_24,22).
next(node_24,node_25).
value(node_25,94).
next(node_25,node_26).
value(node_26,80).
next(node_26,node_27).
value(node_27,63).
next(node_27,node_28).
value(node_28,28).
next(node_28,node_29).
value(node_29,75).
next(node_29,node_30).
value(node_30,38).
next(node_30,node_31).
value(node_31,29).
next(node_31,node_32).
value(node_32,17).
next(node_32,node_33).
value(node_33,64).
next(node_33,node_34).
value(node_34,54).
next(node_34,node_35).
value(node_35,12).
next(node_35,node_36).
value(node_36,26).
next(node_36,node_37).
value(node_37,34).
next(node_37,node_38).
value(node_38,57).
next(node_38,node_39).
value(node_39,48).
next(node_39,node_40).
value(node_40,13).
next(node_40,node_41).
value(node_41,63).
next(node_41,node_42).
value(node_42,78).
next(node_42,node_43).
value(node_43,1).
next(node_43,node_44).
value(node_44,52).
next(node_44,node_45).
value(node_45,59).
next(node_45,node_46).
value(node_46,54).
next(node_46,node_47).
value(node_47,27).
next(node_47,node_48).
value(node_48,29).
next(node_48,node_49).
value(node_49,47).
next(node_49,node_50).
value(node_50,76).
next(node_50,node_51).
value(node_51,25).
next(node_51,node_52).
value(node_52,20).
next(node_52,node_53).
value(node_53,18).
next(node_53,node_54).
value(node_54,47).
next(node_54,node_55).
value(node_55,85).
next(node_55,node_56).
value(node_56,87).
next(node_56,node_57).
value(node_57,92).
next(node_57,node_58).
value(node_58,99).
next(node_58,node_59).
value(node_59,45).
next(node_59,node_60).
value(node_60,98).
next(node_60,node_61).
value(node_61,3).
next(node_61,node_62).
value(node_62,93).
next(node_62,node_63).
value(node_63,87).
next(node_63,node_64).
value(node_64,15).
next(node_64,node_65).
value(node_65,75).
next(node_65,node_66).
value(node_66,28).
next(node_66,node_67).
value(node_67,97).
next(node_67,node_68).
value(node_68,83).
next(node_68,node_69).
value(node_69,81).
next(node_69,node_70).
value(node_70,49).
next(node_70,node_71).
value(node_71,69).
next(node_71,node_72).
value(node_72,8).
next(node_72,node_73).
value(node_73,14).
next(node_73,node_74).
value(node_74,82).
next(node_74,node_75).
value(node_75,9).
next(node_75,node_76).
value(node_76,5).
next(node_76,node_77).
value(node_77,33).
next(node_77,node_78).
value(node_78,92).
next(node_78,node_79).
value(node_79,70).
next(node_79,node_80).
value(node_80,5).
next(node_80,node_81).
value(node_81,18).
next(node_81,node_82).
value(node_82,30).
next(node_82,node_83).
value(node_83,64).
next(node_83,node_84).
value(node_84,66).
next(node_84,node_85).
value(node_85,75).
next(node_85,node_86).
value(node_86,30).
next(node_86,node_87).
value(node_87,90).
next(node_87,node_88).
value(node_88,38).
next(node_88,node_89).
value(node_89,54).
next(node_89,node_90).
value(node_90,83).
next(node_90,node_91).
value(node_91,5).
next(node_91,node_92).
value(node_92,15).
next(node_92,node_93).
value(node_93,94).
next(node_93,node_94).
value(node_94,26).
next(node_94,node_95).
value(node_95,97).
next(node_95,node_96).
value(node_96,12).
next(node_96,node_97).
value(node_97,23).
next(node_97,node_98).
value(node_98,6).
next(node_98,node_99).
value(node_99,85).
next(node_99,node_100).
value(node_100,3).
next(node_100,node_16).

% lasso(A,B,C):- empty(C),same_ptr(A,B).
% lasso(A,B,C):- next(A,F),value(A,D),lasso(F,B,E),insert(E,D,C).