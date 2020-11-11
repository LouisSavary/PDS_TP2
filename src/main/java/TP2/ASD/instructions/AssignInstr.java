package TP2.ASD.instructions;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.PPIndentation;
import TP2.exceptions.TypeException;
import TP2.SymbolTable;
import TP2.SymbolTable.VariableSymbol;
import TP2.ASD.expressions.Expression;
import TP2.ASD.expressions.Expression.RetExpression;
import TP2.ASD.types.Type;

public class AssignInstr extends Instruction {

	private String symbol;
	private Expression expr;
	private SymbolTable symbolTable;
	
	public AssignInstr(String symbol, Expression expr, SymbolTable st){
		this.symbol = symbol;
		this.expr = expr;
		this.symbolTable = st;
		
		
//		symbolTable.add(new SymbolTable.VariableSymbol(, symbol));
	}
	
	public SymbolTable getSymbolTable() {
		return symbolTable;
	}
	
	@Override
	public IR toIR() throws TypeException{
		
		RetExpression exprRet = expr.toIR();
		if (exprRet.type != symbolTable.lookup(symbol).type)
			throw(new TypeException("type mismatch in assignement : " + this.pp()));
		Llvm.Instruction assignement = new Llvm.Assign(symbol, exprRet.type.toLlvmType(), exprRet.result);
		exprRet.ir.appendCode(assignement);
		
		return exprRet.ir;
	}

	@Override
	public String pp() {
		return PPIndentation.getIndent() + symbol + " := " + expr.pp();
	}

}
