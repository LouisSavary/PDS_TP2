package TP2.ASD.instructions;

import java.util.List;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.PPIndentation;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class Block extends Instruction{
	List<TP2.ASD.instructions.Instruction> l;
	
	public Block (List<TP2.ASD.instructions.Instruction> l) {
		this.l = l;
	}
	
	@Override
	public IR toIR() throws TypeException, UndeclaredSymbolException {
		IR blockir = new Llvm.IR(Llvm.empty(), Llvm.empty());
		for(Instruction s : l)
			blockir.append(s.toIR());
		return blockir;
	}

	@Override
	public String pp() {
		
		String blockir = PPIndentation.getIndent(-1) + "{\n";
		PPIndentation.indent();
		for(Instruction s : l)
			blockir+=(s.pp());
		blockir +=PPIndentation.getIndent(-1) + "}\n";
		PPIndentation.indent();
		return blockir;
	}

}
