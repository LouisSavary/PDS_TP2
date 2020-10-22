parser grammar VSLParser;

options {
  language = Java;
  tokenVocab = VSLLexer;
}

@header {
  package TP2;

  import java.util.stream.Collectors;
  import java.util.Arrays;
  import java.util.LinkedList;
  import java.util.List;
}


// TODO : other rules

program returns [TP2.ASD.Program out]
    : statements EOF { $out = new TP2.ASD.Program($statement.out); } // TODO : change when you extend the language
    | e=expression EOF { $out = new TP2.ASD.Program($e.out); }
    ;
    
	
statement [TP2.ASD.SymbolTable st_parent] return [List<TP2.ASD.Instruction> out, TP2.ASD.SymbolTable st_return]
	: WHILE expression DO (statement[st_parent] ) DONE
    | IF expression THEN statement ( ELSE statement[st_parent] )? FI
    | LB {$out = new LinkedList<TP2.ASD.Instruction>();} s1=statement[st_parent] { $st_return = $s1.st_return; $out.add($s1.out);} (s2=statement[$st_return] {$st_return = $s2.st_return; $out.add($s2.out);})* RB //bloc
    | instruction[$st_parent] {
	;
	
instruction [TP2.ASD.SymbolTable st_parent] returns [TP2.ASD.Instruction out, TP2.ASD.SymbolTable st_return]
	: TYPE i1=IDENT { List<String> var_declared_names = new ArrayList<>(); var_declared_names.add($i1.text); } (COMA i2=IDENT { var_declared_names.add($i2.text); })* {$out = new TP2.ASD.DeclarationInstr($TYPE.text, var_declared_names);}
    | IDENT ASSIGN expression { $out = new TP2.ASD.AssignInstr( $IDENT.text, $expression.out); } // element_de_tableau ou variable
    | PRINT ( expression | TEXT ) (COMA ( expression | TEXT ) )*
    | READ IDENT (COMA IDENT)*
    | RETURN expression
	;

expression returns [TP2.ASD.Expression out]
    : l=factor PLUS  r=expression  { $out = new TP2.ASD.AddExpression($l.out, $r.out); }
    | l=factor MINUS r=expression  { $out = new TP2.ASD.SubExpression($l.out, $r.out); }
    | f=factor { $out = $f.out; }
    // TODO : that's all?
    ;

factor returns [TP2.ASD.Expression out]
    : p=primary { $out = $p.out; }
    | l=primary MODUL r=factor  { $out = new TP2.ASD.ModExpression($l.out, $r.out); }
    | l=primary TIMES r=factor  { $out = new TP2.ASD.MulExpression($l.out, $r.out); }
    | l=primary DIVID r=factor  { $out = new TP2.ASD.DivExpression($l.out, $r.out); }
    // TODO : that's all?
    ;

primary returns [TP2.ASD.Expression out]
    : INTEGER 	{ $out = new TP2.ASD.IntegerExpression($INTEGER.int); }
 //   | INDENT 	{ $out = new TP2.ASD. ??? } //plus arguments si fonction
    | LP e=expression RP { $out = $e.out; }
    // TODO : that's all?
    ;
