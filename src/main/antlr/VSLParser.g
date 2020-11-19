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
    : statement[new TP2.SymbolTable()] EOF { $out = new TP2.ASD.Program($statement.out); } // TODO : change when you extend the language
    | e=expression[null] EOF { $out = new TP2.ASD.Program($e.out); }
    | PROTO TYPE IDENT LP (TYPE IDENT)* RP
    | FUNC TYPE IDENT LP (TYPE IDENT)* RP
    ;
    
	
statement [TP2.SymbolTable st_parent] returns [TP2.ASD.statements.Statement out, TP2.SymbolTable st_out]
    : {System.err.println("WHILE " + ($st_parent == null?"null":""));}WHILE expression[st_parent] DO (statement[st_parent] ) DONE {$out = new TP2.ASD.statements.While($expression.out, $statement.out, $st_parent); $st_out = $st_parent; }
    | {System.err.println("IF " + ($st_parent == null?"null":""));}IF expression[st_parent] THEN tstat=statement[st_parent] 
    	{TP2.ASD.statements.Statement else_stat = null, then_stat = $tstat.out;} 
    	( ELSE es=statement[st_parent] {else_stat = $es.out;} )? FI 
    	{ $out = new TP2.ASD.statements.If($expression.out, then_stat, else_stat, $st_parent); $st_out = $st_parent; }
    | {System.err.println("BLOC " + ($st_parent == null?"null":""));}LB {List<TP2.ASD.statements.Statement> stat_list = new LinkedList<>(); TP2.SymbolTable st_transit = new TP2.SymbolTable($st_parent); } 
    	s1=statement[st_transit] {st_transit = $s1.st_out; stat_list.add($s1.out);} 
    	(s2=statement[st_transit] {st_transit = $s2.st_out; stat_list.add($s2.out);})* 
		RB { $out = new TP2.ASD.statements.Block(stat_list); $st_out = $st_parent; }
    | {System.err.println("INSTR " + ($st_parent == null?"null":""));}i=instruction[st_parent] {$st_out = $i.st_return; $out = new TP2.ASD.statements.InstrStatement($i.out); }
	;
	
instruction [TP2.SymbolTable st_parent] returns [TP2.ASD.instructions.Instruction out, TP2.SymbolTable st_return]
	: t=TYPE i1=IDENT { List<String> var_declared_names = new ArrayList<>(); var_declared_names.add($i1.text); } 
		(COMMA i2=IDENT { var_declared_names.add($i2.text); })* 
		{ TP2.ASD.instructions.DeclarationInstr dec = new TP2.ASD.instructions.DeclarationInstr($t.text, var_declared_names, $st_parent); $out = dec; $st_return = dec.getSymbolTable();}
    | i=IDENT ASSIGN expression[st_parent] { $out = new TP2.ASD.instructions.AssignInstr( $i.text, $expression.out, $st_parent); $st_return = $st_parent;} 
//TODO    | PRINT ( expression[st_parent] | TEXT ) (COMMA ( expression[st_parent] | TEXT ) )*
//TODO    | READ IDENT (COMMA IDENT)*
    | RETURN expression[st_parent] {$out = new TP2.ASD.instructions.RetourInstr($expression.out); $st_return = $st_parent; }
	;

expression [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : l=comparison[st_parent] OR  r=expression[st_parent]  { $out = new TP2.ASD.expressions.OrExpression($l.out, $r.out); }
    | l=comparison[st_parent] AND r=expression[st_parent]  { $out = new TP2.ASD.expressions.AndExpression($l.out, $r.out); }
    | NO e=expression[st_parent] { $out = new TP2.ASD.expressions.NoExpression($e.out); }
    | c=comparison[st_parent] { $out = $c.out; }
    // TODO : that's all?
    ;

comparison [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : l=addition[st_parent] EQ  	r=comparison[st_parent]  { $out = new TP2.ASD.expressions.EqExpression($l.out, $r.out); }
    | l=addition[st_parent] INF  	r=comparison[st_parent]  { $out = new TP2.ASD.expressions.InfExpression($l.out, $r.out); }
	| l=addition[st_parent] SUP  	r=comparison[st_parent]  { $out = new TP2.ASD.expressions.SupExpression($l.out, $r.out); }
    | l=addition[st_parent] INFEQ 	r=comparison[st_parent]  { $out = new TP2.ASD.expressions.InfEqExpression($l.out, $r.out); }
    | l=addition[st_parent] SUPEQ 	r=comparison[st_parent]  { $out = new TP2.ASD.expressions.SupEqExpression($l.out, $r.out); }
    | f=addition[st_parent] { $out = $f.out; }
    // TODO : that's all?
    ;

addition [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : l=factor[st_parent] PLUS  r=addition[st_parent]  { $out = new TP2.ASD.expressions.AddExpression($l.out, $r.out); }
    | l=factor[st_parent] MINUS r=addition[st_parent]  { $out = new TP2.ASD.expressions.SubExpression($l.out, $r.out); }
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
    : in=INTEGER { $out = new TP2.ASD.expressions.IntegerExpression($in.int); }
    | LP e=expression[st_parent] { $out = $e.out; } RP
    | i=IDENT { List<TP2.ASD.expressions.Expression> list_args = null; } 
    	( LP ( e1=expression[st_parent] { list_args = new LinkedList<TP2.ASD.expressions.Expression>(); list_args.add($e1.out); } 
    	( COMMA e2=expression[st_parent] { list_args.add($e2.out); } )* )? RP)?	
    	{ $out = new TP2.ASD.expressions.IdentExpression($i.text, $st_parent, list_args); } 
    // TODO : that's all?
    ;
