package TP2.ASD.instructions;

import TP2.Llvm;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public abstract class Instruction {
	public abstract Llvm.IR toIR() throws TypeException, UndeclaredSymbolException;
	public abstract String pp();

}