package TP2.ASD;

import TP2.Llvm;
import TP2.TypeException;

public abstract class Instruction {
	public abstract Llvm.IR toIR() throws TypeException;
	public abstract String pp();
	
}
