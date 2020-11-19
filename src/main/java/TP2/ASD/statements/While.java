package TP2.ASD.statements;

import TP2.PPIndentation;
import TP2.Utils;
import TP2.ASD.expressions.Expression.RetExpression;
import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class While extends Statement{
	TP2.ASD.expressions.Expression expression;
	TP2.ASD.statements.Statement statement;
	TP2.SymbolTable symboltable;
	
	
	public While (
			TP2.ASD.expressions.Expression expr,
			TP2.ASD.statements.Statement stat,
			TP2.SymbolTable st) {
		expression = expr;
		statement = stat;
		symboltable = st;
	}
	
	@Override
	public IR toIR() throws TypeException, UndeclaredSymbolException {
		RetExpression expr = expression.toIR();
			
		String startlab = Utils.newlab("while_start");
		String doinglab = Utils.newlab("while_do");
		String endlab 	= Utils.newlab("while_end");
		
		IR ir_return = new TP2.Llvm.IR(Llvm.empty(), Llvm.empty());
		
		ir_return.appendCode(new Llvm.Label(startlab));
		ir_return.append(expr.ir);
		ir_return.appendCode(new Llvm.BrCond(expr.result, doinglab, endlab));
		
		ir_return.appendCode(new Llvm.Label(doinglab));
		ir_return.appendCode(new Llvm.Bloc(statement.toIR()));
		ir_return.appendCode(new Llvm.BrIncond(startlab));
		
		ir_return.appendCode(new Llvm.Label(endlab));
		
		return ir_return;
	}

	@Override
	public String pp() {
		// TODO Auto-generated method stub
		return PPIndentation.getIndent() + "WHILE " + expression.pp() + "\n" 
				+ PPIndentation.getIndent(1) +"DO\n" + statement.pp() 
				+ PPIndentation.getIndent(-1) + "DONE\n";
	}

}
