%P  ::= K.
program(p(BLOCK)) --> k(BLOCK), [.].

%K  ::= begin D; C end
k(block(START,DEC,ENDST,CONDN,ENDPROG)) --> begin(START), d(DEC), endstmt(ENDST), c(CONDN), end(ENDPROG).
begin(start(begin)) --> [begin].
end(fin(end)) --> [end].
endstmt(stmtend(;)) --> [;].

%D  ::= const I = N D' | var I D'
d(declaration(KEY_WORD,ID,EQ,NUM,DDASH)) --> keyword(KEY_WORD), i(ID), equal(EQ), n(NUM), dprime(DDASH) | keyword(KEY_WORD), i(ID), dprime(DDASH).
keyword(kword(not)) --> [not].
keyword(kword(const)) --> [const].
keyword(kword(var)) --> [var].


equal(psign(=)) --> [=].
equal(psign(:=)) --> [:=].

%D' ::= ε | ; D D'
dprime(ddeclaration(EP,ENDST,DEC,DDASH)) --> empty(EP) | endstmt(ENDST), d(DEC), dprime(DDASH).

empty(pempty(_)) --> [].

%C  ::= I := E C' | if B then C else C endif C' | while B do C endwhile C' | K C'
c(condition(ID,EQ,AEXPRN,CDASH,BOOLEAN,CONDN_1,CONDN_2,BLOCK,IF,THEN,ELSE,ENDIF,WHILE,DO,ENDWHILE)) --> i(ID), equal(EQ), e(AEXPRN), cprime(CDASH) | ifcondn(IF), b(BOOLEAN), thenstmt(THEN), c(CONDN_1), elsestmt(ELSE), c(CONDN_2), endiftoken(ENDIF), cprime(CDASH) | whileloop(WHILE), b(BOOLEAN), dotoken(DO), c(CONDN_1), endwhiletoken(ENDWHILE), cprime(CDASH) | k(BLOCK), cprime(CDASH).

ifcondn(iftoken(if)) --> [if].
thenstmt(thentoken(then)) --> [then].
elsestmt(elsetoken(else)) --> [else].
endiftoken(ifends(endif)) --> [endif].

whileloop(whiletoken(while)) --> [while].
dotoken(dostmt(do)) --> [do].
endwhiletoken(whileends(endwhile)) --> [endwhile].

%C' ::= ε | ; C C'
cprime(ccondition(EP,ENDST,CONDN,CDASH)) --> empty(EP) | endstmt(ENDST), c(CONDN), cprime(CDASH).

%B  ::= true | false | E = E | not B
b(bexp(BOOLEAN,AEXPRN,EXPR_N,EQ,KEY_WORD)) --> bool(BOOLEAN) | e(AEXPRN), equal(EQ), e(EXPR_N) | keyword(KEY_WORD), b(BOOLEAN).
bool(boolean(true)) --> [true].
bool(boolean(false)) --> [false].

%E  ::= I E' | N E'
e(arithexpression(ID,EDASH,NUM)) --> i(ID), eprime(EDASH) | n(NUM), eprime(EDASH).

%E' ::= ε | + E E' | - E E' | * E E' | / E E'
eprime(eexpression(EP,OP,AEXPRN,EDASH)) --> empty(EP) | plus(OP), e(AEXPRN), eprime(EDASH) | minus(OP), e(AEXPRN), eprime(EDASH) | multiply(OP), e(AEXPRN), eprime(EDASH) | division(OP), e(AEXPRN), eprime(EDASH).

plus(poperator(+)) --> [+].
minus(poperator(-)) --> [-].
multiply(poperator(*)) --> [*].
division(poperator(/)) --> [/].

%I  ::= x | y | z | u | v
i(var(ID)) --> variable(ID).
variable(var(x)) --> [x].
variable(var(y)) --> [y].
variable(var(z)) --> [z].
variable(var(u)) --> [u].
variable(var(v)) --> [v].

%N  ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
n(numbr(NUM)) --> number(NUM).
number(num(0)) --> [0].
number(num(1)) --> [1].
number(num(2)) --> [2].
number(num(3)) --> [3].
number(num(4)) --> [4].
number(num(5)) --> [5].
number(num(6)) --> [6].
number(num(7)) --> [7].
number(num(8)) --> [8].
number(num(9)) --> [9].