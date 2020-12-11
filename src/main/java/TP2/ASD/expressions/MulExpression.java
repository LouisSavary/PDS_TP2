package TP2.ASD.expressions;

import TP2.Llvm;
import TP2.Utils;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class MulExpression extends Expression {
	private Expression left, right;

	public MulExpression(Expression l, Expression r) {
		left = l;
		right = r;
	}

	@Override
	public String pp() {
		// TODO Auto-generated method stub
		return '(' + left.pp() + " * " + right.pp() + ')';
	}

	@Override
	public RetExpression toIR() throws TypeException, UndeclaredSymbolException {
		RetExpression leftRet = left.toIR();
		RetExpression rightRet = right.toIR();

		// We check if the types mismatches
		if (!leftRet.type.equals(rightRet.type)) {
			throw new TypeException("type mismatch: have " + leftRet.type + " and " + rightRet.type);
		}

		// We base our build on the left generated IR:
		// append right code
		leftRet.ir.append(rightRet.ir);

		// allocate a new identifier for the result
		String result = Utils.newtmp();

		// new add instruction result = left + right
		Llvm.Instruction mul = new Llvm.Mul(leftRet.type.toLlvmType(), leftRet.result, rightRet.result, result);

		// append this instruction
		leftRet.ir.appendCode(mul);

		// return the generated IR, plus the type of this expression
		// and where to find its result
		return new RetExpression(leftRet.ir, leftRet.type, result);
	}

}
