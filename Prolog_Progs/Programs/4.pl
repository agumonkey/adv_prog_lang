hanoi(1,X,Y,_,[(X,Y)]).
%Using built-in append function for appending to output
hanoi(X,A,B,C,Y):-P is X-1,hanoi(P,A,C,B,Q),hanoi(1,A,B,_,[R]),hanoi(P,C,B,A,S),append(Q,[R|S],Y).