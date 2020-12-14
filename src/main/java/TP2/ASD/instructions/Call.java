package TP2.ASD.instructions;

import java.util.List;

import TP2.Llvm.IR;
import TP2.SymbolTable;
import TP2.ASD.expressions.CallFuncExpression;
import TP2.ASD.expressions.Expression;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class Call extends Instruction{
	CallFuncExpression call;	
	
	public Call (String name, SymbolTable st, List<Expression> args) {
		this.call = new CallFuncExpression(name, st, args);
	}
	
	@Override
	public IR toIR() throws TypeException, UndeclaredSymbolException {
		return call.toIR().ir;
	}

	@Override
	public String pp() {
		return call.pp()+"\n";
	}

}
