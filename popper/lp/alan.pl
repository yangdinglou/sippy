%% ##################################################
%% THIS FILE CONTAINS THE ASP PROGRAM GENERATOR, CALLED ALAN
%% ##################################################

#defined direction/2.
#defined type/2.
#defined invented/2.
#defined lower/2.

#defined enable_pi/0.
#defined enable_recursion/0.
#defined non_datalog/0.
#defined allow_singletons/0.
#defined body_singletons/0.
#defined custom_max_size/1.

#show head_literal/4.
#show body_literal/4.
#show direction_/3.
#show before/2.
% #show size/1.
#show tmpout/1.
% #show var_in_literal/4.

#heuristic size(N). [1000-N,true]

:- #sum{K+1,Clause : body_size(Clause,K)} > (b+5)*c/2, max_body(b), max_clauses(c).



max_size(K):-
    custom_max_size(K).
max_size(K):-
    not custom_max_size(_),
    max_body(M),
    max_clauses(N),
    K = (M+1)*N.
size(N):-
    max_size(MaxSize),
    N = 2..MaxSize,
    #sum{K+1,Rule : body_size(Rule,K)} == N.
:- not size(_).

pi_or_rec:-
    recursive.
pi_or_rec:-
    pi.
pi_or_rec_enabled:-
    enable_pi.
pi_or_rec_enabled:-
    enable_recursion.

%% prohibit multi-clause programs when no recursion or PI
:-
    clause(1),
    not pi_or_rec.

%% AC: @DC, this constraint might mess up the work on negation
:-
    enable_recursion,
    not pi,
    clause(Rule),
    Rule > 0,
    not recursive_clause(Rule,_,_).

%% head pred symbol if given by user or invented
head_aux(P,A):-
    head_pred(P,A).
head_aux(P,A):-
    invented(P,A).

%% body pred symbol if given by user or invented
body_aux(P,A):-
    body_pred(P,A).
body_aux(P,A):-
    invented(P,A).
body_aux(P,A):-
    head_aux(P,A),
    enable_recursion.

%% ********** BASE CASE (RULE 0) **********
head_literal(0,P,A,Vars):-
    head_pred(P,A),
    head_vars(A,Vars).

1 {body_literal(0,P,A,Vars): body_aux(P,A), vars(A,Vars), not type_mismatch(P,Vars), not bad_body(P,A,Vars)} M :-
    max_body(M).

%% ********** RECURSIVE CASE (RULE > 0) **********
%% THE SYMBOL INV_K CANNOT APPEAR IN THE HEAD OF CLAUSE C < K
0 {head_literal(Rule,P,A,Vars): head_vars(A,Vars), head_aux(P,A), index(P,I), Rule >= I} 1:-
    Rule = 1..N-1,
    max_clauses(N),
    pi_or_rec_enabled.

1 {body_literal(Rule,P,A,Vars): body_aux(P,A), vars(A,Vars), not bad_body(P,A,Vars), not type_mismatch(P,Vars)} M :-
    clause(Rule),
    Rule > 0,
    max_body(M),
    enable_recursion,
    not enable_pi.

%% ********** INVENTED RULES **********
1 {body_literal(Rule,P,A,Vars): body_aux(P,A), vars(A,Vars)} M :-
    clause(Rule),
    Rule > 0,
    max_body(M),
    enable_pi.


bad_body(P,A,Vars):-
    head_pred(P,A),
    vars(A,Vars),
    not good_vars(A,Vars).
good_vars(A,Vars1):-
    head_vars(A,Vars2),
    var_member(V,Vars1),
    not var_member(V,Vars2).
bad_body(P,A,Vars2):-
    num_in_args(P,1),
    head_pred(P,A),
    head_vars(A,Vars1),
    vars(A,Vars2),
    var_pos(Var,Vars1,Pos1),
    var_pos(Var,Vars2,Pos2),
    direction_(P,Pos1,in),
    direction_(P,Pos2,in).

type_mismatch(P,Vars):-
    var_pos(Var,Vars,Pos),
    type(P,Types),
    pred_arg_type(P,Pos,T1),
    fixed_var_type(Var,T2),
    T1 != T2.

% calls_invented(Rule):-
%     invented(P,A),
%     body_literal(Rule,P,A,_).
% :-
%     pi,
%     not recursive,
%     head_literal(Rule,P,A,_),
%     head_pred(P,A),
%     not calls_invented(Rule).


%% THERE IS A CLAUSE IF THERE IS A HEAD LITERAL
clause(C):-
    head_literal(C,_,_,_).

%% NUM BODY LITERALS OF A CLAUSE
%% TODO: IMPROVE AS EXPENSIVE
%% grounding is > c * (n choose k), where n = |Herbrand base| and k = MaxN
body_size(Rule,N):-
    clause(Rule),
    max_body(MaxN),
    N > 0,
    N <= MaxN,
    #count{P,Vars : body_literal(Rule,P,_,Vars)} == N.

%% USE CLAUSES IN ORDER
:-
    clause(C1),
    C1 > 1,
    C2 = 0..C1-1,
    not clause(C2).

%% USE VARS IN ORDER IN A CLAUSE
%% :-
%%     clause_var(C,Var1),
%%     Var1 > 1,
%%     Var2 = Var1-1,
%%     %% Var2 = 1..Var1-1,
%%     not clause_var(C,Var2).

%% USE VARS IN ORDER IN A CLAUSE
:-
    clause_var(C,Var1),
    Var1 > 1,
    Var2 = 1..Var1-1,
    not clause_var(C,Var2).

%% ##################################################
%% VARS ABOUT VARS - META4LIFE
%% ##################################################
#script (python)
from itertools import permutations
from clingo.symbol import Tuple_, Number
def mk_tuple(xs):
    return Tuple_([Number(x) for x in xs])
def pyhead_vars(arity):
    return mk_tuple(range(arity.number))
def pyvars(arity, max_vars):
    for x in permutations(range(max_vars.number),arity.number):
        yield mk_tuple(x)
def pyvar_pos(pos, vars):
    return vars.arguments[pos.number]
#end.

%% POSSIBLE VAR
var(0..N-1):-
    max_vars(N).

%% CLAUSE VAR
clause_var(C,Var):-
    head_var(C,Var).
clause_var(C,Var):-
    body_var(C,Var).

%% HEAD VAR
head_var(C,Var):-
    head_literal(C,_,_,Vars),
    var_member(Var,Vars).
%% BODY VAR
body_var(C,Var):-
    body_literal(C,_,_,Vars),
    var_member(Var,Vars).

%% VAR IN A TUPLE OF VARS
var_member(Var,Vars):-
    var_pos(Var,Vars,_).

%% VAR IN A LITERAL
var_in_literal(C,P,Vars,Var):-
    head_literal(C,P,_,Vars),
    var_member(Var,Vars).
var_in_literal(C,P,Vars,Var):-
    body_literal(C,P,_,Vars),
    var_member(Var,Vars).


tmpout(N):- #max{Var: var_in_literal(_,_,_,Var)} ==N.

%% HEAD VARS ARE ALWAYS 0,1,...,A-1
head_vars(A,@pyhead_vars(A)):-
    head_pred(_,A).
head_vars(A,@pyhead_vars(A)):-
    invented(_,A).

%% NEED TO KNOW LITERAL ARITIES
seen_arity(A):-
    head_pred(_,A).
seen_arity(A):-
    body_pred(_,A).
max_arity(K):-
    not max_pi_arity(_),
    #max{A : seen_arity(A)} == K.
max_arity(K):-
    max_pi_arity(K).

:-
    max_pi_arity(K),
    not invented(_,K).

% direction_(inv1,Pos,in):-
%     max_pi_arity(K),
%     Pos = 0..K-1.


%% POSSIBLE VARIABLE PERMUTATIONS FROM 1..MAX_ARITY
vars(A,@pyvars(A,MaxVars)):-
    max_vars(MaxVars),
    max_arity(K),
    A=1..K.

%% POSITION OF VAR IN TUPLE
var_pos(@pyvar_pos(Pos,Vars),Vars,Pos):-
    vars(A,Vars),
    Pos = 0..A-1.

%% %% ##################################################
%% %% REDUCE CONSTRAINT GROUNDING BY ORDERING CLAUSES
%% %% ##################################################
before(C1,C2):-
    C1 < C2,
    head_literal(C1,P,_,_),
    head_literal(C2,Q,_,_),
    lower(P,Q).

before(C1,C2):-
    C1 < C2,
    head_literal(C1,P,_,_),
    head_literal(C2,P,_,_),
    not recursive_clause(C1,P,A),
    recursive_clause(C2,P,A).

before(C1,C2):-
    C1 < C2,
    head_literal(C1,P,A,_),
    head_literal(C2,P,A,_),
    not recursive_clause(C1,P,A),
    not recursive_clause(C2,P,A),
    body_size(C1,K1),
    body_size(C2,K2),
    K1 < K2.

before(C1,C2):-
    C1 < C2,
    head_literal(C1,P,_,_),
    head_literal(C2,P,_,_),
    recursive_clause(C1,P,A),
    recursive_clause(C2,P,A),
    body_size(C1,K1),
    body_size(C2,K2),
    K1 < K2.

%% count_lower(P,N):-
%%     head_literal(_,P,_,_),
%%     #count{Q : lower(Q,P)} == N.

%% min_clause(C,N+1):-
%%     recursive_clause(C,P,A),
%%     count_lower(P,N).

%% min_clause(C,N):-
%%     head_literal(C,P,A,_),
%%     not recursive_clause(C,P,A),
%%     count_lower(P,N).

%% lower(R1,R2):-
%%     rule(R1),
%%     rule(R2),
%%     R1 != R2,
%%     not recursive(R1),
%%     not recursive(R2),
%%     size(R1,K1),
%%     size(R2,K2),
%%     K1 < K2.

%% lower(R1,R2):-
%%     rule(R1),
%%     rule(R2),
%%     R1 != R2,
%%     not recursive(R1),
%%     recursive(R2).

%% lower(R1,R2):-
%%     rule(R1),
%%     rule(R2),
%%     R1 != R2,
%%     recursive(R1),
%%     recursive(R2),
%%     size(R1,K1),
%%     size(R2,K2),
%%     K1 < K2.

%% ##################################################
%% BIAS CONSTRAINTS
%% ##################################################
%% DATALOG
:-
    not non_datalog,
    head_var(C,Var),
    not body_var(C,Var).

%% ELIMINATE SINGLETONS
:-
    not allow_singletons,
    clause_var(C,Var),
    #count{P,Vars : var_in_literal(C,P,Vars,Var)} == 1.

:-
    not body_singletons,
    body_var(C,Var),
    #count{P,Vars : var_in_literal(C,P,Vars,Var)} == 1.

%% MUST BE CONNECTED
head_connected(C,Var):-
    head_var(C,Var).
head_connected(C,Var1):-
    head_literal(C,_,A,_),
    Var1 >= A,
    head_connected(C,Var2),
    body_literal(C,_,_,Vars),
    var_member(Var1,Vars),
    var_member(Var2,Vars),
    Var1 != Var2.
:-
    head_literal(C,_,A,_),
    Var >= A,
    body_var(C,Var),
    not head_connected(C,Var).


%% %% %% ##################################################
%% %% %% ROLF MOREL'S ORDERING CONSTRAINT
%% %% %% IT REDUCES THE NUMBER OF MODELS BUT DRASTICALLY INCREASES GROUNDING AND SOLVING TIME
%% %% %% ##################################################
%% bfr(C,(P,PArgs),(Q,QArgs)) :- head_literal(C,P,_,PArgs),body_literal(C,Q,_,QArgs).
%% bfr(C,(P,PArgs),(Q,QArgs)) :- body_literal(C,P,_,PArgs),body_literal(C,Q,_,QArgs),P<Q.
%% bfr(C,(P,PArgs1),(P,PArgs2)) :- body_literal(C,P,PA,PArgs1),body_literal(C,P,PA,PArgs2),PArgs1<PArgs2.

%% not_var_first_lit(C,V,(P,PArgs)) :- bfr(C,(Q,QArgs),(P,PArgs)),var_member(V,QArgs),var_member(V,PArgs).
%% var_first_lit(C,V,(P,PArgs)) :- body_literal(C,P,_,PArgs),var_member(V,PArgs),not not_var_first_lit(C,V,(P,PArgs)).
%% :-var_first_lit(C,V,(P,PArgs)),var_first_lit(C,W,(Q,QArgs)),bfr(C,(P,PArgs),(Q,QArgs)),W<V.
%% %% :-pruned.


%% ##################################################
%% SUBSUMPTION
%% ##################################################
same_head(C1,C2):-
    C1 > 0,
    C1 < C2,
    head_literal(C1,P,A,Vars),
    head_literal(C2,P,A,Vars).

not_body_subset(C1,C2):-
    C1 > 0,
    clause(C2),
    C1 < C2,
    body_literal(C1,P,A,Vars),
    not body_literal(C2,P,A,Vars).

body_subset(C1,C2):-
    C1 > 0,
    clause(C2),
    C1 < C2,
    not not_body_subset(C1,C2),
    body_literal(C1,P,A,Vars),
    body_literal(C2,P,A,Vars).
:-
    C1 > 0,
    C1 < C2,
    same_head(C1,C2),
    body_subset(C1,C2).

%% ##################################################
%% SIMPLE TYPE MATCHING
%% ##################################################
#script (python)
def pytype(pos, types):
    return types.arguments[pos.number]
#end.

fixed_var_type(Var,@pytype(Pos,Types)):-
    head_literal(_,P,A,Vars),
    var_pos(Var,Vars,Pos),
    type(P,Types),
    head_vars(A,Vars).

pred_arg_type(P,Pos,@pytype(Pos,Types)):-
    Pos = 0..A-1,
    body_pred(P,A),
    type(P,Types).

var_type(C,Var,@pytype(Pos,Types)):-
    var_in_literal(C,P,Vars,Var),
    var_pos(Var,Vars,Pos),
    vars(A,Vars),
    type(P,Types).
:-
    clause_var(C,Var),
    #count{Type : var_type(C,Var,Type)} > 1.

%% ##################################################
%% CLAUSE ORDERING
%% ##################################################
%% AC: WHY DID I ADD THIS? ORDER SHOULD NOT MATTER
%% ORDER BY CLAUSE SIZE
%% p(A)<-q(A),r(A). (C1)
%% p(A)<-s(A). (C2)
bigger(C1,C2):-
    body_size(C1,N1),
    body_size(C2,N2),
    C1 < C2,
    N1 > N2.

%% TWO NON-RECURSIVE CLAUSES
:-
    C1 < C2,
    not recursive_clause(C1,_,_),
    not recursive_clause(C2,_,_),
    same_head(C1,C2),
    bigger(C1,C2).

%% TWO NON-RECURSIVE CLAUSES
:-
    C1 > 0,
    C1 < C2,
    recursive_clause(C1,_,_),
    recursive_clause(C2,_,_),
    same_head(C1,C2),
    bigger(C1,C2).

%% ########################################
%% RECURSION
%% ########################################
num_recursive(P,N):-
    head_literal(_,P,_,_),
    #count{C : recursive_clause(C,P,_)} == N.

recursive:-
    recursive_clause(_,_,_).

recursive_clause(C,P,A):-
    head_literal(C,P,A,_),
    body_literal(C,P,A,_).

base_clause(C,P,A):-
    head_literal(C,P,A,_),
    not body_literal(C,P,A,_).

%% NO RECURSION IN THE FIRST CLAUSE
:-
    recursive_clause(0,_,_).

%% A RECURSIVE CLAUSE MUST HAVE MORE THAN ONE BODY LITERAL
:-
    C > 0,
    recursive_clause(C,_,_),
    body_size(C,1).

%% STOP RECURSION BEFORE BASE CASES
:-
    C1 > 0,
    C1 < C2,
    recursive_clause(C1,_,_),
    base_clause(C2,_,_),
    same_head(C1,C2).

%% CANNOT HAVE RECURSION WITHOUT A BASECASE
:-
    recursive_clause(_,P,A),
    not base_clause(_,P,A).

%% DISALLOW TWO RECURSIVE CALLS
%% WHY DID WE ADD THIS??
% YDL
:-
    C > 0,
    recursive_clause(C,P,A),
    #count{Vars : body_literal(C,P,A,Vars)} > 2.

:-
    clause(C),
    head_aux(P,A),
    #count{Vars : body_literal(C,P,A,Vars)} > 2.

%% PREVENT LEFT RECURSION
%% TODO: GENERALISE FOR ARITY > 3
:-
    C > 0,
    num_in_args(P,1),
    head_literal(C,P,A,Vars1),
    body_literal(C,P,A,Vars2),
    var_pos(Var,Vars1,Pos1),
    var_pos(Var,Vars2,Pos2),
    direction_(P,Pos1,in),
    direction_(P,Pos2,in).

%% TODO: Dangerous rules, can cause failure commenting out for now
% :-
%     Rule > 0,
%     head_literal(Rule,P,_,(A,_)),
%     body_literal(Rule,P,_,(_,A)).
%
% :-
%     Rule > 0,
%     head_literal(Rule,P,_,(_,A)),
%     body_literal(Rule,P,_,(A,_)).

%% PREVENT LEFT RECURSION FOR ARITY 3
:-
    C > 0,
    num_in_args(P,2),
    head_literal(C,P,A,Vars1),
    body_literal(C,P,A,Vars2),
    Var1 != Var2,
    var_pos(Var1,Vars1,V1Pos1),
    var_pos(Var1,Vars2,V1Pos2),
    direction_(P,V1Pos1,in),
    direction_(P,V1Pos2,in),
    var_pos(Var2,Vars1,V2Pos1),
    var_pos(Var2,Vars2,V2Pos2),
    direction_(P,V2Pos1,in),
    direction_(P,V2Pos2,in).


% :-
%     C > 0,
%     var(V),
%     not head_var(C, V),
%     var_type(C, V, integer),
%     body_var(C, V),
%     #count{P,Vars : body_literal(C,P,_,Vars), var_pos(V, Vars, Pos), direction_(P, Pos, in)} > 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ENSURES INPUT VARS ARE GROUND
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#script (python)
def pydirection(pos, directions):
    return directions.arguments[pos.number]
def pylen(directions):
    return Number(len(directions.arguments))
#end.

arity(P,A):-
    head_aux(P,A).
arity(P,A):-
    body_aux(P,A).

direction_aux(P, @pylen(Directions), Directions):-
    direction(P,Directions).

direction_(P,Pos,@pydirection(Pos,Directions)):-
    arity(P,A),
    Pos=0..A-1,
    direction_aux(P,A,Directions).

num_in_args(P,N):-
    direction_(P,_,_),
    #count{Pos : direction_(P,Pos,in)} == N.

%% VAR SAFE IF HEAD INPUT VAR
safe_bvar(Rule,Var):-
    head_literal(Rule,P,_,Vars),
    var_pos(Var,Vars,Pos),
    direction_(P,Pos,in).

%% VAR SAFE IF A OUTPUT VAR
safe_bvar(Rule,Var):-
    body_literal(Rule,P,_,Vars),
    num_in_args(P,0),
    var_member(Var,Vars).

%% VAR SAFE IF ALL INPUT VARS ARE SAFE
safe_bvar(Rule,Var):-
    body_literal(Rule,P,_,Vars),
    var_member(Var,Vars),
    num_in_args(P,N),
    N > 0,
    #count{Pos : var_pos(Var2,Vars,Pos), direction_(P,Pos,in), safe_bvar(Rule,Var2)} == N.

:-
    direction_(_,_,_),
    body_var(Rule,Var),
    not safe_bvar(Rule,Var).

%% ########################################
%% CLAUSES SPECIFIC TO PREDICATE INVENTION
%% ########################################
%% IDEAS FROM THE PAPER:
%% Predicate invention by learning from failures. A. Cropper and R. Morel

#script (python)
from itertools import permutations
from clingo.symbol import Tuple_, Number, Function
def mk_tuple(xs):
    return Tuple_([Number(x) for x in xs])
def py_gen_invsym(i):
    return Function(f'inv{i}')
#end.

pi:-
    invented(_,_).

%% P IS DEFNED BY AT LEAST TWO CLAUSES
num_clauses(P,N):-
    head_literal(_,P,_,_),
    #count{C : head_literal(C,P,_,_)} == N.

multiclause(P,A):-
    head_literal(_,P,A,_),
    not num_clauses(P,1).

%% INDEX FOR INVENTED SYMBOLS
index(P,0):-
    head_pred(P,_).
index(@py_gen_invsym(I),I):-
    I=1..N-1,
    max_clauses(N).

inv_symbol(P):-
    index(P,I),
    I>0.

{invented(P,A)}:-
    enable_pi,
    inv_symbol(P),
    max_arity(MaxA),
    A = 1..MaxA.

%% CANNOT INVENT A PREDICATE WITH MULTIPLE ARITIES
:-
    invented(P,_),
    #count{A : invented(P,A)} != 1.

inv_lower(P,Q):-
    enable_pi,
    inv_symbol(P),
    inv_symbol(Q),
    I < J,
    index(P,I),
    index(Q,J).
lower(P,Q):-
    head_pred(P,_),
    invented(Q,_).
lower(P,Q):-
    inv_lower(P,Q).
lower(P,Q):-
    lower(P,R),
    lower(R,Q).

%% NO RECURSIVE INVENTED CLAUSE UNLESS RECURSION IS ENABLED
:-
    not enable_recursion,
    invented(P,A),
    recursive_clause(_,P,A).

%% MUST LEARN PROGRAMS WITH ORDERED CLAUSES
:-
    C1 < C2,
    head_literal(C1,P,_,_),
    head_literal(C2,Q,_,_),
    lower(Q,P).

%% AN INVENTED SYMBOL MUST APPEAR IN THE HEAD OF A CLAUSE
:-
    invented(P,A),
    not head_literal(_,P,A,_).

%% AN INVENTED SYMBOL MUST APPEAR IN THE BODY OF A CLAUSE DEFINED BEFORE THE INVENTED ONE
appears_before(P,A):-
    invented(P,A),
    lower(Q,P),
    head_literal(C,Q,_,_),
    body_literal(C,P,_,_).

%% AN INVENTED SYMBOL MUST APPEAR IN THE BODY OF A CLAUSE
:-
    invented(P,A),
    not appears_before(P,A).

%% MUST INVENT IN ORDER
:-
    invented(P,_),
    inv_lower(Q,P),
    not invented(Q,_).

% %% FORCE ORDERING
% %% inv2(A):- inv1(A)
% :-
%     head_literal(C,P,_,_),
%     body_literal(C,Q,_,_),
%     lower(Q,P).

%% USE INVENTED SYMBOLS IN ORDER
%% f(A):- inv2(A)
%% inv2(A):- q(A)
%% TODO: ENFORCE ONLY ON ONE DIRECTLY BELOW
%% :-
    %% invented(P,_),
    %% head_literal(_,P,_,_),
    %% inv_lower(Q,P),
    %% not head_literal(_,Q,_,_).

%% PREVENT DUPLICATE INVENTED CLAUSES
%% f(A,B):-inv1(A,C),inv2(C,B).
:-
    C1 > 0,
    C2 > 0,
    C1 < C2,
    lower(P,Q),
    head_literal(C1,P,_,_),
    head_literal(C2,Q,_,_),
    invented(P,_),
    invented(Q,_),
    body_subset(C1,C2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TYPES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% INHERIT TYPE FROM CALLING PREDICATE
%% p(A,B):-inv1(A,B). (C2)
%% inv1(X,Y):-q(X,Y). (C1)
%% X and Y should inherit the types of A and B respectively
var_type(C1,Var1,Type):-
    invented(P,A),
    C1 > C2,
    head_literal(C1,P,A,Vars1),
    body_literal(C2,P,A,Vars2),
    var_pos(Var1,Vars1,Pos),
    var_pos(Var2,Vars2,Pos),
    var_type(C2,Var2,Type).

%% INHERIT TYPE FROM CALLED PREDICATE
%% p(A,B):-inv1(A,B). (C2)
%% inv1(X,Y):-q(X,Y). (C1)
%% A and B should inherit the types of X and Y respectively
var_type(C2,Var2,Type):-
    invented(P,A),
    C1 > C2,
    head_literal(C1,P,A,Vars1),
    body_literal(C2,P,A,Vars2),
    var_pos(Var1,Vars1,Pos),
    var_pos(Var2,Vars2,Pos),
    var_type(C1,Var1,Type).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DIRECTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INHERIT SAFETY FROM CALLING PREDICATE
%% p(A,B):-inv1(A,B). (C2)
%% inv1(X,Y):-q(X,Y). (C1)
%% if A is safe then X is safe
%% safe_var(C1,Var1):-
%%     C1 > 0,
%%     invented(P,A),
%%     C1 != C2,
%%     head_literal(C1,P,A,Vars1),
%%     body_literal(C2,P,A,Vars2),
%%     var_pos(Var1,Vars1,Pos),
%%     var_pos(Var2,Vars2,Pos),
%%     safe_var(C2,Var2).

%% INHERIT SAFETY FROM CALLED PREDICATE
%% p(A,B):-inv1(A,B). (C2)
%% inv1(X,Y):-q(X,Y). (C1)
%% if Y is safe then B is safe
%% safe_var(C2,Var2):-
%%     C1 > 0,
%%     invented(P,A),
%%     C1 != C2,
%%     head_literal(C1,P,A,Vars1),
%%     body_literal(C2,P,A,Vars2),
%%     var_pos(Var1,Vars1,Pos),
%%     var_pos(Var2,Vars2,Pos),
%%     safe_var(C1,Var1).

%% INHERIT DIRECTION FROM BODY LITERALS
%% TODO: IMPROVE HORRIBLE HACK
%% direction(P1,Pos1,in):-
%%     invented(P1,A1),
%%     head_literal(Clause,P1,A1,Vars1),
%%     var_pos(Var,Vars1,Pos1),
%%     body_literal(Clause,P2,_,Vars2),
%%     var_pos(Var,Vars2,Pos2),
%%     direction(P2,Pos2,in),
%%     #count{P3,Vars3: body_literal(Clause,P3,_,Vars3),var_pos(Var,Vars3,Pos3),direction(P3,Pos2,out)} == 0.

:-
    invented(P,A),
    head_literal(C,P,A,Vars),
    body_literal(C,P,A,Vars).

%% PRUNES SINGLE CLAUSE/LITERAL INVENTIONS
%% inv(A,B):-right(A,B).
:-
    invented(P,A),
    head_literal(C,P,A,_),
    body_size(C,1),
    not multiclause(P,A).

%% PREVENTS SINGLE CLAUSE/LITERAL CALLS
%% f(A,B):-inv(A,B)
:-
    head_literal(C,P,Pa,_),
    invented(Q,Qa),
    body_literal(C,Q,Qa,_),
    body_size(C,1),
    not multiclause(P,Pa).

only_once(P,A):-
    invented(P,A),
    head_literal(_,P,A,_),
    #count{C,Vars : body_literal(C,P,A,Vars)} == 1.

:-
    invented(P,_),
    #count{A : invented(P,A)} != 1.

:-
    invented(P,A),
    head_literal(C1,P,A,_),
    not multiclause(P,A),
    only_once(P,A),
    C2 < C1,
    body_literal(C2,P,A,_),
    body_size(C1,N1),
    body_size(C2,N2),
    max_body(MaxN),
    N1 + N2 - 1 <= MaxN.

%% %% ==========================================================================================

:-
    not_in(P, C),
    body_literal(C, P, _, _).




% funcional head
:-
    func_head(Head), direction(Head, (out,)),
    body_literal(T, Head, _, (B1,)),
    body_literal(T, Head, _, (B2,)),
    B1 != B2.

:-
    func_head(Head), direction(Head, (in, out)), body_literal(T, Head, _, (A, B1)),
    body_literal(T, Head, _, (A, B2)),
    B1 != B2.

:-
    func_head(Head), direction(Head, (in, in, out)),
    body_literal(T, Head, _, (A, B, C1)),
    body_literal(T, Head, _, (A, B, C2)),
    C1 != C2.

% :-
%     func_head(Head), direction(Head, (in, out)), max_clauses(Mc), T = 0..Mc-1, max_vars(Mv), A = 0..Mv-1,
%     #count{B: body_literal(T, Head, _, (A, B))} > 1.

% :-
%     func_head(Head), direction(Head, (in, in, out)), max_clauses(Mc), T = 0..Mc-1, max_vars(Mv), A1 = 0..Mv-1, A2 = 0..Mv-1,
%     #count{B: body_literal(T, Head, _, (A1, A2, B))} > 1.

% partial head

% partial_le(C, A, A) :-
%     max_body(MaxN),
%     C=0..MaxN-1,
%     max_vars(Mv), A = 0..Mv-1.

partial_le(T, A, B) :-
    var_type(T, A, integer),
    var_type(T, B, integer),
    body_literal(T, my_succ, _, (A, B)).

partial_le(T, A, B) :-
    var_type(T, A, integer),
    var_type(T, B, integer),
    body_literal(T, my_prev, _, (B, A)). 

partial_le(T, A, B) :-
    var_type(T, A, integer),
    var_type(T, B, integer),
    body_literal(T, maxnum, _, (A, _, B)).

partial_le(T, A, B) :-
    var_type(T, A, integer),
    var_type(T, B, integer),
    body_literal(T, maxnum, _, (_, A, B)).

partial_le(T, A, B) :-
    var_type(T, A, integer),
    var_type(T, B, integer),
    body_literal(T, minnum, _, (B, _, A)).

partial_le(T, A, B) :-
    var_type(T, A, integer),
    var_type(T, B, integer),
    body_literal(T, minnum, _, (_, B, A)).

partial_le(T, A, B) :-
    var_type(T, A, set),
    var_type(T, B, set),
    body_literal(T, empty, _, (A,)).

partial_le(T, A, B) :-
    var_type(T, A, set),
    var_type(T, B, set),
    body_literal(T, ord_union, _, (A,_, B)).

partial_le(T, A, B) :-
    var_type(T, A, set),
    var_type(T, B, set),
    body_literal(T, ord_union, _, (_, A, B)).

partial_le(T, A, B) :-
    var_type(T, A, set),
    var_type(T, B, set),
    body_literal(T, insert, _, (A,_, B)).

partial_le(T, A, B) :-
    partial_le(T, A, B1),
    partial_le(T, B1, B).




:-
    partial_head(Head),
    body_literal(T, Head, _, (A, B)),
    partial_le(T, A, B).

:-
    partial_head(Head),
    body_literal(T, Head, _, (A, B)),
    partial_le(T, B, A).

:-
    partial_head(Head),
    body_literal(T, Head, _, (A, B, _)),
    partial_le(T, A, B).

:-
    partial_head(Head),
    body_literal(T, Head, _, (A, B, _)),
    partial_le(T, B, A).

:-
    partial_le(T, A, B),
    partial_le(T, B, A),
    A != B.


% symmetric head

:-
    symmetric_head(Head),
    body_literal(_, Head, _, (A, B)),
    A > B.

:-
    symmetric_head(Head),
    body_literal(_, Head, _, (A, B, _)),
    A > B.



% exclusive head
:-
    exclusive_head(H1, H2),
    body_literal(T, H1, _, Args),
    body_literal(T, H2, _, Args).

% injective head: kinda slow, to be checked
:-
    injective_head(Head),
    body_literal(_, Head, _, (A1, B)),
    body_literal(_, Head, _, (A2, B)),
    A1 != A2.

:-
    injective_head(Head),
    body_literal(_, Head, _, (A, B1, C)),
    body_literal(_, Head, _, (A, B2, C)),
    B1 != B2.

:-
    injective_head(Head),
    body_literal(_, Head, _, (A1, B, C)),
    body_literal(_, Head, _, (A2, B, C)),
    A1 != A2.


% For constrain generation of input pointers

first_in_head(C, A):-
    head_literal(C, _, _,Args),
    var_pos(A, Args, 0).

% main pts (not inner), input_pointer(name, type)

var_in_body_pos(C, P, Pos, Var):-
    body_literal(C, P, _, Vars),
    var_pos(Var, Vars, Pos).
var_in_head_pos(C, P, Pos, Var):-
    head_literal(C, P, _, Vars),
    var_pos(Var, Vars, Pos).
    
out_from_this(C, Arg):-
    var_in_body_pos(C, P, 1, Arg),
    input_pointer(P, _).


body_pred(Name, 2) :- input_pointer(Name, _).
direction(Name, (in, out)) :- input_pointer(Name, _).
type(Name, (pointer, T)) :- input_pointer(Name, T).

:-
    input_pointer(Name, _),
    head_literal(1, _, _, Args),
    var_pos(A, Args, 0),
    not body_literal(1, Name, _, (A, _)).

:-
    input_pointer(Name, _),
    body_literal(T, Name, _, (A, B1)),
    body_literal(T, Name, _, (A, B2)),
    B1 != B2.

:-
    input_pointer(Name, _),
    #count{A, Vars: body_literal(1, Name, A, Vars)} != 1.

:-
    input_pointer(Name, _),
    body_literal(T, Name, _, (A, _)),
    not first_in_head(T, A).

:-
    head_literal(1, Head, _, _),
    body_literal(1, Head, _, Args),
    var_pos(A, Args, 0),
    not out_from_this(1, A).

not_in(Name, 0):-
    input_pointer(Name, _).
    

not_in(Name, 2):-
    input_pointer(Name, _).

not_in(Name, 3):-
    input_pointer(Name, _).


%  inner pts (to be invented), inner_pointer(name, type)

body_pred(Name, 2) :- inner_pointer(Name, _).
direction(Name, (in, out)) :- inner_pointer(Name, _).
type(Name, (pointer, T)) :- inner_pointer(Name, T).

:-
    inner_pointer(Name, _),
    body_literal(T, Name, _, (A, B1)),
    body_literal(T, Name, _, (A, B2)),
    B1 != B2.

:-
    input_pointer(Name, _),
    #count{A, Vars: body_literal(1, Name, A, Vars)} != 1.

:-
    inner_pointer(Name, _),
    body_literal(T, Name, _, (A, _)),
    not first_in_head(T, A).

not_in(Name, 0):-
    inner_pointer(Name, _).

not_in(Name, 1):-
    inner_pointer(Name, _).

% :-
%     inner_pointer(Name, _),
%     body_literal(T, Name, _, _),
%     head_literal(T, P, _, _),
%     not invented(P, _),

:-
    invented(P, _),
    body_literal(T, P, _, Vars1),
    body_literal(T, P, _, Vars2),
    Vars1 != Vars2.

:-
    invented(P, _),
    body_literal(0, P, _, _).

:-
    invented(P, _),
    direction(P_bad, (out,)),
    body_literal(C1, P_bad, _, (Var_bad1,)),
    var_in_head_pos(C1, P, Pos, Var_bad),
    body_literal(C2, P_bad, _, (Var_bad2,)),
    var_in_body_pos(C2, P, Pos, Var_bad2).



equal_var(C, Var3, Var4):-
    equal_var(C, Var1, Var2),
    Var1 != Var2,
    body_literal(C, P, _, Vars1),
    body_literal(C, P, _, Vars2),
    var_pos(Var1, Vars1, Pos),
    var_pos(Var2, Vars2, Pos),
    var_pos(Var3, Vars1, Pos1),
    var_pos(Var4, Vars2, Pos1),
    Pos != Pos1.



:-
    var_in_body_pos(C, P, Pos1, Varp),
    direction_(P, Pos1, in),
    var_in_body_pos(C, Q, Pos2, Varq),
    direction_(Q, Pos2, in),
    var_in_body_pos(C, Q, Pos3, Varp),
    direction_(Q, Pos3, out),
    var_in_body_pos(C, P, Pos4, Varq),
    direction_(P, Pos4, out).

:-
    var(Var), clause(C),
    #count{Vars: body_literal(C, P, _, Vars), var_pos(Var, Vars, Pos1), direction_(P, Pos1, out)}>1.

% TODO: also consider the symmetric predicates
:-
    equal_var(C, Var1, Var2),
    Var1 != Var2,
    not invented(P, _),
    not equal_pts(P,_),
    not equal_pts(_,P),
    var_in_body_pos(C, P, Pos, Var1),
    not var_in_body_pos(C, P, Pos, Var2).

equal_var(C, Var1, Var2):- equal_pts(Pt1,Pt2), body_literal(C, Pt1, _, (A,Var1)), body_literal(C, Pt2, _, (A,Var2)).

equal_var(C, Var1, Var2):-
    invented(P, _),
    var_in_head_pos(C, P, Pos1, Var1),
    var_in_head_pos(C, P, Pos2, Var2),
    equal_var(C_b, Var1_b, Var2_b),
    var_in_body_pos(C_b, P, Pos1, Var1_b),
    var_in_body_pos(C_b, P, Pos2, Var2_b).


null(C):-body_literal(C,nullptr,_,(Var,)), head_var(C, Var).
eq(C):-body_literal(C,same_ptr,_,(Var1,_)), head_var(C, Var1).

:-
	not null(0),
	not eq(0).

:-
    enable_pi,
    not null(2),
    not eq(2).