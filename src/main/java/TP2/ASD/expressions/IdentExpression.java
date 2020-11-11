package TP2.ASD.expressions;

import java.util.ArrayList;
import java.util.List;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.SymbolTable;
import TP2.Utils;
import TP2.exceptions.TypeException;

// Concrete class for Expression: add case
public class IdentExpression extends Expression {
	String identName;
	SymbolTable st;
	List<Expression> args;

	public IdentExpression(String name, SymbolTable st, List<Expression> args) {
		this.identName = name;
		this.st = st;
		this.args = args;
	}

	// Pretty-printer
	public String pp() {
		if (args == null)
			return identName;
		else {
			String pp = identName + "(";
			for(Expression expr : args) {
				pp+=expr.toString()+", ";
			}
			pp= pp.substring(0, pp.length()-2) + ")";
			return pp;
		}
	}

	// IR generation
	public RetExpression toIR() throws TypeException {
		SymbolTable.Symbol var = st.lookup(identName);
		if (var == null) {
			throw new TypeException("variable non declarée");
		}
		
		IR identIR = new Llvm.IR(Llvm.empty(), Llvm.empty());
		List<String> arg_places = new ArrayList<String>();
		//TODO quand on aura implementé les fonctions
		if (args != null) {
			for(Expression expr : args) {
				//TODO s'il faut verifier les types des parametres
				identIR.append(expr.toIR().ir);
			}
		}
		identIR.appendCode(new Llvm.Ident(identName, var.type.toLlvmType(), arg_places));
		return new RetExpression(identIR, var.type, var.ident);
	}
}