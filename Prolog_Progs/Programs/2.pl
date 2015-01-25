%Plus predicates
plus(0,X,X).
plus(s(X),Y,s(R)):-plus(X,Y,R).

%Times predicates
times(0,_,0).
times(s(X),Y,R):-times(X,Y,Z),plus(Z,Y,R).

%Factorial predicate
factorial(0,s(0)).
factorial(s(0),s(0)).
factorial(s(X),Y):-factorial(X,Z),times(s(X),Z,Y).

%Fibonacci predicate
fibonacci(0,0).
fibonacci(s(0),s(0)).
fibonacci(s(s(X)),Y):-fibonacci(s(X),A),fibonacci(X,B),plus(A,B,Y).