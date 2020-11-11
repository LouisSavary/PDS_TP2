package TP2.ASD;

import TP2.Llvm;
import TP2.ASD.expressions.Expression;
import TP2.ASD.statements.Statement;
import TP2.exceptions.TypeException;

public class Program {
	Expression e; // What a program contains. TODO : change when you extend the language
	Statement l;

	public Program(Expression e) {
		this.e = e;
	}

	public Program(Statement l) {
		this.l = l;
	}

	// Pretty-printer
	public String pp() {
    	if (e != null)
    		return e.pp();
    	else {
    		return l.pp();
    	}
    		
    }

	// IR generation
	public Llvm.IR toIR() throws TypeException {
		// TODO : change when you extend the language
		if (l != null) {
			
			return l.toIR();
		}
		// computes the IR of the expression
		Expression.RetExpression retExpr = e.toIR();
		// add a return instruction
		Llvm.Instruction ret = new Llvm.Return(retExpr.type.toLlvmType(), retExpr.result);
		retExpr.ir.appendCode(ret);

		return retExpr.ir;
	}
}