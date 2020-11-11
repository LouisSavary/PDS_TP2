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
    : statement[null] EOF { $out = new TP2.ASD.Program($statement.out); } // TODO : change when you extend the language
    | e=expression[null] EOF { $out = new TP2.ASD.Program($e.out); }
//TODO    | PROTO
//TODO    | FUNC
    ;
    
	
statement [TP2.SymbolTable st_parent] returns [TP2.ASD.statements.Statement out, TP2.SymbolTable st_out]
    : WHILE expression[st_parent] DO (statement[st_parent] ) DONE {$out = new TP2.ASD.statements.While($expression.out, $statement.out, $st_parent); $st_out = $st_parent; }
    | IF expression[st_parent] THEN tstat=statement[st_parent] 
    	{TP2.ASD.statements.Statement else_stat = null, then_stat = $tstat.out;} 
    	( ELSE es=statement[st_parent] {else_stat = $es.out;} )? FI 
    	{ $out = new TP2.ASD.statements.If($expression.out, then_stat, else_stat, $st_parent); $st_out = $st_parent; }
    | LB {List<TP2.ASD.statements.Statement> stat_list = new LinkedList<>(); TP2.SymbolTable st_transit = $st_parent; } 
    	s1=statement[st_transit] {st_transit = $s1.st_out; stat_list.add($s1.out);} 
    	(s2=statement[st_transit] {st_transit = $s2.st_out; stat_list.add($s2.out);})* 
		RB { $out = new TP2.ASD.statements.Block(stat_list);  }
    | i=instruction[st_parent] {$st_out = $i.st_return; $out = new TP2.ASD.statements.InstrStatement($i.out);}
	;
	
instruction [TP2.SymbolTable st_parent] returns [TP2.ASD.instructions.Instruction out, TP2.SymbolTable st_return]
	: TYPE i1=IDENT { List<String> var_declared_names = new ArrayList<>(); var_declared_names.add($i1.text); } 
		(COMMA i2=IDENT { var_declared_names.add($i2.text); })* 
		{ TP2.ASD.instructions.DeclarationInstr dec = new TP2.ASD.instructions.DeclarationInstr($TYPE.text, var_declared_names, $st_parent); $out = dec; $st_return = dec.getSymbolTable();}
    | IDENT ASSIGN expression[st_parent] { $out = new TP2.ASD.instructions.AssignInstr( $IDENT.text, $expression.out, $st_parent); } 
//TODO    | PRINT ( expression[st_parent] | TEXT ) (COMMA ( expression[st_parent] | TEXT ) )*
//TODO    | READ IDENT (COMMA IDENT)*
//TODO    | RETURN expression[st_parent]
	;

expression [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : l=factor[st_parent] PLUS  r=expression[st_parent]  { $out = new TP2.ASD.expressions.AddExpression($l.out, $r.out); }
    | l=factor[st_parent] MINUS r=expression[st_parent]  { $out = new TP2.ASD.expressions.SubExpression($l.out, $r.out); }
    | f=factor[st_parent] { $out = $f.out; }
    // TODO : that's all?
    ;

factor [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : p=primary[st_parent] { $out = $p.out; }
    | l=primary[st_parent] MODUL r=factor[st_parent]  { $out = new TP2.ASD.expressions.ModExpression($l.out, $r.out); }
    | l=primary[st_parent] TIMES r=factor[st_parent]  { $out = new TP2.ASD.expressions.MulExpression($l.out, $r.out); }
    | l=primary[st_parent] DIVID r=factor[st_parent]  { $out = new TP2.ASD.expressions.DivExpression($l.out, $r.out); }
    // TODO : that's all?
    ;

primary [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : INTEGER { $out = new TP2.ASD.expressions.IntegerExpression($INTEGER.int); }
    | LP e=expression[st_parent] { $out = $e.out; } RP
    | IDENT { List<TP2.ASD.expressions.Expression> list_args = null; } 
    	( LP ( e1=expression[st_parent] { list_args = new LinkedList<TP2.ASD.expressions.Expression>(); list_args.add($e1.out); } 
    	( COMMA e2=expression[st_parent] { list_args.add($e2.out); } )* )? RP)?	
    	{ $out = new TP2.ASD.expressions.IdentExpression($IDENT.text, $st_parent, list_args); } 
    // TODO : that's all?
    ;
