package TP2.ASD.expressions;

import TP2.Llvm;
import TP2.ASD.types.Type;
import TP2.exceptions.TypeException;
import TP2.exceptions.UndeclaredSymbolException;

public abstract class Expression {
    public abstract String pp();
    public abstract Expression.RetExpression toIR() throws TypeException, UndeclaredSymbolException;

    // Object returned by toIR on expressions, with IR + synthesized attributes
    static public class RetExpression {
      // The LLVM IR:
      public Llvm.IR ir;
      // And additional stuff:
      public Type type; // The type of the expression
      public String result; // The name containing the expression's result
      // (either an identifier, or an immediate value)

      public RetExpression(Llvm.IR ir, Type type, String result) {
        this.ir = ir;
        this.type = type;
        this.result = result;
      }
    }
  }