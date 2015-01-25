%Empty Lists
sumlists([], [], [],[]).
%For varying length of lists
sumlists([H|T],[], [],[H|T]).
sumlists([],[H|T],[],[H|T] ).
sumlists([], [], [H|T], [H|T]).
sumlists([X|Y],[P|Q],[],[A|B] ) :- A is X+P+0 , sumlists(Y, Q,[],B).
sumlists([X|Y],[], [P|Q],[A|B] ) :- A is X+P+0 , sumlists(Y,[],Q,B) .
sumlists([],[X|Y], [P|Q],[A|B] ) :- A is X+P+0 , sumlists([],Y,Q,B) .
%Only one element in each list
sumlists([H1],[H2],[H3],[Z]):- Z is H1+H2+H3.

sumlists([H1|T1],[H2|T2],[H3|T3],[Z|T]):-sumlists(T1,T2,T3,T),Z is H1+H2+H3.