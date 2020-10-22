package TP2.ASD;

import java.util.List;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.SymbolTable;
import TP2.TypeException;

public class DeclarationInstr extends Instruction{
	List<String> names;
	Type type;
	
	public DeclarationInstr(String type, List<String> names) {
		this.type = Type.getType(type);
		this.names = names;
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
		String prettyPrinted = type.pp();
		for (String name : names) {
			prettyPrinted += name + ", ";
		}
		prettyPrinted.substring(0, prettyPrinted.length() -2);
		return prettyPrinted;
	}

}
