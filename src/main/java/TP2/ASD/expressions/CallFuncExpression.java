package TP2.ASD.expressions;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.SymbolTable;
import TP2.SymbolTable.FunctionSymbol;
import TP2.SymbolTable.Symbol;
import TP2.SymbolTable.VariableSymbol;
import TP2.Utils;
import TP2.ASD.types.Int;
import TP2.ASD.types.IntArray;
import TP2.ASD.types.Void;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

// Concrete class for Expression: add case
public class CallFuncExpression extends Expression {
	String identName;
	SymbolTable st;
	List<Expression> args;

	public CallFuncExpression(String name, SymbolTable st, List<Expression> args) {
		this.identName = name;
		this.st = st;
		this.args = args;
	}

	// Pretty-printer
	public String pp() {
		if (args == null)
			return identName + "()";
		else {
			String pp = identName + "(";
			int first = 0;
			for (Expression expr : args) {
				if (first++ > 0)
					pp += ", ";
				pp += expr.pp();
			}
			pp += ")";
			return pp;
		}
	}

	// IR generation
	public RetExpression toIR() throws TypeException, UndeclaredSymbolException {
		SymbolTable.Symbol var = st.lookup(identName);

		if (var == null) {
			throw new UndeclaredSymbolException("fonction non declarée : " + identName);
		}

		IR identIR = new Llvm.IR(Llvm.empty(), Llvm.empty());

		if (var instanceof FunctionSymbol) {

			List<String> arg_places = new ArrayList<String>();
			if (args != null) {
				if (!(var instanceof FunctionSymbol))
					throw new UndeclaredSymbolException(identName + " n'est pas declarée comme une fonction");

				Iterator<VariableSymbol> param_it = ((FunctionSymbol) var).arguments.iterator();
				for (Expression expr : args) {
					RetExpression exprIR = expr.toIR();
					identIR.append(exprIR.ir);
					if (exprIR.type.equals(new IntArray())) {
						String tabptr = Utils.newtmp();
						identIR.appendCode(new Llvm.GetPtr((new Int()).toLlvmType().toString(), exprIR.result, tabptr, "0"));
						arg_places.add("i32* " + tabptr);
	
					}else {
						arg_places.add(exprIR.type.toLlvmType().toString()
								+ " " + exprIR.result);
					}
					if (!param_it.hasNext() )
						throw new UndeclaredSymbolException(identName + " call error : too many parameters ");
					Symbol expected = param_it.next();
					if (!exprIR.type.equals(expected.type))
						throw new TypeException("bad input type for " + identName + " call :\n"
								+ "expected : " + expected.type.toString() + " " + expected.ident + "\n"
								+ "found :    " + exprIR.type.toString() + " " + expr.pp());
				}
			}
			
			// si la fonction a une valeur de retour
			String place = null;
			if (!var.type.equals(new Void())) {
				place = Utils.newtmp();
			}

			// ajouter une instruction de call si fonction
			identIR.appendCode(new Llvm.Call("@" + identName, var.type.toLlvmType().toString(), arg_places, place));
			return new RetExpression(identIR, var.type, place);
		} else {
			throw new UndeclaredSymbolException(var.ident + " n'est pas declarée comme une fonction");
		}
	}
}