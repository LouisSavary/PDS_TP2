package TP2.ASD.instructions;

import java.util.List;

import TP2.Llvm;
import TP2.PPIndentation;
import TP2.Utils;
import TP2.ASD.expressions.Expression;
import TP2.ASD.expressions.Expression.RetExpression;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class Print extends Instruction {

	private List<Object> toPrint;
	
	public Print(List<Object> l){
		this.toPrint = l;
		
	}
	
	
	@Override
	public Llvm.IR toIR() throws TypeException, UndeclaredSymbolException{
		Llvm.IR printir    = new Llvm.IR(Llvm.empty(), Llvm.empty());
		StringBuilder s    = new StringBuilder();
		StringBuilder args = new StringBuilder();
		String place = Utils.newglob(".fmt");

		for (Object o : toPrint) {
			
			if (o instanceof String) {
				
				s.append(o);
				
			} else if (o instanceof Expression) {
				RetExpression retIr = ((Expression) o).toIR();
				printir.append(retIr.ir);
				
				args.append(", " + retIr.type.toLlvmType().toString() + " " + retIr.result);
				
				s.append("%d");
			}
		}
		
		Llvm.GlobalString format = new Llvm.GlobalString(place, s.toString());
		
		String tabindices = "[" + (format.length()) + " x i8]";
		
		
		printir.appendHeader(format);
		String toPrint = "i8* getelementptr inbounds (" + tabindices + ", " + tabindices + "* " + place + ", i64 0, i64 0)" + args.toString();
		
		printir.appendCode(new Llvm.Print(toPrint));
		return printir;
	}

	@Override
	public String pp() {
		StringBuilder s = new StringBuilder();
		int i = 0;
		for (Object o : toPrint) {
			if (i++ > 0) s.append(", ");
			if (o instanceof String) s.append("\"" + o + "\"");
			else if (o instanceof Expression) s.append(((Expression) o).pp());
		}
		return PPIndentation.getIndent() + "PRINT " + s.toString() + "\n";
	}

}
