lexer grammar VSLLexer;

options {
  language = Java;
}

@header {
  package TP2;
}

WS : (' '|'\n'|'\t') -> skip
   ;

COMMENT : '//' (~'\n')* -> skip
        ;

fragment LETTER : 'a'..'z' ;
fragment DIGIT  : '0'..'9' ;
fragment ASCII  : ~('\n'|'"');

// keywords
LP    : '(' ; // Left parenthesis
RP    : ')' ;
COMMA	: ','	;
LB		: '{'	;
RB		: '}' 	;
LC		: '['	;
RC		: ']' 	;
PLUS  	: '+'	;
MINUS	: '-'	;
TIMES	: '*'	;
DIVID	: '/'	;
MODUL	: '%'	;
EQ		: '=='	;
INF		: '<'	;
INFEQ	: '<='	;
SUP		: '>'	;
SUPEQ	: '>='	;
OR		: '||'	;
AND		: '&&'	;
NO		: '!'	;


FUNC	: 'FUNC'	;
PROTO	: 'PROTO'	;

//types
TYPE 	: 'INT'
		| 'VOID'
		| 'BOOL';

//other keywords
ASSIGN	: ':='		;
WHILE	: 'WHILE' 	;
DO		: 'DO' 		;
DONE 	: 'DONE' 	;
IF		: 'IF' 		;
THEN	: 'THEN' 	;
ELSE 	: 'ELSE' 	;
FI		: 'FI' 		;
RETURN	: 'RETURN'	;
PRINT	: 'PRINT'	;
READ	: 'READ'	;
// other tokens (no conflict with keywords in VSL)
IDENT   : LETTER (LETTER|DIGIT)*;
TEXT    : '"' (ASCII)* '"' { setText(getText().substring(1, getText().length() - 1)); };
INTEGER : (DIGIT)+ ;
