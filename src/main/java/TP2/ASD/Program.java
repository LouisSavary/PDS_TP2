package TP2.ASD;

import java.util.List;

import TP2.Llvm;
import TP2.ASD.statements.Statement;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class Program {
	List<Statement> l;

	
	public Program(List<Statement> l) {
		this.l = l;
	}

	// Pretty-printer
	public String pp() {
		StringBuilder s = new StringBuilder();
		for (Statement st : l)
			s.append(st.pp());
		return s.toString();
    		
    }

	// IR generation
	public Llvm.IR toIR() throws TypeException, UndeclaredSymbolException {
		Llvm.IR ir = new Llvm.IR(Llvm.empty(), Llvm.empty());
		for (Statement s : l) ir.append(s.toIR());
		return ir;

	}
}