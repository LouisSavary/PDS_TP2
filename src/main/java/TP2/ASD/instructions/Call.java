package TP2.ASD.instructions;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.SymbolTable;
import TP2.SymbolTable.FunctionSymbol;
import TP2.SymbolTable.VariableSymbol;
import TP2.ASD.expressions.Expression;
import TP2.ASD.expressions.Expression.RetExpression;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class Call extends Instruction{
	String name;
	SymbolTable st;
	List<Expression> args;
	
	public Call (String name, SymbolTable st, List<Expression> l) {
		this.name = name;
		this.st = st;
		this.args = l;
	}
	
	@Override
	public IR toIR() throws TypeException, UndeclaredSymbolException {
		SymbolTable.Symbol var = st.lookup(name);
		if (var == null) {
			throw new UndeclaredSymbolException("variable non declarée : " + name);
		} 
		
		IR callIR = new Llvm.IR(Llvm.empty(), Llvm.empty());
		
		StringBuilder funcType = new StringBuilder(var.type.toLlvmType().toString() + " (");
		List<String> arg_places = new ArrayList<String>();
		if (args != null) {
			if (! (var instanceof FunctionSymbol))
				throw new UndeclaredSymbolException(name + " n'est pas declarée comme une fonction");
			
			int first = 0;
			Iterator<VariableSymbol> param_it = ((FunctionSymbol)var).arguments.iterator();
			for (Expression expr : args) {
				RetExpression exprIR = expr.toIR(); 
				callIR.append(exprIR.ir);
				if (first++ > 0) funcType.append(",");
				funcType.append(exprIR.type.toLlvmType().toString());
				arg_places.add(exprIR.type.toLlvmType().toString() + " " + exprIR.result);
				
				if (!param_it.hasNext() || !exprIR.type.equals(param_it.next().type))
					throw new TypeException("bad input type for " + name + " call");
			}
		}
		funcType.append(") ");
		
		callIR.appendCode(new Llvm.Ident("@" + name, funcType.toString(), arg_places, null));
		return callIR;
		
	}

	@Override
	public String pp() {
		String pp = name + "(";
		for(Expression expr : args) {
			pp+=expr.pp()+", ";
		}
		pp= pp.substring(0, pp.length()-2) + ")\n";
		return pp;
	}

}
