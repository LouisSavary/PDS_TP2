package TP2.ASD;

import java.util.List;

import TP2.Llvm;
import TP2.ASD.expressions.Expression;
import TP2.ASD.instructions.Instruction;
import TP2.exceptions.TypeException;

public class Program {
	Expression e; // What a program contains. TODO : change when you extend the language
	List<Instruction> l;

	public Program(Expression e) {
		this.e = e;
	}

	public Program(List<Instruction> l) {
		this.l = l;
	}

	// Pretty-printer
	public String pp() {
    	if (e != null)
    		return e.pp();
    	else {
    		String ret = "";
    		for(Instruction inst:l) 
    			ret += inst.pp();
    		return ret;
    	}
    		
    }

	// IR generation
	public Llvm.IR toIR() throws TypeException {
		// TODO : change when you extend the language
		if (l != null) {
			Llvm.IR ir = new Llvm.IR(Llvm.empty(), Llvm.empty());
			for (Instruction instr : l) {
				ir.append(instr.toIR());
			}
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