package TP2.ASD.expressions;

import TP2.Llvm;
import TP2.SymbolTable;
import TP2.SymbolTable.VariableSymbol;
import TP2.Utils;
import TP2.ASD.types.Int;
import TP2.ASD.types.IntArray;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

// Concrete class for Expression: add case
public class TabElementExpression extends Expression {
	String identName;
	SymbolTable st;
	Expression arg;

	public TabElementExpression(String name, SymbolTable st, Expression a) {
		this.identName = name;
		this.st = st;
		this.arg = a;
	}

	// Pretty-printer
	public String pp() {
		if (arg == null)
			return identName; // ne devrait pas arriver
		else {
			return identName + "[" + arg.pp() + "]";
		}
	}

	// IR generation
	public RetExpression toIR() throws TypeException, UndeclaredSymbolException {
		SymbolTable.Symbol var = st.lookup(identName);
		
		if (var == null) {
			throw new UndeclaredSymbolException("variable non declarée : " + identName);
		} 
		
		if (var instanceof VariableSymbol && var.type.equals(new IntArray())) {
			String ptrindex = Utils.newtmp();
			String place 	= Utils.newtmp();
			RetExpression ret = arg.toIR();
			
			ret.ir.appendCode(new Llvm.GetPtr((new Int()).toLlvmType().toString(), var.ident, ptrindex, ret.result));
			ret.ir.appendCode(new Llvm.Load(new Int().toLlvmType(), ptrindex, place));
			return new RetExpression(ret.ir, new Int(), place);
			
		} else {
			throw new UndeclaredSymbolException(var.ident + " n'est pas declarée comme un tableau");
		}
	} 
}