package TP2.ASD.instructions;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.PPIndentation;
import TP2.SymbolTable;
import TP2.SymbolTable.Symbol;
import TP2.ASD.expressions.Expression;
import TP2.ASD.expressions.Expression.RetExpression;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class AssignInstr extends Instruction {

	private String symbol;
	private Expression expr;
	private SymbolTable symbolTable;
	
	public AssignInstr(String symbol, Expression expr, SymbolTable st){
		this.symbol = symbol;
		this.expr = expr;
		this.symbolTable = st;
	}
	
	
	@Override
	public IR toIR() throws TypeException, UndeclaredSymbolException{
		
		RetExpression exprRet = expr.toIR();
		Symbol st_lookup = symbolTable.lookup(symbol);
		if (st_lookup == null)
			throw(new UndeclaredSymbolException("undeclared symbol : " + symbol + " in : " + this.pp()));
		if (! exprRet.type.equals(st_lookup.type))
			throw(new TypeException("type mismatch in assignement : " + this.pp()));
		
		Llvm.Instruction assignement = new Llvm.Assign("%"+symbol, exprRet.type.toLlvmType().toString(), exprRet.result);
		exprRet.ir.appendCode(assignement);
		
		return exprRet.ir;
	}

	@Override
	public String pp() {
		return PPIndentation.getIndent() + symbol + " := " + expr.pp() + "\n";
	}

}
