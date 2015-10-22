// The name of the grammar. The name here needs to match the name of the
// file, including capitalization.
grammar Lab6;

// Define literals, keywords or operators, here as tokens.
tokens {
	Add = '+';
	Sub = '-';
	Mul = '*'; 
	Div = '/';
	Exp = '^';
}

// Written in the target language. The header section can be
// used to import any Java classes that may be required.
@header {
}

// A main function to the parser. This function will setup the
// parsers input stream and execute the rule named "top".
@members {
    public static void main(String[] args) throws Exception {
        Lab6Lexer lex = new Lab6Lexer(new ANTLRInputStream(System.in));
       	CommonTokenStream tokens = new CommonTokenStream(lex);
        Lab6Parser parser = new Lab6Parser(tokens);

        try {
            parser.top();
        } catch (RecognitionException e)  {
            e.printStackTrace();
        }
    }
}

// Some example lexer fragments. These fragments don't produce any
// tokens themselves but can be used inside of other lexer rules.
fragment BIN: '0' .. '1';
/* fragment OCT: '0' .. '7'; */
fragment DEC: '0' .. '9';
fragment HEX: ('0' .. '9' | 'A' .. 'F' | 'a' .. 'f');
fragment LETTER: ('a'..'z' | 'A'..'Z');
fragment DIGIT: '0'..'9';

// The white space lexer rule. Match any number of white space characters
// and hide the results from the parser.
WS : (' ' | '\t' | '\r' | '\n')+ { $channel=HIDDEN; };

// The decimal value lexer rule. Match one or more decimal digits.
DECIMAL : DEC+ ;
HEXADECIMAL : '0' 'x' HEX+;
BINARY : '0' 'b' BIN+;
/* OCTAL : OCT+; */

ID : LETTER (LETTER|DIGIT)*;


// The top rule. You should replace this with your own rule definition to
// parse expressions according to the assignment.
top : expr EOF;

expr: val=term1 {System.out.println($val.value);};

term1 returns [float value]:
    l = term2 { $value = $l.value; }
    (Add r = term2 { $value += $r.value; }
    |Sub r = term2 { $value -= $r.value; })*;

term2 returns [float value]:
    l = term3 { $value = $l.value; }
    (Mul r = term3 { $value *= $r.value; }
    |Div r = term3 { $value /= $r.value; })*;

term3 returns [float value]:
    l = term4 { $value = $l.value; }
    (Exp r = term4 { $value = (float)Math.pow($l.value, $r.value); })*;

term4 returns [float value]:
    l = digit { $value = $l.value; };

digit returns [float value]:
    n = DECIMAL { $value = Float.parseFloat($n.text);};
