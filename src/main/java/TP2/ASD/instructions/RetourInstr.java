package TP2.ASD.instructions;

import TP2.Llvm;
import TP2.PPIndentation;
import TP2.ASD.expressions.Expression;
import TP2.ASD.expressions.Expression.RetExpression;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class RetourInstr extends Instruction {

	private Expression expr;
	
	public RetourInstr(Expression expr){
		this.expr = expr;
		
	}
	
	
	@Override
	public Llvm.IR toIR() throws TypeException, UndeclaredSymbolException{
		RetExpression exprRet = expr.toIR();
		
		Llvm.Instruction assignement = new Llvm.Return(exprRet.type.toLlvmType(), exprRet.result);
		exprRet.ir.appendCode(assignement);		
		return exprRet.ir;
	}

	@Override
	public String pp() {
		return PPIndentation.getIndent() + "RETURN " + expr.pp() + "\n";
	}

}
