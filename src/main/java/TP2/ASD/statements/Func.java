package TP2.ASD.statements;

import java.util.ArrayList;
import java.util.List;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.PPIndentation;
import TP2.SymbolTable;
import TP2.SymbolTable.FunctionSymbol;
import TP2.SymbolTable.VariableSymbol;
import TP2.ASD.instructions.Instruction;
import TP2.ASD.types.Bool;
import TP2.ASD.types.Int;
import TP2.ASD.types.IntArray;
import TP2.ASD.types.Type;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class Func extends Statement {
	String name;
	Type type;
	List<VariableSymbol> args;
	List<String> args_names_pp;
	SymbolTable st;
	Instruction code;
	
	public Func(String type, String name, List<VariableSymbol> args, SymbolTable st, Instruction code, List<String> arg_names) {
		this.name = name;
		this.type = Type.getType(type);
		this.args = args;
		this.st   = st;
		this.code = code;

		this.args_names_pp = new ArrayList<>();
		for (int i = 0; i < arg_names.size(); i++)
			this.args_names_pp.add(arg_names.get(i) 
					+(args.get(i).type.equals(new IntArray())?"[]":""));
		
		st.add(new FunctionSymbol(this.type, name, args, true));
	}
	
	public SymbolTable getSymbolTable() {
		return st;
	}

	@Override
	public IR toIR() throws TypeException, UndeclaredSymbolException {
		IR total = new Llvm.IR(Llvm.empty(), Llvm.empty());
		IR irInFunction = new Llvm.IR(Llvm.empty(), Llvm.empty());
		String label = '@' + name;
		
		// initialisation des parametres
		StringBuilder arguments = new StringBuilder();
		int first = 0;
		
		for (VariableSymbol v : args) {
			String newName = v.ident ;
			String argType = v.type.toLlvmType().toString();
			
			if (first++ >0) arguments.append(", ");
			if (v.type.equals(new IntArray())) {
				argType = "i32*";
			} else {
				newName += "1";
				
				// initialiser les pointeurs
				irInFunction.appendCode(new Llvm.Declare(argType, v.ident));
				irInFunction.appendCode(new Llvm.Assign(v.ident, argType, newName));
			}
			arguments.append(argType + " " + newName);
		}
		
		
		
		
		// construction de l'ir du code de la fonction
		IR codeIR = code.toIR();
		irInFunction.append(codeIR);
		
		//dans le doute, on ajoute une instruction de retour
		if (type.equals(new Int()))
			irInFunction.appendCode(new Llvm.Return(type.toLlvmType(), " 0"));
		else if (type.equals(new Bool()))
			irInFunction.appendCode(new Llvm.Return(type.toLlvmType(), " 0"));
		else //if (type.equals(new Void()))
			irInFunction.appendCode(new Llvm.Return(type.toLlvmType(), ""));
		
		total.appendCode(new Llvm.Func(type.toLlvmType(), label, arguments.toString()));
		total.append(irInFunction);
		total.appendCode(new Llvm.FuncEnd());
		return total;
	}

	@Override
	public String pp() {
		String pp_ret = PPIndentation.getIndent() + "FUNC " + type.pp() + " " + name + "(";
		boolean first = true;
		for(String vs : args_names_pp) // ecrit la liste des arguments et leurs types
			if (first) {
				pp_ret += vs;
				first = false;
			} else
				pp_ret += ", " + vs;

		pp_ret += ")\n";
		PPIndentation.indent();
		pp_ret += code.pp();
		PPIndentation.unindent();
		return pp_ret;
	}

}
