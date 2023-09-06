% Learnable when given the full recursive trace

xlseg(I,I1,J,J1,S) :- empty(S),same_ptr(I, J), same_ptr(I1, J1).
xlseg(I,I1,K,K1,S) :- value(I,A), xlseg(J,I,K,K1,S1), xor(I1, J, X), next(I, X), insert(S1, V, S). 