package TP2.ASD.statements;

import TP2.Llvm;
import TP2.exceptions.TypeException;

public abstract class Statement {
	public abstract Llvm.IR toIR() throws TypeException;
	public abstract String pp();
	
}
