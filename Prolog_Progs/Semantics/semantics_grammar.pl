%=======GRAMMAR=======
program(p(BLOCK)) --> k(BLOCK), [.].

k(block(DEC,CONDN)) --> [begin], dprime(DEC), [;], cprime(CONDN), [end].

dprime(DEC) --> d(DEC).
dprime(ddeclaration(DEC, DDASH)) --> d(DEC), [;], dprime(DDASH).
d(ddeclconst(ID,NUM)) --> [const], i(ID), [=], n(NUM).
d(ddeclvar(ID)) --> [var], i(ID).

cprime(C) --> c(C).
cprime(ccondition(CONDN_1, CONDN_2)) --> c(CONDN_1), [;], cprime(CONDN_2). 
c(cassgn(ID, EXPRN)) --> i(ID), [:=], eprime(EXPRN).
c(cifcondn(BOOLEAN,CONDN_1, CONDN_2)) --> [if], b(BOOLEAN), [then], cprime(CONDN_1), [else], cprime(CONDN_2), [endif].
c(cwhile(BOOLEAN, CONDN)) --> [while], b(BOOLEAN), [do], cprime(CONDN), [endwhile].

b(bequal(EXPRN_1, EXPRN_2)) --> eprime(EXPRN_1), [=], eprime(EXPRN_2).
b(bnot(BOOLEAN)) --> [not], b(BOOLEAN).
b(bb(BOOLEAN)) --> ['('] ,b(BOOLEAN), [')'].
b(btrue(true)) --> [true].
b(bfalse(false)) --> [false].

e(eid(ID)) --> i(ID).
e(enum(NUM)) --> n(NUM).
e(ee(EXPRN)) -->['('], eprime(EXPRN), [')'].
eprime(EXPRN) --> e(EXPRN).
eprime(eassign(ID, EXPRN)) --> i(ID), [:=], eprime(EXPRN).
eprime(eplus(EXPRN_1,EXPRN_2)) --> e(EXPRN_1), [+], eprime(EXPRN_2).
eprime(eminus(EXPRN_1,EXPRN_2)) --> e(EXPRN_1), [-], eprime(EXPRN_2).
eprime(emul(EXPRN_1,EXPRN_2)) --> e(EXPRN_1), [*], eprime(EXPRN_2).
eprime(ediv(EXPRN_1,EXPRN_2)) --> e(EXPRN_1), [/], eprime(EXPRN_2).

i(x) --> [x].
i(y) --> [y].
i(z) --> [z].
i(u) --> [u].
i(v) --> [v].
i(w) --> [w].

n(0) --> [0].
n(1) --> [1].
n(2) --> [2].
n(3) --> [3].
n(4) --> [4].
n(5) --> [5].
n(6) --> [6].
n(7) --> [7].
n(8) --> [8].
n(9) --> [9].



%=======SEMANTICS=======

initialize_store([]).

update(ID,NewValue,[],[(ID,NewValue)]).
update(ID,NewValue,[(ID,_)|T],[(ID,NewValue)|T]).
update(ID,NewValue,[H|T],[H|S]) :- update(ID,NewValue,T,S).

access(_,[],0).
access(ID,[(ID,Value)|_],Value).
access(ID,[_|T],Value) :- access(ID,T,Value).

program_eval(p(BLOCK),X,Y,D):- initialize_store(S1), update(x, X, S1, S2),	update(y, Y, S2, S3), keval(BLOCK, S3, S4), access(z, S4, D).
							
keval(block(DEC,CONDN),S,Sout):- deval(DEC,S,S1), ceval(CONDN,S1,Sout).

deval(ddeclaration(DEC, DDASH),S,Sout):- deval(DEC,S,S1), deval(DDASH,S1,Sout).
deval(ddeclconst(ID,NUM),S,Sout):- 	update(ID,NUM,S,Sout).
deval(ddeclvar(_),S,S).

ceval(ccondition(CONDN_1, CONDN_2),S,Sout):- ceval(CONDN_1,S,S1), ceval(CONDN_2,S1,Sout).
ceval(cassgn(ID, EXPRN),S,Sout):- eeval(EXPRN,S,S1,Value), update(ID,Value,S1,Sout).
ceval(cifcondn(BOOLEAN,CONDN_1, CONDN_2),S,Sout):- beval(BOOLEAN,S,S1,RV),(RV -> ceval(CONDN_1,S1,Sout) ; ceval(CONDN_2,S1,Sout)).
ceval(cwhile(BOOLEAN, CONDN),S,Sout):- beval(BOOLEAN,S,S1,RV),(RV -> ceval(CONDN,S1,S2),ceval(cwhile(BOOLEAN,CONDN),S2,Sout) ; Sout=S1).
	
beval(bequal(EXPRN_1, EXPRN_2),S,Sout,TV):-	eeval(EXPRN_1,S,S1,Value1),	eeval(EXPRN_2,S1,Sout,Value2),(Value1=Value2 -> TV = true ; TV = false).
beval(bnot(BOOLEAN),S,Sout,TV):- beval(BOOLEAN,S,Sout,TV1),(TV1 -> TV = false ; TV = true).
beval(bb(BOOLEAN),S,Sout,TV):-	beval(BOOLEAN,S,Sout,TV).
beval(btrue(true),_,_,true).
beval(bfalse(false),_,_,false).

eeval(eid(ID),S,S,Value):- access(ID,S,Value).					
eeval(enum(NUM),S,S,NUM).
eeval(ee(EXPRN),S,Sout,Value):- eeval(EXPRN,S,Sout,Value).
eeval(eassign(ID, EXPRN),S,Sout,Value):- eeval(EXPRN,S,S1,Value), update(ID,Value,S1,Sout).
eeval(eplus(EXPRN_1,EXPRN_2),S,Sout,Value):- eeval(EXPRN_1,S,S1,Value1), eeval(EXPRN_2,S1,Sout,Value2), Value is Value1 + Value2.
eeval(eminus(EXPRN_1,EXPRN_2),S,Sout,Value):- eeval(EXPRN_1,S,S1,Value1), eeval(EXPRN_2,S1,Sout,Value2), Value is Value1 - Value2.
eeval(emul(EXPRN_1,EXPRN_2),S,Sout,Value):- eeval(EXPRN_1,S,S1,Value1), eeval(EXPRN_2,S1,Sout,Value2), Value is Value1 * Value2.
eeval(ediv(EXPRN_1,EXPRN_2),S,Sout,Value):- eeval(EXPRN_1,S,S1,Value1), eeval(EXPRN_2,S1,Sout,Value2), Value is Value1 / Value2.


%=======TEST CASES=======
test1(ValX, ValY, A) :- program(P,[begin, var, z, ; , var, x, ;, z, :=, x, end, .],[]),program_eval(P,ValX,ValY,A).
test2(ValX, ValY, A) :- program(P,[begin, var, x, ;, var, y, ;, var, z, ;, z, :=, x, +, y, end, .],[]),program_eval(P,ValX,ValY,A).
test3(ValX, ValY, A) :- program(P,[begin, var, x,;, var, y,;, var, z,;, z, :=, '(', z, :=, x, +, 2, ')', +, y, end, .],[]),program_eval(P,ValX,ValY,A).
test4(ValX, ValY, A) :- program(P,[begin, var, x,;, var, y,;, var, z,;,if, x,=,y ,then, z,:=,1 ,else ,z,:=,0 ,endif, end,.],[]),program_eval(P,ValX,ValY,A).
test5(ValX, ValY, A) :- program(P,[begin, var, x,;, var, y,;, var, z,;, if, x ,= ,0 ,then ,z,:=,x ,else ,z,:=,y ,endif ,end,.],[]),program_eval(P,ValX,ValY,A).
test6(ValX, ValY, A) :- program(P,[begin, var, x, ;, var, y, ;, var, z, ;, if, not, '(', x, =, y, ')', then, z, :=, x, else, z, :=, y, endif, end, .],[]),program_eval(P,ValX,ValY,A).
test7(ValX, ValY, A) :- program(P,[begin, var ,x,;, var, z,;, z,:=,0,;, while, not, x,=,0, do, z, :=, z,+,1,;, x,:=,x,-,1, endwhile, end,.],[]),program_eval(P,ValX,ValY,A).
test8(ValX, ValY, A) :- program(P,[begin, var, x,;, var, y,;, var ,z,;, z,:=,1,;, w,:=,x,;, while ,not ,w, =, 0 ,do, z, :=,z,*,y,;, w,:=,w,-,1, endwhile, end,.],[]),program_eval(P,ValX,ValY,A).