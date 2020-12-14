package TP2.ASD.instructions;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;
import TP2.PPIndentation;
import TP2.Utils;
import TP2.ASD.expressions.Expression.RetExpression;
import TP2.ASD.types.Int;

public class While extends Instruction{
	TP2.ASD.expressions.Expression expression;
	TP2.ASD.instructions.Instruction instruction;
	TP2.SymbolTable symboltable;
	
	
	public While (
			TP2.ASD.expressions.Expression expr,
			TP2.ASD.instructions.Instruction stat,
			TP2.SymbolTable st) {
		expression = expr;
		instruction = stat;
		symboltable = new TP2.SymbolTable(st);
	}
	
	@Override
	public IR toIR() throws TypeException, UndeclaredSymbolException {
		RetExpression expr = expression.toIR();
		String startlab = Utils.newlab("while_start");
		String doinglab = Utils.newlab("while_do");
		String endlab 	= Utils.newlab("while_end");
		
		if (expr.type.equals(new Int())) {
			String place_comp = Utils.newtmp();
			expr.ir.appendCode(new Llvm.CompareToZero(place_comp, expr.result, expr.type.toLlvmType()));
			expr.result=place_comp;
		}

		
		IR ir_return = new TP2.Llvm.IR(Llvm.empty(), Llvm.empty());
		
		ir_return.appendCode(new Llvm.BrIncond(startlab));
		
		ir_return.appendCode(new Llvm.Label(startlab));
		ir_return.append(expr.ir);		
		ir_return.appendCode(new Llvm.BrCond(expr.result, doinglab, endlab));
		
		ir_return.appendCode(new Llvm.Label(doinglab));
		ir_return.append(instruction.toIR());
		ir_return.appendCode(new Llvm.BrIncond(startlab));
		
		ir_return.appendCode(new Llvm.Label(endlab));
		
		return ir_return;
	}

	@Override
	public String pp() {
		return PPIndentation.getIndent() + "WHILE " + expression.pp() + "\n" 
				+ PPIndentation.getIndent(1) +"DO\n" + instruction.pp() 
				+ PPIndentation.getIndent(-1) + "DONE\n";
	}

}
