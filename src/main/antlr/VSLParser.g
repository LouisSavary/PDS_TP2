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
    : statements[null] EOF { $out = new TP2.ASD.Program($statement.out); } // TODO : change when you extend the language
    | e=expression EOF { $out = new TP2.ASD.Program($e.out); }
TODO    | PROTO
TODO    | FUNC
    ;
    
	
statement [TP2.SymbolTable st_parent] return [TP2.ASD.statements.Statement out, TP2.SymbolTable st_out]
    : WHILE expression[st_parent] DO (statement[st_parent] ) DONE {$out = new TP2.ASD.statements.While($expression.out, $statement.out, $st_parent); $st_out = $st_parent; }
    | IF expression[st_parent] THEN then_stat=statement[st_parent] {TP2.ASD.statement.Statement else_stat = null;} ( ELSE s=statement[st_parent] {else_stat = $s.out;} )? FI {$out = new TP2.ASD.statements.If($expression.out, $then_stat, else_stat); $st_out = $st_parent; }
    | LB {List<TP2.ASD.statements.Statements> stat_list = new LinkedList<>(); } 
    	s1=statement[st_parent] {$st_out = $s1.st_return; stat_list.add($s1.out);} 
    	(s2=statement[st_out] {$st_out = $s2.st_return; stat_list.add($s2.out);})* 
		RB //bloc
    | instruction[st_parent] {$st_out = $instruction.st_return; $out = new TP2.ASD.statements.InstrStatement($instruction.out);}
	;
	
instruction [TP2.ASD.SymbolTable st_parent] returns [TP2.ASD.instructions.Instruction out, TP2.ASD.SymbolTable st_return]
/*TODO les tablos*/	: TYPE i1=IDENT { List<String> var_declared_names = new ArrayList<>(); var_declared_names.add($i1.text); } (COMA i2=IDENT { var_declared_names.add($i2.text); })* {$out = new TP2.ASD.instructions.DeclarationInstr($TYPE.text, var_declared_names); $st_return = $out.getSymbolTable();}
DONE    | IDENT ASSIGN expression[st_parent] { $out = new TP2.ASD.instructions.AssignInstr( $IDENT.text, $expression.out, SymbolTable st_parent); } // element_de_tableau ou variable
//TODO    | PRINT ( expression[st_parent] | TEXT ) (COMA ( expression[st_parent] | TEXT ) )*
//TODO    | READ IDENT (COMA IDENT)*
//TODO    | RETURN expression[st_parent]
	;

expression [TP2.ASD.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : l=factor[st_parent] PLUS  r=expression[st_parent]  { $out = new TP2.ASD.expressions.AddExpression($l.out, $r.out); }
    | l=factor[st_parent] MINUS r=expression[st_parent]  { $out = new TP2.ASD.expressions.SubExpression($l.out, $r.out); }
    | f=factor[st_parent] { $out = $f.out; }
    // TODO : that's all?
    ;

factor [TP2.ASD.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : p=primary[st_parent] { $out = $p.out; }
    | l=primary[st_parent] MODUL r=factor[st_parent]  { $out = new TP2.ASD.expressions.ModExpression($l.out, $r.out); }
    | l=primary[st_parent] TIMES r=factor[st_parent]  { $out = new TP2.ASD.expressions.MulExpression($l.out, $r.out); }
    | l=primary[st_parent] DIVID r=factor[st_parent]  { $out = new TP2.ASD.expressions.DivExpression($l.out, $r.out); }
    // TODO : that's all?
    ;

primary [TP2.ASD.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : INTEGER 	{ $out = new TP2.ASD.expressions.IntegerExpression($INTEGER.int); }
    //TODO IdentExpression
    | INDENT {List<TP2.ASD.expressions.Expression> list_args = null;} (LP {list_args = new LinkedList<TP2.ASD.expressions.Expression>();} ( e=expression[st_parent] {list_args.add($e.out);} )* RP)?	{ $out = new TP2.ASD.expressions.IdentExpression($INDENT.text, $st_parent, list_args } // plus arguments si fonction (aller chercher dans la table des symboles)
    | LP e=expression[st_parent] RP { $out = $e.out; }
    // TODO : that's all?
    ;
