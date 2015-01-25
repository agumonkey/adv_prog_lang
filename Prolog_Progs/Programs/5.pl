%Member predicate
member(X, [X|_]).
member(X, [_|T]) :- member(X,T).

%Delete predicate
delete(_,[],[]).
delete(X,[X|T],T).
delete(X,Y,Y):-not(member(X,Y)).
delete(X,[Y|T],[Y|R]):- not(X==Y),delete(X,T,R).

%Union predicate
union([H|T],[],[H|T]).
union([],[H|T],[H|T]).
union([H|T],X,Y):-member(H,X), union(T,X,Y).
union([H|T],X,[H|Y]):-not(member(H,X)),union(T,X,Y).

%Intersection predicate
intersection([_|_],[],[]).
intersection([],[_|_],[]).
intersection([H|T],X,Y):-not(member(H,X)),intersection(T,X,Y).
intersection([H|T],X,[H|Y]):-member(H,X),intersection(T,X,Y).

%Set difference predicate
setdiff([H|T],[],[H|T]).
setdiff([],[H|T],[H|T]).
setdiff([H|T],[H|X],Y):-setdiff(T,X,Y).
setdiff([H|T],X,[H|Y]):-not(member(H,X)),setdiff(T,X,Y).
setdiff([H|T],X,Y):-member(H,X),setdiff(T,A,Y),delete(H,X,A).

%Subset predicate
subset([],[]).
subset(S,S).
subset([],_).
subset(T,[_|T]).
subset([H],[H|_]).
subset([X|Y],S) :- member(X,S), subset(Y,S).

%Merge predicate
merge(_,[],[]).
merge(P,[H|T],[X|Y]):-union([P],H,X),merge(P,T,Y).

%Powerset predicate
powerset([],[[]]).
powerset([H|T],X):-powerset(T,B),merge(H,B,Y),union(B,Y,X).