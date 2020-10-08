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
PLUS  	: '+'	;
MINUS	: '-'	;
TIMES	: '*'	;
DIVID	: '/'	;
MODUL	: '%'	;


// TODO : other keywords
WHILE	: 'WHILE' 	;
DO		: 'DO' 		;
DONE 	: 'DONE' 	;
IF		: 'IF' 		;
THEN	: 'THEN' 	;
ELSE 	: 'ELSE' 	;
FI		: 'FI' 		;
RETURN	: 'RETURN'	;
// other tokens (no conflict with keywords in VSL)
IDENT   : LETTER (LETTER|DIGIT)*;
TEXT    : '"' (ASCII)* '"' { setText(getText().substring(1, getText().length() - 1)); };
INTEGER : (DIGIT)+ ;
