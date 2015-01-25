%For diving the list
divide([],[],[]).
divide([X],[X],[]).
divide([X,Y|T],[X|M],[Y|N]) :-  divide(T,M,N).
%For merging lists
merge_lists(X,[],X).
merge_lists([],Y,Y).
merge_lists([X|A],[Y|B],[X|C]) :-  X =< Y, merge_lists(A,[Y|B],C).
merge_lists([X|A],[Y|B],[Y|C]) :-  X > Y,  merge_lists([X|A],B,C).

mergesort([],[]).
mergesort([A],[A]).
mergesort([A,B|R],S) :- divide([A,B|R],L1,L2), mergesort(L1,S1), mergesort(L2,S2), merge_lists(S1,S2,S).