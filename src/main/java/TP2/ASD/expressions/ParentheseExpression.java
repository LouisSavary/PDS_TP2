package TP2.ASD.expressions;

import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

// Concrete class for Expression: add case
public class ParentheseExpression extends Expression {
	Expression e;

	public ParentheseExpression(Expression e) {
		this.e = e;
	}

	// Pretty-printer
	public String pp() {
		return "(" + e.pp() + ")";
	}

	// IR generation
	public RetExpression toIR() throws TypeException, UndeclaredSymbolException {
		return e.toIR();
	}
}