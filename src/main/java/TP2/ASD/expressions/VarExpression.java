package TP2.ASD.expressions;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.SymbolTable;
import TP2.SymbolTable.VariableSymbol;
import TP2.Utils;
import TP2.ASD.types.IntArray;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

// Concrete class for Expression: add case
public class VarExpression extends Expression {
	String identName;
	SymbolTable st;

	public VarExpression(String name, SymbolTable st) {
		this.identName = name;
		this.st = st;
	}

	// Pretty-printer
	public String pp() {
		return identName;
	}

	// IR generation
	public RetExpression toIR() throws TypeException, UndeclaredSymbolException {
		SymbolTable.Symbol var = st.lookup(identName);

		if (var == null) {
			throw new UndeclaredSymbolException("variable non declarée : " + identName);
		}

		IR identIR = new Llvm.IR(Llvm.empty(), Llvm.empty());

		if (var instanceof VariableSymbol) {
			String place = var.ident;
			if (!var.type.equals(new IntArray())) {
				place = Utils.newtmp();
				identIR.appendCode(new Llvm.Load(var.type.toLlvmType(), var.ident, place));
			} else {
				// on renvoie simplement le pointeur vers le debut du tableau
			}
			
			 
			return new RetExpression(identIR, var.type, place);

		} else {
			throw new UndeclaredSymbolException(var.ident + " n'est pas declarée comme une variable");
		}
	}
}