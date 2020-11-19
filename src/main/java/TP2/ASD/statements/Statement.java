package TP2.ASD.statements;

import TP2.Llvm;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public abstract class Statement {
	public abstract Llvm.IR toIR() throws TypeException, UndeclaredSymbolException;
	public abstract String pp();
	
}