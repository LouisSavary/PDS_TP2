package TP2.ASD.types;

import TP2.Llvm;

  public abstract class Type {
    public abstract String pp();
    public abstract Llvm.Type toLlvmType();
    public static Type getType(String type_name) {
    	
    	if (type_name.equals(new Int().pp()))
    		return new Int();
    	else if (type_name.equals(new Bool().pp()))
			return new Bool();
		else if (type_name.equals(new Void().pp()))
    		return new Void();
		else if (type_name.equals(new IntArray(0).pp()))
    		return new IntArray();
		else 
			return null;
    }
  }