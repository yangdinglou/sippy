% funcional head
:-
    func_head(Head), direction(Head, (in, out)), body_literal(T, Head, _, (A, B1)),
    body_literal(T, Head, _, (A, B2)),
    B1 != B2.

:-
    func_head(Head), direction(Head, (in, in, out)),
    body_literal(T, Head, _, (A, B, C1)),
    body_literal(T, Head, _, (A, B, C2)),
    C1 != C2.

% partial head

partial_le(_, A, A) :-
    max_vars(Mv), A = 0..Mv-1.

partial_le(C, A, B) :-
    var_type(C, A, integer),
    var_type(C, B, integer),
    body_literal(C, my_succ, _, (A, B)).

partial_le(C, A, B) :-
    var_type(C, A, integer),
    var_type(C, B, integer),
    body_literal(C, my_prev, _, (B, A)). 

partial_le(C, A, B) :-
    var_type(C, A, integer),
    var_type(C, B, integer),
    body_literal(C, maxnum, _, (A, _, B)).

partial_le(C, A, B) :-
    var_type(C, A, integer),
    var_type(C, B, integer),
    body_literal(C, maxnum, _, (_, A, B)).

partial_le(C, A, B) :-
    var_type(C, A, integer),
    var_type(C, B, integer),
    body_literal(C, minnum, _, (B, _, A)).

partial_le(C, A, B) :-
    var_type(C, A, integer),
    var_type(C, B, integer),
    body_literal(C, minnum, _, (_, B, A)).

partial_le(C, A, B) :-
    var_type(C, A, set),
    var_type(C, B, set),
    body_literal(C, empty, _, (A,)).

partial_le(C, A, B) :-
    var_type(C, A, set),
    var_type(C, B, set),
    body_literal(C, ord_union, _, (A,_, C)).

partial_le(C, A, B) :-
    var_type(C, A, set),
    var_type(C, B, set),
    body_literal(C, ord_union, _, (_, A, C)).

partial_le(C, A, B) :-
    var_type(C, A, set),
    var_type(C, B, set),
    body_literal(C, insert, _, (A,_, C)).

partial_le(C, A, B) :-
    partial_le(C, A, B1),
    partial_le(C, B1, B).


:-
    partial_head(Head),
    body_literal(_, Head, _, (A, B)),
    partial_le(A, B).

:-
    partial_head(Head),
    body_literal(_, Head, _, (A, B)),
    partial_le(B, A).

:-
    partial_head(Head),
    body_literal(_, Head, _, (A, B, _)),
    partial_le(A, B).

:-
    partial_head(Head),
    body_literal(_, Head, _, (A, B, _)),
    partial_le(B, A).

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

% injective head
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