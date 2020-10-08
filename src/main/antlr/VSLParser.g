parser grammar VSLParser;

options {
  language = Java;
  tokenVocab = VSLLexer;
}

@header {
  package TP2;

  import java.util.stream.Collectors;
  import java.util.Arrays;
}


// TODO : other rules

program returns [TP2.ASD.Program out]
    : e=expression EOF { $out = new TP2.ASD.Program($e.out); } // TODO : change when you extend the language
    ;

expression returns [TP2.ASD.Expression out]
    : l=factor PLUS  r=expression  { $out = new TP2.ASD.AddExpression($l.out, $r.out); }
    | l=factor MINUS r=expression  { $out = new TP2.ASD.SubExpression($l.out, $r.out); }
    | f=factor { $out = $f.out; }
    // TODO : that's all?
    ;

factor returns [TP2.ASD.Expression out]
    : p=primary { $out = $p.out; }
    | l=primary MODUL r=factor  { $out = new TP2.ASD.ModExpression($l.out, $r.out); }
    | l=primary TIMES r=factor  { $out = new TP2.ASD.MulExpression($l.out, $r.out); }
    | l=primary DIVID r=factor  { $out = new TP2.ASD.DivExpression($l.out, $r.out); }
    // TODO : that's all?
    ;

primary returns [TP2.ASD.Expression out]
    : INTEGER 	{ $out = new TP2.ASD.IntegerExpression($INTEGER.int); }
 //   | INDENT 	{ $out = new TP2.ASD. ??? }
    | LP e=expression RP { $out = $e.out; }
    // TODO : that's all?
    ;
