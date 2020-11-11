package TP2.ASD.types;

import TP2.Llvm;

// Warning: this is the type from VSL+, not the LLVM types!
  public abstract class Type {
    public abstract String pp();
    public abstract Llvm.Type toLlvmType();
    public static Type getType(String type_name) {
    	
    	if (type_name.equals(new Int().pp()))
    		return new Int();
    	else 
    		return null;
    }
  }