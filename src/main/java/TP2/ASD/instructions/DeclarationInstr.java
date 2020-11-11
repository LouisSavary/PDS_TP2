package TP2.ASD.instructions;

import java.util.List;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.PPIndentation;
import TP2.SymbolTable;
import TP2.ASD.types.Type;
import TP2.SymbolTable.*;
import TP2.exceptions.TypeException;

public class DeclarationInstr extends Instruction {
	List<String> names;
	Type type;
	SymbolTable st;
	
	public DeclarationInstr(String type, List<String> names, SymbolTable st) {
		this.type = Type.getType(type);
		this.names = names;
		this.st	= new SymbolTable(st);
		for (String name : names) {
			st.add(new VariableSymbol(this.type, name));
		}
	}
	
	public SymbolTable getSymbolTable() {
		return st;
	}
	
	@Override
	public IR toIR() throws TypeException {
		
		IR declaration_ir = new IR(Llvm.empty(), Llvm.empty());
		for (String name : names) {
			declaration_ir.appendHeader(new Llvm.Declare(type.toLlvmType(), name, 1));
		}
		return declaration_ir;
	}

	@Override
	public String pp() {
		String prettyPrinted = PPIndentation.getIndent() + type.pp();
		for (String name : names) {
			prettyPrinted += name + ", ";
		}
		prettyPrinted.substring(0, prettyPrinted.length() -2);
		return prettyPrinted;
	}

}
