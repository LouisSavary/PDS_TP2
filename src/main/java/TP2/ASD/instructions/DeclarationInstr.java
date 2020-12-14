package TP2.ASD.instructions;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.PPIndentation;
import TP2.SymbolTable;
import TP2.Utils;
import TP2.SymbolTable.VariableSymbol;
import TP2.ASD.types.Int;
import TP2.ASD.types.IntArray;
import TP2.ASD.types.Type;
import TP2.exceptions.TypeException;

public class DeclarationInstr extends Instruction {
	List<VariableSymbol> vars;
	List<String> names;
	Type type;
	SymbolTable st;
	String errorMsg = null;
	
	public DeclarationInstr(String t, List<String> names, SymbolTable st, List<Integer> s) {
		this.type = Type.getType(t);
		this.st	= (st);
		this.vars = new ArrayList<VariableSymbol>(); 
		this.names = names;
		Iterator<Integer> it = s.iterator();
		for (String name : names) {
			if (it.hasNext()) {
				int size = it.next();
				VariableSymbol vs = null;
				if (size == 1) {
					vs = new VariableSymbol(type, name);
				} else if (type.equals(new Int()) && size > 0) {
					vs = new VariableSymbol(new IntArray(size), name);
				} else if (errorMsg == null)
					errorMsg = t + " : Mauvais type pour un tableau (seulement INT supporté)";

				st.add(vs);
				vars.add(vs);
			}
		}
		
		
	}
	
	@Override
	public IR toIR() throws TypeException {
		if (errorMsg != null)
			throw new TypeException(errorMsg);
		
		IR declaration_ir = new IR(Llvm.empty(), Llvm.empty());
		for (VariableSymbol vs : vars) {
			if (vs.type.equals(new IntArray())) {
				String tab = Utils.newtmp();
				declaration_ir.appendCode(new Llvm.Declare("[" + ((IntArray)vs.type).size + " x i32]", tab));
				declaration_ir.appendCode(new Llvm.GetElem("[" + ((IntArray)vs.type).size + " x i32]", tab, vs.ident, "0"));
			} else {
				declaration_ir.appendCode(new Llvm.Declare(vs.type.toLlvmType().toString(), vs.ident));
			}
		}
		return declaration_ir;
	}

	@Override
	public String pp() {
		String prettyPrinted = PPIndentation.getIndent() + type.pp();
		int first = 0;
		Iterator<String> it_names = names.iterator();
		for (VariableSymbol vs : vars) {
			if (vs.type.equals(new IntArray()))
					prettyPrinted += " " + it_names.next() + "[" + ((IntArray)vs.type).size + "]" + (first++ >0 ? ", " : "");
			else 	prettyPrinted += " " + it_names.next()							  			  + (first++ >0 ? ", " : "");
		}
		return prettyPrinted + "\n";
	}

}
