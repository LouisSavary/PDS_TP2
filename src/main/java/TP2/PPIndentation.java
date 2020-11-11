package TP2;

public class PPIndentation {
	private static StringBuffer indent= new StringBuffer();
	
	public static String getIndent(int decal) {

		if(decal < 0)
			unindent();
		String ret = indent.toString();
		if(decal > 0)
			indent();
		return ret;
	}
	
	public static String getIndent() {
	
		return indent.toString();
	
	}
	
	public static void indent() {
		indent.append('\t');
	}
	public static void unindent() {
		if (indent.length() > 0)
			indent.deleteCharAt(0);
	}
}
