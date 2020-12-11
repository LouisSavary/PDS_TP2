package TP2.ASD;

import java.util.List;

import TP2.Llvm;
import TP2.ASD.expressions.Expression;
import TP2.ASD.statements.Statement;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class Program {
	Expression e; // What a program contains. TODO : change when you extend the language
	List<Statement> l;

	public Program(Expression e) {
		this.e = e;
	}

	public Program(List<Statement> l) {
		this.l = l;
	}

	// Pretty-printer
	public String pp() {
    	if (e != null)
    		return e.pp();
    	else {
    		StringBuilder s = new StringBuilder();
    		for (Statement st : l)
    			s.append(st.pp());
    		return s.toString();
    	}
    		
    }

	// IR generation
	public Llvm.IR toIR() throws TypeException, UndeclaredSymbolException {
		// TODO : change when you extend the language
		if (e == null) {
			Llvm.IR ir = new Llvm.IR(Llvm.empty(), Llvm.empty());
			for (Statement s : l) ir.append(s.toIR());
			return ir;
		}
		// computes the IR of the expression
		Expression.RetExpression retExpr = e.toIR();
		// add a return instruction
		Llvm.Instruction ret = new Llvm.Return(retExpr.type.toLlvmType(), retExpr.result);
		retExpr.ir.appendCode(ret);

		return retExpr.ir;
	}
}