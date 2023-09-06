brlseg(J,I,K,S) :- empty(S), same_ptr(I,K), nullptr(J).
brlseg(J,I,K,S) :- value(J, V), lseg(I, J, S1), next(J, K), insert(S1, V, S).