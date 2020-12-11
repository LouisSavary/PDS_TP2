package TP2.ASD.expressions;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.SymbolTable;
import TP2.SymbolTable.FunctionSymbol;
import TP2.SymbolTable.VariableSymbol;
import TP2.Utils;
import TP2.ASD.types.Void;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

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
				pp+=expr.pp()+", ";
			}
			pp= pp.substring(0, pp.length()-2) + ")";
			return pp;
		}
	}

	// IR generation
	public RetExpression toIR() throws TypeException, UndeclaredSymbolException {
		SymbolTable.Symbol var = st.lookup(identName);
		
		if (var == null) {
			throw new UndeclaredSymbolException("variable non declarée : " + identName);
		} 
		
		
		IR identIR = new Llvm.IR(Llvm.empty(), Llvm.empty());
		
		if (var instanceof VariableSymbol) {
			String place = Utils.newtmp();
			identIR.appendCode(new Llvm.Load(var.type.toLlvmType(), "%" + var.ident, place));
			return new RetExpression(identIR, var.type, place);
		
		} else { //fonction		
			
			List<String> arg_places = new ArrayList<String>();
			if (args != null) {
				if (! (var instanceof FunctionSymbol))
					throw new UndeclaredSymbolException(identName + " n'est pas declarée comme une fonction");
				
				Iterator<VariableSymbol> param_it = ((FunctionSymbol)var).arguments.iterator();
				for (Expression expr : args) {
					RetExpression exprIR = expr.toIR(); 
					identIR.append(exprIR.ir);
					arg_places.add(exprIR.type.toLlvmType().toString() + " " + exprIR.result);
					
					if (!param_it.hasNext() || !exprIR.type.equals(param_it.next().type))
						throw new TypeException("bad input type for " + identName + " call");
					
					
				}
			}
			//si la fonction a une valeur de retour
			String place = null;
			if (!var.type.equals(new Void())) {
				place = Utils.newtmp();
			}
			
			//ajouter une instruction de call si fonction
			identIR.appendCode(new Llvm.Ident("@" + identName, var.type.toLlvmType().toString(), arg_places, place));
			return new RetExpression(identIR, var.type, place);
		}
	}
}