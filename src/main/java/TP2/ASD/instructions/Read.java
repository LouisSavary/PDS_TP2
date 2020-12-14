package TP2.ASD.instructions;

import java.util.List;

import TP2.Llvm;
import TP2.PPIndentation;
import TP2.SymbolTable;
import TP2.SymbolTable.Symbol;
import TP2.SymbolTable.VariableSymbol;
import TP2.Utils;
import TP2.ASD.expressions.Expression;
import TP2.ASD.expressions.Expression.RetExpression;
import TP2.ASD.types.Int;
import TP2.ASD.types.IntArray;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class Read extends Instruction {

	private List<Object> toRead;
	private SymbolTable st;
	
	public Read(List<Object> l, SymbolTable st){
		this.toRead = l;
		this.st = st;
	}
	
	
	@Override
	public Llvm.IR toIR() throws TypeException, UndeclaredSymbolException{
		Llvm.IR readir = new Llvm.IR(Llvm.empty(), Llvm.empty());
		StringBuilder format = new StringBuilder(),
					  idents = new StringBuilder();
		int first = 0;
		
		for (int i = 0; i < toRead.size(); i ++) { // pour chaque nom de variable
			Object o = toRead.get(i);
			if (o instanceof String) {
				//verifier qu'elle est declarée
				Symbol var = st.lookup((String) o);
				if (var == null) throw new UndeclaredSymbolException("variable à lire non declarée : " + o);
				if (!(var instanceof VariableSymbol))throw new TypeException("Seules les variables peuvent etre lues : " + o);
				if (var.type.equals(new Int()) || var.type.equals(new IntArray()) ) { 
					
					//l'ajouter au format
					if (first > 0) {
						format.append(" %d");
					} else {
						format.append("%d");
					}
					
					String place = var.ident;
					
					// construit le pointeur vers l'element du tableau à lire
					if (var.type.equals(new IntArray())) {
						// on recupere l'element suivant de la liste qui doit etre une expression
						Object index = toRead.get(++i);
						if (! (index instanceof Expression)) 
							throw new TypeException("error encountered while parsing READ arguments : didn't find an Expression");
						
						String deref = Utils.newtmp();
						
						RetExpression indexIr = ((Expression) index).toIR();
						readir.append(indexIr.ir);
						//on recupere un pointeur d'entier
						readir.appendCode(new Llvm.GetPtr((new Int()).toLlvmType().toString(), var.ident, deref, indexIr.result));
					
						place = deref;
					}

					//l'ajouter aux arguments du read 
					//(il faut le % car c'est comme ca que la variable est declaree dans le llvm)
					if (first++ > 0)
						idents.append(", i32* " + place);
					else
						idents.append("i32* " + place);
					
					
			    } else throw new TypeException("Seules les variables INT peuvent etre lues : " + o);
			} else throw new TypeException("error encountered while parsing READ arguments : didn't find a String ");
		}
		
		
		//construction de l'appel a scanf
		String place = Utils.newglob(".fmt");
		Llvm.GlobalString fmt_format = new Llvm.GlobalString(place, format.toString());
		String tabindices = "[" + fmt_format.length() + " x i8]";
		readir.appendHeader(fmt_format);
		
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
		for (Object o : toRead) {
			if (o instanceof String) 			s.append((i++>0?", ":"") + o );
			else if (o instanceof Expression) 	s.append("[" + ((Expression) o).pp() + "]");
		}
		
		return PPIndentation.getIndent() + "READ " + s.toString() + "\n";
	}

}
