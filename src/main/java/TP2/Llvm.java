package TP2;

import java.util.ArrayList;
import java.util.List;

import TP2.Utils.LLVMStringConstant;

// This file contains a simple LLVM IR representation
// and methods to generate its string representation

public class Llvm {

	static public class IR {
		List<Instruction> header; // IR instructions to be placed before the code (global definitions)
		List<Instruction> code; // main code

		public IR(List<Instruction> header, List<Instruction> code) {
			this.header = header;
			this.code = code;
		}

		// append an other IR
		public IR append(IR other) {
			header.addAll(other.header);
			code.addAll(other.code);
			return this;
		}

		// append a code instruction
		public IR appendCode(Instruction inst) {
			code.add(inst);
			return this;
		}

		// append a code header
		public IR appendHeader(Instruction inst) {
			header.add(inst);
			return this;
		}

		// Final string generation
		public String toString() {
			// This header describe to LLVM the target
			// and declare the external function printf
			StringBuilder r = new StringBuilder(""
					+"; Target\n" + "target triple = \"x86_64-unknown-linux-gnu\"\n"
					+ "; External declaration of the printf function\n"
					+ "declare i32 @printf(i8* noalias nocapture, ...)\n"
					+ "declare i32 @scanf(i8* noalias nocapture, ...)\n"
					+ "\n; Actual code begins\n\n");

			for (Instruction inst : header)
				r.append(inst.toString());

			r.append("\n\n");

			for (Instruction inst : code) {
				if (inst instanceof Label 
						|| inst instanceof Func
						|| inst instanceof FuncEnd)
					r.append(inst.toString());
				else 
					r.append(Utils.indent(1) + inst.toString());

			}
			
			
			return r.toString();
		}
	}

	// Returns a new empty list of instruction, handy
	static public List<Instruction> empty() {
		return new ArrayList<Instruction>();
	}

	// LLVM Types
	static public abstract class Type {
		public abstract String toString();
	}

	static public class Int extends Type {
		public String toString() {
			return "i32";
		}
	}

	static public class Bool extends Type {
		public String toString() {
			return "i1";
		}
	}
	
	static public class Void extends Type {
		public String toString() {
			return "void";
		}
	}

	static public class IntArray extends Type {
		int size;
		public IntArray (int s) {
			size = s;
		}
		public String toString() {
			//return "[" + size + " x i32]";
			return "i32*";
		}
	}
	
	// LLVM IR Instructions
	static public abstract class Instruction {
		public abstract String toString();
	}

	static public class Print extends Instruction {
		String toPrint;
		public Print(String p) {
			this.toPrint = p;
		}
		
		public String toString() {
			return "call i32 (i8* , ...) @printf(" + toPrint + ")\n";
		}
	}
	
	static public class Read extends Instruction {
		String toRead;
		public Read(String r) {
			this.toRead = r;
		}
		
		public String toString() {
			
			return "call i32 (i8* , ...) @scanf(" + toRead + ")\n";
		}
	}
	
	static public class Return extends Instruction {
		Type type;
		String value;

		public Return(Type type, String value) {
			this.type = type;
			this.value = value;
		}

		public String toString() {
			return "ret " + type + " " + value + "\n";
		}
	}

	static public class GlobalString extends Instruction {
		String name;
		LLVMStringConstant format;

		public GlobalString(String name, String value) {
			this.name = name;
			this.format = Utils.stringTransform(value);
		}

		public int length() {
			return format.length;
		}
		
		public String toString() {
			return name + " = global [ " + format.length + " x i8 ] c\"" + format.str + "\"\n";
		}
	}
	
	static public class Add extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public Add(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = add " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class Mul extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public Mul(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = mul " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class Sub extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public Sub(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = sub " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class Div extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public Div(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = udiv " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class Mod extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public Mod(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = urem " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class No extends Instruction {
		Type type;
		String value, result;

		public No(Type type, String value, String result) {
			this.type = type;
			this.value = value;
			this.result = result;
		}

		public String toString() {
			return result + " xor " + type + " " + value + ", 1\n";
		}
	}

	static public class And extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public And(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = and " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class Or extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public Or(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = or " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class Eq extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public Eq(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = eq " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class Inf extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public Inf(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = slt " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class InfEq extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public InfEq(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = sle " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class Sup extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public Sup(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = sgt " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class SupEq extends Instruction {
		Type type;
		String left;
		String right;
		String lvalue;

		public SupEq(Type type, String left, String right, String lvalue) {
			this.type = type;
			this.left = left;
			this.right = right;
			this.lvalue = lvalue;
		}

		public String toString() {
			return lvalue + " = sge " + type + " " + left + ", " + right + "\n";
		}
	}

	static public class CompareToZero extends Instruction {
		String comparison, compared;
		Type type;

		public CompareToZero(String place_comp, String operand, Type type) {
			comparison = place_comp;
			compared = operand;
			this.type = type;
		}

		@Override
		public String toString() {
			return comparison + " = icmp ne " + type.toString() + ' ' + compared + ", 0\n";
		}

	}
	
	static public class GetElem extends Instruction {
		String var_name;
		String type;
		String place;
		String index;

		public GetElem(String type, String var_name, String place, String index) {
			this.var_name = var_name;
			this.type = type;
			this.place = place;
			this.index = index;
		}

		public String toString() {
			// %tmp = getelementptr
			return place + " = getelementptr " + type + ", " + type + "* " + var_name 
					+ ", i64 0, i32 " + index + "\n";
		}
	}

	static public class GetPtr extends Instruction {
		String var_name;
		String type;
		String place;
		String index;

		public GetPtr(String type, String var_name, String place, String index) {
			this.var_name = var_name;
			this.type = type;
			this.place = place;
			this.index = index;
		}

		public String toString() {
			// %tmp = getelementptr
			return place + " = getelementptr " + type + ", " + type + "* " + var_name 
					+ ", i32 " + index + "\n";
		}
	}

	static public class Load extends Instruction {
		String var_name;
		Type type;
		String place;

		public Load(Type type, String var_name, String place) {
			this.var_name = var_name;
			this.type = type;
			this.place = place;
		}

		public String toString() {
			// %tmp = load i32, i32* var_name
			return place + " = load " + type + ", " + type + "* " + var_name + "\n";
		}
	}

	static public class Assign extends Instruction {
		String var_name;
		String type;
		String value;

		public Assign(String var_name, String type, String expr) {
			this.var_name = var_name;
			this.type = type;
			this.value = expr;
		}

		public String toString() {
			// store i32 0, i32∗ %i
			return "store " + type + " " + value + ", " + type + "* " + var_name + "\n";
		}
	}

	static public class Call extends Instruction {
		String var_name;
		String type;
		List<String> args;
		String place;

		public Call(String var_name, String type, List<String> args, String place) {
			this.var_name = var_name;
			this.type = type;
			this.args = args;
			this.place = place;
		}

		public String toString() {
			String affectat = "";
			if (place != null) {
				affectat = place + " = ";
			}
			
			String arguments = "(";
			int i = 0;
			if (args != null)
				for (String arg : args)
					if (i++ == 0)
						arguments += arg;
					else
						arguments += ", " + arg;
				
			arguments += ")";

			return affectat + "call " + type + " " + var_name + arguments + "\n";
		}
	}

	static public class Declare extends Instruction {
		String type;
		String name;

		public Declare(String type, String name) {
			this.name = name;
			this.type = type;
		}

		@Override
		public String toString() {
			return name + " = alloca " + type + "\n";
			
		}

	}

	static public class BrIncond extends Instruction {
		String label;

		public BrIncond(String label) {
			this.label = label;
		}

		@Override
		public String toString() {
			return "br label %" + label + "\n";
		}

	}

	static public class BrCond extends Instruction {
		String cond;
		String label1;
		String label2;

		public BrCond(String place_cond, String l1, String l2) {
			this.cond = place_cond;
			this.label1 = l1;
			this.label2 = l2;
		}

		@Override
		public String toString() {
			return "br i1 " + cond + ", label %" + label1 + ", label %" + label2 + "\n";
		}

	}

	static public class Label extends Instruction {
		String name;

		public Label(String name) {
			this.name = name;
		}

		@Override
		public String toString() {
			return name + ":\n";
		}

	}

	static public class Bloc extends Instruction {
		IR instructions;

		public Bloc(IR ir) {
			this.instructions = ir;
		}

		@Override
		public String toString() {
			StringBuilder r = new StringBuilder();
			for (Instruction inst : instructions.header)
				r.append(inst);
			for (Instruction inst : instructions.code)
				r.append(inst);

			return r.toString();
		}

	}

	static public class Func extends Instruction {
		Type type;
		String name;
		String args;

		public Func(Type t, String n, String a) {
			this.type = t;
			this.name = n;
			this.args = a;
		}

		@Override
		public String toString() {
			return "define " + type.toString() + " " + name + "(" + args + ") {\n";
		}

	}
	
	static public class FuncEnd extends Instruction {

		@Override
		public String toString() {
			return "}\n\n\n";
		}

	}

}