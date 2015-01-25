%1
%RULES for Family tree
mother(lisa, abe).
mother(lisa, sarah).
mother(nancy, john).
mother(sarah, susan).
mother(susan, jack).

father(tony, abe).
father(tony, sarah).
father(abe, john).
father(bill, susan).
father(john, jill).

parent(X,Y) :- mother(X,Y).
parent(X,Y) :- father(X,Y).

ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(X,Z), ancestor(Z,Y).

%Sibling predicate
sibling(X,Y) :- parent(P,X),  parent(P,Y), not(X=Y).

%Same generation predicate
same_generation(X,Y) :- parent(A,X), parent(A,Y).
same_generation(X,Y) :- parent(A,X), parent(B,Y), sibling(A,B).
same_generation(X,Y) :- parent(A,X),parent(B,Y),same_generation(A,B),not(X==Y).