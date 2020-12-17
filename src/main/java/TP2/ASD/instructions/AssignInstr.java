package TP2.ASD.instructions;

import TP2.Llvm;
import TP2.Llvm.IR;
import TP2.PPIndentation;
import TP2.SymbolTable;
import TP2.SymbolTable.Symbol;
import TP2.Utils;
import TP2.ASD.expressions.Expression;
import TP2.ASD.expressions.Expression.RetExpression;
import TP2.ASD.types.Bool;
import TP2.ASD.types.Int;
import TP2.ASD.types.IntArray;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public class AssignInstr extends Instruction {

	private String symbol;
	private Expression expr;
	private SymbolTable symbolTable;
	private Expression index;
	
	public AssignInstr(String symbol, Expression expr, SymbolTable st, Expression i){
		this.symbol = symbol;
		this.expr = expr;
		this.symbolTable = st;
		this.index = i;
	}
	
	
	@Override
	public IR toIR() throws TypeException, UndeclaredSymbolException{
		
		Symbol var = symbolTable.lookup(symbol);
		RetExpression exprRet = expr.toIR();
		
		if (var == null)
			throw(new UndeclaredSymbolException("undeclared symbol : " + symbol + " in : " + this.pp()));
		if (!var.type.equals(new IntArray()) && index != null)
			throw new TypeException("Cannot index in non-array variable : " + symbol);
		
		
		if (var.type.equals(new IntArray()) && exprRet.type.equals(new Int())) {
			RetExpression indexRet = null;
			if (index != null ) indexRet = index.toIR();
			else throw new TypeException("can't affect in array without position index");
			
			if (!indexRet.type.equals(new Int()))
				throw new TypeException("can't index an array with a non-integer position");
			exprRet.ir.append(indexRet.ir);
			
			String elemPtr = Utils.newtmp();
			exprRet.ir.appendCode(new Llvm.GetPtr((new Int()).toLlvmType().toString(), var.ident, elemPtr, indexRet.result));
			
			exprRet.ir.appendCode(new Llvm.Assign(elemPtr,	exprRet.type.toLlvmType().toString(), exprRet.result));
		} else if (var.type.equals(new Bool()) && exprRet.type.equals(new Int())){
			// then cast from int to bool
			String boolvalue = Utils.newtmp();
			exprRet.ir.appendCode(new Llvm.CompareToZero(boolvalue, exprRet.result, exprRet.type.toLlvmType()));
			exprRet.ir.appendCode(new Llvm.Assign(var.ident, var.type.toLlvmType().toString(), boolvalue));
		} else {
			if (!  exprRet.type.equals(var.type) )
				throw(new TypeException("type mismatch in assignement : " + this.pp()));
			
			Llvm.Instruction assignement = new Llvm.Assign(var.ident, exprRet.type.toLlvmType().toString(), exprRet.result);
			exprRet.ir.appendCode(assignement);
			
		}
		return exprRet.ir;
	}

	@Override
	public String pp() {
		if (index == null)
			return PPIndentation.getIndent() + symbol + " := " + expr.pp() + "\n";
		else 
			return PPIndentation.getIndent() + symbol + "[" + index.pp() + "] := " + expr.pp() + "\n";
	}

}
