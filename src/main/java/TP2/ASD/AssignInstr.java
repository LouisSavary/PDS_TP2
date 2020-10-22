package TP2.ASD;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.TypeException;
import TP2.ASD.Expression.RetExpression;

public class AssignInstr extends Instruction {

	private String symbol;
	private Expression expr;
	
	public AssignInstr(String symbol, Expression expr) {
		this.symbol = symbol;
		this.expr = expr;
	}
	@Override
	public IR toIR() throws TypeException{
		
		RetExpression exprRet = expr.toIR();
		Llvm.Instruction assignement = new Llvm.Assign(symbol, exprRet.type.toLlvmType(), exprRet.result);
		exprRet.ir.appendCode(assignement);
		
		return exprRet.ir;
	}

	@Override
	public String pp() {
		return symbol + " := " + expr.pp();
	}

}
