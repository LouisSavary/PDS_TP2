package TP2.ASD.instructions;

import TP2.Llvm;
import TP2.exceptions.TypeException;

public abstract class Instruction {
	public abstract Llvm.IR toIR() throws TypeException;
	public abstract String pp();
	
}