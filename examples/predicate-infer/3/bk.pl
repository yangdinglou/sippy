% % succ(A,B):-
% %     B is A + 1.
my_min_list(List,Min):-
    ground(List),
    min_list(List,Min).