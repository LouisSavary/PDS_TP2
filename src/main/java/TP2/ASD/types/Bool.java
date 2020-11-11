package TP2.ASD.types;

import TP2.Llvm;

public class Bool extends Type {
    public String pp() {
      return "BOOL";
    }

    @Override public boolean equals(Object obj) {
      return obj instanceof Bool;
    }

    public Llvm.Type toLlvmType() {
      return new Llvm.Bool();
    }
  }