package TP2.ASD.statements;

import java.util.List;

import TP2.Llvm;
import TP2.PPIndentation;
import TP2.Llvm.IR;
import TP2.exceptions.TypeException;

public class Block extends Statement{
	List<TP2.ASD.statements.Statement> l;
	
	public Block (List<TP2.ASD.statements.Statement> l) {
		this.l = l;
	}
	
	@Override
	public IR toIR() throws TypeException {
		IR blockir = new Llvm.IR(Llvm.empty(), Llvm.empty());
		for(Statement s : l)
			blockir.append(s.toIR());
		return blockir;
	}

	@Override
	public String pp() {
		
		String blockir = PPIndentation.getIndent(-1) + "{\n";
		PPIndentation.indent();
		for(Statement s : l)
			blockir+=(s.pp());
		blockir +=PPIndentation.getIndent(-1) + "}\n";
		PPIndentation.indent();
		return blockir;
	}

}
