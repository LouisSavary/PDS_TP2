package TP2.ASD.types;

import TP2.Llvm;

public class IntArray extends Type {
	private int size;
    public String pp() {
      return "INT[" + size + "]";
    }

    @Override public boolean equals(Object obj) {
      return obj instanceof IntArray;
    }

    public Llvm.Type toLlvmType() {
      return new Llvm.IntArray();
    }
  }