package TP2.ASD.statements;

import java.util.List;

import TP2.Llvm.IR;
import TP2.Llvm;
import TP2.PPIndentation;
import TP2.SymbolTable;
import TP2.SymbolTable.FunctionSymbol;
import TP2.SymbolTable.VariableSymbol;
import TP2.ASD.types.Type;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class Proto extends Statement {
	String name;
	Type type;
	List<VariableSymbol> args;
	SymbolTable st;
	
	public Proto(String type, String name, List<VariableSymbol> args, SymbolTable st) {
		this.name = name;
		this.type = Type.getType(type);
		this.args = args;
		this.st   = st;
		st.add(new FunctionSymbol(this.type, name, args, false));
	}
	
	public SymbolTable getSymbolTable() {
		return st;
	}

	@Override
	public IR toIR() throws TypeException, UndeclaredSymbolException {
		return new Llvm.IR(Llvm.empty(), Llvm.empty());
	}

	@Override
	public String pp() {
		String pp_ret = PPIndentation.getIndent() + "PROTO " + type.pp() + " " + name + "(";
		boolean first = true;
		for(VariableSymbol vs : args) // ecrit la liste des arguments et leurs types
			if (first) {
				pp_ret += vs.type.pp() + " " + vs.ident;
				first = false;
			} else
				pp_ret += ", " + vs.type.pp() + " " + vs.ident;

		pp_ret += ")\n";
		return pp_ret;
	}

}
