%Draw Isosceles triangle
draw_isoc(0).
draw_isoc(1):- space(1),write('/'),draw_isoc(0),write('\\'), nl.
draw_isoc(N):- A is N-1,triangle(A,2), B is 2*(N-1),base(B).

%For creating the sides of the triangle
triangle(0,_).
triangle(1,X):- Y is X+1,space(Y),write('/'),write('\\'),nl.
triangle(N,X):- Y is N-1,Z is X+1, triangle(Y,Z), space(Z),write('/'), A is 2*(N-1), space(A),write('\\'),nl.

%For creating the base of the triangle
base(0).
base(1):- space(3),write('-').
base(N):-X is N-1,base(X),write('-').

%For putting required spaces in between
space(0):- write('').
space(1):- write(' ').
space(N):-write(' '),X is N-1,space(X).