package TP2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import TP2.ASD.types.Type;

// This file contains the symbol table definition.
// A symbol table contains a set of ident and the
// corresponding symbols.
// It can have a parent, containing itself other
// symbols. If a symbol is not found, the request
// is forwarded to the parent.

public class SymbolTable {
  // Define different symbols
  public static abstract class Symbol {
    public String 	ident; // minimum, used in the storage map
    public Type 	type;
  }

  public static class VariableSymbol extends Symbol {

    public VariableSymbol(Type type, String ident) {
      this.type = type;
      this.ident = ident;
    }

    @Override public boolean equals(Object obj) {
      if(obj == null) return false;
      if(obj == this) return true;
      if(!(obj instanceof VariableSymbol)) return false;
      VariableSymbol o = (VariableSymbol) obj;
      return o.type.equals(this.type) &&
        o.ident.equals(this.ident);
    }
  }

  public static class FunctionSymbol extends Symbol {
    public List<VariableSymbol> arguments; // arguments is an ordered list of VariableSymbol
    boolean defined; // false if declared but not defined

    public FunctionSymbol(Type returnType, String ident, List<VariableSymbol> arguments, boolean defined) {
      this.type = returnType;
      this.ident = ident;
      this.arguments = arguments;
      this.defined = defined;
    }

    @Override public boolean equals(Object obj) {
      if(obj == null) return false;
      if(obj == this) return true;
      if(!(obj instanceof FunctionSymbol)) return false;
      FunctionSymbol o = (FunctionSymbol) obj;
      return o.type.equals(this.type) &&
        o.ident.equals(this.ident) &&
        o.arguments.equals(this.arguments) &&
        o.defined == this.defined;
    }
    
  }

  // Store the table as a map
  private Map<String, Symbol> table;
  // Parent table
  private SymbolTable parent;
  
  // Construct a new symbol table
  public SymbolTable() {
    this.table = new HashMap<String, Symbol>();
    this.parent = null;
  }

  // Construct a new symbol table with a parent
  public SymbolTable(SymbolTable parent) {
    this.table = new HashMap<String, Symbol>();
    this.parent = parent;
  }

  // Add a new symbol
  // Returns false if the symbol cannot be added (already in the scope)
  public boolean add(Symbol sym) {
    Symbol res = this.table.get(sym.ident);
    if(res != null) {
      return false;
    }
    
    String key = sym.ident;
    
    // guarantees the uniqueness of the variable names between blocs 
    sym.ident += this.hashCode();
    
    sym.ident = (sym instanceof FunctionSymbol? "@":"%") + sym.ident;
    this.table.put(key, sym);
    return true;
  }

  // Remove a symbol
  // Returns false if the symbol is not in the table (without looking at parent's)
  public boolean remove(String ident) {
    return this.table.remove(ident) != null;
  }

  public Symbol lookup(String ident) {
    Symbol res = this.table.get(ident);

    if((res == null) && (this.parent != null)) {
      // Forward request
      return this.parent.lookup(ident);
    }

    return res; // Either the symbol or null
  }

  @Override public boolean equals(Object obj) {
    if(obj == null) return false;
    if(obj == this) return true;
    if(!(obj instanceof SymbolTable)) return false;
    SymbolTable o = (SymbolTable) obj;
    return o.table.equals(this.table) &&
      ((o.parent == null && this.parent == null) || o.parent.equals(this.parent));
  }
}
