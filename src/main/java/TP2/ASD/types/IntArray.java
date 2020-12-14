package TP2.ASD.types;

import TP2.Llvm;

public class IntArray extends Type {
	public int size;

	public IntArray(int size) {
		this.size = size;
	}
	public IntArray() {
		this(0);
	}

	public String pp() {
		//ne devrait jamais etre afficher tel quel
		//servira seulement à identifier un type avec Type.typeof("INT[]")
		
		return "INTARRAY";
		
		//return "INT[" + size + "]";
	}

	@Override
	public boolean equals(Object obj) {
		// la comparaison du type devrait suffire
		// ca ne sera jamais à nous de verifier que la taille du tableau est la bonne
		return obj instanceof IntArray;
	}

	public Llvm.Type toLlvmType() {
		return new Llvm.IntArray(size);
	}
}