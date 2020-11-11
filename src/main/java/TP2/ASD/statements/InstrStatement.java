package TP2.ASD.statements;

import TP2.Llvm.IR;
import TP2.ASD.instructions.Instruction;
import TP2.exceptions.TypeException;

public class InstrStatement extends Statement{
	TP2.ASD.instructions.Instruction instr;
	
	public InstrStatement(Instruction i) {
		instr = i;
	}
	@Override
	public IR toIR() throws TypeException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String pp() {
		// TODO Auto-generated method stub
		return null;
	}

}
