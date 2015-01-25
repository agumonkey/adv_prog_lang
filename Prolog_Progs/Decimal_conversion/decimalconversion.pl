%Right recursive grammar
% B::= DB|D
% D::= 0|1

%Parse tree for binary digits
digit(dd(0)) --> [0].
digit(dd(1)) --> [1].
binary(bb(X,Y)) --> digit(X), binary(Y).
binary(bd(X)) --> digit(X).

%Semantics(Parse tree evaluation)
dsem(dd(0),0).
dsem(dd(1),1).
bsem(bb(X,Y),Z) :- dsem(X,A),bsem(Y,B),Z is A + 2 * B.
bsem(bd(X),Z) :- dsem(X,Z).

%Reversing binary sequence
reverse([H|T],Y,Z):-  reverse(T,[H|Y],Z).
reverse([],Y,Y).

%Binary to decimal conversion
bintodecimal(X,Z) :- reverse(X,[],Y),binary(A,Y,[]),bsem(A,Z).