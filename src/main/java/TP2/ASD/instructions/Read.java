package TP2.ASD.instructions;

import java.util.List;

import TP2.Llvm;
import TP2.PPIndentation;
import TP2.SymbolTable;
import TP2.SymbolTable.Symbol;
import TP2.SymbolTable.VariableSymbol;
import TP2.Utils;
import TP2.ASD.types.Int;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class Read extends Instruction {

	private List<String> toRead;
	private SymbolTable st;
	
	public Read(List<String> l, SymbolTable st){
		this.toRead = l;
		this.st = st;
	}
	
	
	@Override
	public Llvm.IR toIR() throws TypeException, UndeclaredSymbolException{
		Llvm.IR readir = new Llvm.IR(Llvm.empty(), Llvm.empty());
		StringBuilder format = new StringBuilder(),
					  idents = new StringBuilder();
		int size = 0;
		int first = 0;
		
		for (String o : toRead) { // pour chaque nom de variable
			
			//verifier qu'elle est declarée
			Symbol var = st.lookup(o);
			if (var == null) throw new UndeclaredSymbolException("variable à lire non declarée : " + o);
			if (!var.type.equals(new Int())) throw new TypeException("Seules les variables INT peuvent etre lues : " + o);
			if (!(var instanceof VariableSymbol))throw new TypeException("Seules les variables peuvent etre lues : " + o);
			
			//l'ajouter au format
			if (first > 0) {
				size += 4;
				format.append(", %d");
			} else {
				format.append("%d");
				size += 2;
			}
			
			//l'ajouter aux arguments du read 
			//(il faut le % car c'est comme ca que la variable est declaree dans le llvm)
			if (first++ > 0)
				idents.append(", i32* %" + o);
			else
				idents.append("i32* %" + o);
		}
		size ++;
		format.append("\\00");
		
		//construction de l'appel a scanf
		String place = Utils.newglob("fmt");
		String tabindices = "[ " + size + " x i8 ]";
		readir.appendHeader(new Llvm.GlobalString(place, format.toString(), size));
		
		//par exemple : i8 ∗ getelementptr inbounds ([ 3 x i8 ], [ 3 x i8 ]∗ @.fmt1, i64 0, i64 0), i32 ∗ %n
		String appelFormat = "i8* getelementptr inbounds (" + tabindices + ", " 
				+ tabindices + "* " + place + ", i64 0, i64 0), " + idents.toString();
		
		
		Llvm.Instruction read = new Llvm.Read(appelFormat);
		readir.appendCode(read);
		return readir;
	}

	@Override
	public String pp() {
		StringBuilder s = new StringBuilder();
		int i = 0;
		for (String o : toRead)
			s.append((i++>0?", ":"") + o );
				
		return PPIndentation.getIndent() + "READ " + s.toString() + "\n";
	}

}
