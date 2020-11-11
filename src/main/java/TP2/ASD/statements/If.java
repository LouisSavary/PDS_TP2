package TP2.ASD.statements;

import TP2.Llvm;
import TP2.Llvm.BrCond;
import TP2.Llvm.IR;
import TP2.Llvm.Label;
import TP2.PPIndentation;
import TP2.SymbolTable;
import TP2.Utils;
import TP2.ASD.expressions.Expression;
import TP2.ASD.expressions.Expression.RetExpression;
import TP2.exceptions.TypeException;

public class If extends Statement{
	TP2.ASD.expressions.Expression cond;
	TP2.ASD.statements.Statement then_stat, else_stat;
	TP2.SymbolTable st;
	
	
	
	public If(Expression cond, 
			Statement then_stat, 
			Statement else_stat, 
			SymbolTable st) {
		super();
		this.cond = cond;
		this.then_stat = then_stat;
		this.else_stat = else_stat;
		this.st = st;
	}

	@Override
	public IR toIR() throws TypeException {
		String then_lab = Utils.newlab("if_then");
		String else_lab = Utils.newlab("if_else");
		String end_lab = Utils.newlab("if_end");
		RetExpression cond_ret = cond.toIR(); 
		
		IR ifIR = cond_ret.ir;
		ifIR.appendCode(new Llvm.BrCond(cond_ret.result, then_lab, else_lab));
		
		ifIR.appendCode(new Llvm.Label(then_lab));
		ifIR.appendCode(new Llvm.Bloc(then_stat.toIR()));
		ifIR.appendCode(new Llvm.BrIncond(end_lab));
		
		ifIR.appendCode(new Llvm.Label(else_lab));
		ifIR.appendCode(new Llvm.Bloc(else_stat.toIR()));
		ifIR.appendCode(new Llvm.Label(end_lab));
		return ifIR;
	}

	@Override
	public String pp() {
		// TODO Auto-generated method stub
		String pp = PPIndentation.getIndent() + "IF " + cond.pp() + "\n" 
				+ PPIndentation.getIndent(1) +"THEN\n" + then_stat.pp() 
				+ PPIndentation.getIndent(-1) + "ELSE\n";
		PPIndentation.indent();
		return pp + then_stat.pp() 
				+ PPIndentation.getIndent(-1) + "FI\n";	}

}
