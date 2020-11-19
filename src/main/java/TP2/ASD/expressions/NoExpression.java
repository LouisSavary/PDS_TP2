package TP2.ASD.expressions;

import TP2.Llvm;
import TP2.Utils;
import TP2.ASD.types.Bool;
import TP2.exceptions.TypeException;

// Concrete class for Expression: add case
  public class NoExpression extends Expression {
    Expression right;

    public NoExpression(Expression right) {
      this.right = right;
    }

    // Pretty-printer
    public String pp() {
      return " !" + right.pp() ;
    }

    // IR generation
    public RetExpression toIR() throws TypeException {
      RetExpression rightRet = right.toIR();

      // We check if the types mismatches
      if( !rightRet.type.equals(new Bool())) {
        throw new TypeException("type mismatch: cannot negate non boolean " + right.pp());
      }

      // allocate a new identifier for the result
      String result = Utils.newtmp();

      // new add instruction result = left + right
      Llvm.Instruction eq = new Llvm.No(rightRet.type.toLlvmType(), rightRet.result, result);

      // append this instruction
      rightRet.ir.appendCode(eq);

      // return the generated IR, plus the type of this expression
      // and where to find its result
      return new RetExpression(rightRet.ir, new Bool(), result);
    }
  }