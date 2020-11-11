package TP2;

import java.util.List;

import java.util.ArrayList;

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
			StringBuilder r = new StringBuilder("; Target\n" + "target triple = \"x86_64-unknown-linux-gnu\"\n"
					+ "; External declaration of the printf function\n"
					+ "declare i32 @printf(i8* noalias nocapture, ...)\n" + "\n; Actual code begins\n\n");

			for (Instruction inst : header)
				r.append(inst);

			r.append("\n\n");

			// We create the function main
			// TODO : remove this when you extend the language
			r.append("define i32 @main() {\n");

			for (Instruction inst : code)
				r.append(inst);

			// TODO : remove this when you extend the language
			r.append("}\n");

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

	// TODO : other types

	// LLVM IR Instructions
	static public abstract class Instruction {
		public abstract String toString();
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

	// TODO : other instructions
	static public class Assign extends Instruction {
		String var_name;
		Type type;
		String value;

		public Assign(String var_name, Type type, String expr) {
			this.var_name = var_name;
			this.type = type;
			this.value = expr;
		}

		public String toString() {
			// store i32 0, i32∗ %i
			return "store " + type + " " + value + ", " + type + "* " + var_name + "\n";
		}
	}

	static public class Ident extends Instruction {
		String var_name;
		Type type;
		List<String> args;

		public Ident(String var_name, Type type, List<String> args) {
			this.var_name = var_name;
			this.type = type;
			this.args = args;
		}

		public String toString() {
			if (args == null)
				return "";
			//TODO les fonx
			return type + " %" + var_name;
		}
	}

	static public class Declare extends Instruction {
		Type type;
		String name;
		int size;

		public Declare(Type type, String name, int size) {
			this.name = name;
			this.type = type;
			this.size = size;
		}

		@Override
		public String toString() {
			// TODO Auto-generated method stub
			if (size == 1)
				return name + " = alloca " + type + "\n";
			else {
				return name + " = alloca [" + size + " x " + type + "]" + "\n";
			}
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
		IR statement;

		public Bloc(IR ir) {
			this.statement = ir;
		}

		@Override
		public String toString() {
			return statement.toString();
		}

	}

}
