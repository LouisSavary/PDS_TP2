package TP2.ASD.expressions;

import TP2.Llvm;
import TP2.Utils;
import TP2.ASD.types.Bool;
import TP2.ASD.types.Int;
import TP2.exceptions.TypeException;

// Concrete class for Expression: add case
  public class SupEqExpression extends Expression {
    Expression left;
    Expression right;

    public SupEqExpression(Expression left, Expression right) {
      this.left = left;
      this.right = right;
    }

    // Pretty-printer
    public String pp() {
      return "(" + left.pp() + " >= " + right.pp() + ")";
    }

    // IR generation
    public RetExpression toIR() throws TypeException {
      RetExpression leftRet = left.toIR();
      RetExpression rightRet = right.toIR();

      // We check if the types mismatches
      if(!leftRet.type.equals(rightRet.type) || !leftRet.type.equals(new Int())) {
        throw new TypeException("type mismatch: have " + leftRet.type + " and " + rightRet.type);
      }

      // We base our build on the left generated IR:
      // append right code
      leftRet.ir.append(rightRet.ir);

      // allocate a new identifier for the result
      String result = Utils.newtmp();

      // new add instruction result = left + right
      Llvm.Instruction eq = new Llvm.SupEq(leftRet.type.toLlvmType(), leftRet.result, rightRet.result, result);

      // append this instruction
      leftRet.ir.appendCode(eq);

      // return the generated IR, plus the type of this expression
      // and where to find its result
      return new RetExpression(leftRet.ir, new Bool(), result);
    }
  }