parser grammar VSLParser;

options {
  language = Java;
  tokenVocab = VSLLexer;
}

@header {
  package TP2;

  import java.util.stream.Collectors;
  import java.util.LinkedList;
  import java.util.List;
}

/*Pourquoi ? ce probleme est interessant
 * Comment ? resolution lds problemes poses, decision prises
 * difficultés ? quelles sont elles et comment resolues
 * extension : pourquoi ? comment ?
 */


program returns [TP2.ASD.Program out]
    : e=expression[null] EOF { $out = new TP2.ASD.Program($e.out);}
    | /*global + */  
      { TP2.SymbolTable st = new TP2.SymbolTable(); List<TP2.ASD.statements.Statement> stat_list = new ArrayList<TP2.ASD.statements.Statement>(); }
      ( s=statement[st] {st = $s.st_out; stat_list.add($s.out);})+ EOF
      { $out = new TP2.ASD.Program(stat_list); }
    ;
    
	
statement [TP2.SymbolTable st_parent] returns [TP2.ASD.statements.Statement out, TP2.SymbolTable st_out]
    : PROTO t=TYPE i=IDENT {List<TP2.SymbolTable.VariableSymbol> args = new ArrayList<>(); String type = "INT";} 
    	LP ( (t1=TYPE {type = $t1.text;})? i2=IDENT {args.add(new TP2.SymbolTable.VariableSymbol(TP2.ASD.types.Type.getType(type), $i2.text)); type = "INT";}
		(COMMA (t2=TYPE {type = $t2.text;})? i3=IDENT {args.add(new TP2.SymbolTable.VariableSymbol(TP2.ASD.types.Type.getType(type), $i3.text)); type= "INT";} )* )?
    	RP { $out = new TP2.ASD.statements.Proto($t.text, $i.text, args, $st_parent); $st_out = $out.getSymbolTable(); }
    | FUNC t=TYPE i=IDENT {List<TP2.SymbolTable.VariableSymbol> args = new ArrayList<>(); String type = "INT";} 
    	LP ( (t1=TYPE {type = $t1.text;})? i2=IDENT {args.add(new TP2.SymbolTable.VariableSymbol(TP2.ASD.types.Type.getType(type), $i2.text)); type = "INT";}
		(COMMA (t2=TYPE {type = $t2.text;})? i3=IDENT {args.add(new TP2.SymbolTable.VariableSymbol(TP2.ASD.types.Type.getType(type), $i3.text)); type= "INT";} )* )?
    	RP 
    	{TP2.SymbolTable stFunc = new TP2.SymbolTable($st_parent); for (TP2.SymbolTable.VariableSymbol v : args) stFunc.add(v);  }//ajout des parametre à la table de symbole
    	instr=instruction[stFunc]
    	{ TP2.ASD.statements.Func f = new TP2.ASD.statements.Func($t.text, $i.text, args, stFunc, $instr.out); $out = f; $st_out = f.getSymbolTable();} 
	; 
	
	
instruction [TP2.SymbolTable st_parent] returns [TP2.ASD.instructions.Instruction out, TP2.SymbolTable st_return]
    //While instruction
    : WHILE expression[st_parent] DO (instruction[st_parent] ) DONE {$out = new TP2.ASD.instructions.While($expression.out, $instruction.out, $st_parent); $st_return = $st_parent; }
    //If instruction
    | IF expression[st_parent] THEN tstat=instruction[st_parent] 
    	{TP2.ASD.instructions.Instruction else_stat = null, then_stat = $tstat.out;} 
    	( ELSE es=instruction[st_parent] {else_stat = $es.out;} )? FI 
    	{ $out = new TP2.ASD.instructions.If($expression.out, then_stat, else_stat, $st_parent); $st_return = $st_parent; }
    //bloc of instructions
    | LB {List<TP2.ASD.instructions.Instruction> instr_list = new LinkedList<>(); TP2.SymbolTable st_transit = new TP2.SymbolTable($st_parent); } 
    	s1=instruction[st_transit] {st_transit = $s1.st_return; instr_list.add($s1.out);} 
    	(s2=instruction[st_transit] {st_transit = $s2.st_return; instr_list.add($s2.out);})* 
		RB { $out = new TP2.ASD.instructions.Block(instr_list); $st_return = $st_parent; }
	//declaration instruction
	| t=TYPE i1=IDENT { List<String> var_declared_names = new ArrayList<>(); List<Integer> sizes = new ArrayList<>(); var_declared_names.add($i1.text); } 
		(LC s=INTEGER RC {sizes.add(Integer.parseInt($s.text));} | {sizes.add(new Integer(1));} )
		(COMMA i2=IDENT { var_declared_names.add($i2.text); })* 
		{ TP2.ASD.instructions.DeclarationInstr dec = new TP2.ASD.instructions.DeclarationInstr($t.text, var_declared_names, $st_parent); $out = dec; $st_return = dec.getSymbolTable();}
    //assignment instruction
    | i=IDENT ASSIGN expression[st_parent] { $out = new TP2.ASD.instructions.AssignInstr( $i.text, $expression.out, $st_parent); $st_return = $st_parent;} 
    //call instruction
    | i=IDENT {List<TP2.ASD.expressions.Expression> args = new ArrayList<>();}
	  LP (e=expression[st_parent] { args.add($e.out); } (COMMA e=expression[st_parent] { args.add($e.out); } )*) RP
	  {$out = new TP2.ASD.instructions.Call($i.text, $st_parent, args); $st_return = $st_parent;}
    //Print instruction
    | PRINT {List<Object> l = new ArrayList<>();} ( e=expression[st_parent] {l.add($e.out);} | t=TEXT {l.add($t.text);} ) (COMMA ( e2=expression[st_parent] {l.add($e2.out);} | t2=TEXT {l.add($t2.text);} ) )* 
      {$out = new TP2.ASD.instructions.Print(l); $st_return = $st_parent;}
    //Read instruction
    | READ {List<String> l = new ArrayList<>();} i=IDENT {l.add($i.text);} (COMMA i2=IDENT {l.add($i2.text);})*
      {$out = new TP2.ASD.instructions.Read(l, $st_parent); $st_return = $st_parent;}
    //Return instruction
    | RETURN expression[st_parent] {$out = new TP2.ASD.instructions.RetourInstr($expression.out); $st_return = $st_parent; }
	;


expression [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : l=comparison[st_parent] OR  r=expression[st_parent]  { $out = new TP2.ASD.expressions.OrExpression($l.out, $r.out); }
    | l=comparison[st_parent] AND r=expression[st_parent]  { $out = new TP2.ASD.expressions.AndExpression($l.out, $r.out); }
    | NO e=expression[st_parent] { $out = new TP2.ASD.expressions.NoExpression($e.out); }
    | c=comparison[st_parent] { $out = $c.out; }
    ;

comparison [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : l=addition[st_parent] EQ  	r=comparison[st_parent]  { $out = new TP2.ASD.expressions.EqExpression($l.out, $r.out); }
    | l=addition[st_parent] INF  	r=comparison[st_parent]  { $out = new TP2.ASD.expressions.InfExpression($l.out, $r.out); }
	| l=addition[st_parent] SUP  	r=comparison[st_parent]  { $out = new TP2.ASD.expressions.SupExpression($l.out, $r.out); }
    | l=addition[st_parent] INFEQ 	r=comparison[st_parent]  { $out = new TP2.ASD.expressions.InfEqExpression($l.out, $r.out); }
    | l=addition[st_parent] SUPEQ 	r=comparison[st_parent]  { $out = new TP2.ASD.expressions.SupEqExpression($l.out, $r.out); }
    | f=addition[st_parent] { $out = $f.out; }
    ;

addition [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : l=factor[st_parent] PLUS  r=addition[st_parent]  { $out = new TP2.ASD.expressions.AddExpression($l.out, $r.out); }
    | l=factor[st_parent] MINUS r=addition[st_parent]  { $out = new TP2.ASD.expressions.SubExpression($l.out, $r.out); }
    | f=factor[st_parent] { $out = $f.out; }
    ;

factor [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : p=primary[st_parent] { $out = $p.out; }
    | l=primary[st_parent] MODUL r=factor[st_parent]  { $out = new TP2.ASD.expressions.ModExpression($l.out, $r.out); }
    | l=primary[st_parent] TIMES r=factor[st_parent]  { $out = new TP2.ASD.expressions.MulExpression($l.out, $r.out); }
    | l=primary[st_parent] DIVID r=factor[st_parent]  { $out = new TP2.ASD.expressions.DivExpression($l.out, $r.out); }
    ;																																																									

primary [TP2.SymbolTable st_parent] returns [TP2.ASD.expressions.Expression out]
    : in=INTEGER { $out = new TP2.ASD.expressions.IntegerExpression($in.int); }
    | LP e=expression[st_parent] { $out = $e.out; } RP
    | i=IDENT { List<TP2.ASD.expressions.Expression> list_args = null; } 
    	( LP ( e1=expression[st_parent] { list_args = new LinkedList<TP2.ASD.expressions.Expression>(); list_args.add($e1.out); } 
    	( COMMA e2=expression[st_parent] { list_args.add($e2.out); } )* )? RP)?	
    	{ $out = new TP2.ASD.expressions.IdentExpression($i.text, $st_parent, list_args); } 
    ;
