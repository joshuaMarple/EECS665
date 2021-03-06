%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylineno;
int yydebug = 1;
char* lastFunction = "";
extern void yyerror( char* );
extern int yylex();
%}

/*********************************************************
 ********************************************************/
%union {
    char* id;
}

%token <id> ID
%token INTVAL DBLVAL CHARVAL FLTVAL STRVAL VOID SHORT LONG DOUBLE CHAR INT FLOAT EQ LE ADD DIV AND BITXOR LSH SETADD SETDIV SETAND SETRSH NE GT SUB MOD BITOR NOT RSH SETSUB SETMOD SETXOR GE LT MUL OR BITAND COM SET SETMUL SETOR SETLSH RETURN WHILE SWITCH DEFAULT ELSE BREAK DO FOR CASE IF CONTINUE GOTO UNSIGNED STRUCT CONST EXTERN REGISTER TYPEDEF UNION STATIC AUTO SIZEOF

%start top

%%

/*********************************************************
 * The top level parsing rule, as set using the %start
 * directive above.
 ********************************************************/
top :
    |function top


/*This rule matches a  function in C Program*/
function : func_signature '{' func_body '}'

/*This rule matches a function signature such as int main( int argc, char *argv[] )*/
func_signature : type ID '(' args ')' { printf("%s", $2); printf(";\n"); lastFunction = $2;}


args :
     | expression
     | expression ',' args

/*********************************************************
 * An example rule used to parse a single expressionession.
 * Currently this rule parses only an integer value
 * but you should modify the rule to parse the required
 * expressionessions.
 ********************************************************/
expression : type ID
           | type MUL ID
           | type MUL ID '[' ']'

func_body : declaration
          | statement
          | declaration func_body
          | statement func_body

declaration  : type ID ';'

statement : match
          | unmatched

match : IF '(' op ')' match ELSE match
      | misc
      | WHILE '(' op ')' match
      | '{' matches '}'

matches  : matches match
         | match

misc : ID SET op ';'
     | RETURN op ';'
     | RETURN func_signature ';'
     | ID '(' expressionl ')' ';' { printf( "%s -> %s;\n", lastFunction, $1); }

unmatched : IF '(' op ')' match ELSE unmatched
          | IF '(' op ')' statement
          | WHILE '(' op ')' unmatched
          | '{' unmatches '}'

unmatches : unmatches unmatched
          | unmatched

op  : op DIV level1
    | op MUL level1
    | op MOD level1
    | level1

level1 : level1 ADD level2
       | level1 SUB level2
       | level2

level2 : level2 LT level3
       | level2 LE level3
       | level2 GT level3
       | level2 GE level3
       | level2 LSH level3
       | level2 RSH level3
       | level3

level3 : level3 EQ level4
       | level3 NE level4
	   | level4

level4 : level4 BITAND level5
       | level5

level5 : level5 BITXOR level6
       | level6

level6 : level6 BITOR level7
	   | level7

level7 : INTVAL
	   | STRVAL
       | CHARVAL
       | DBLVAL
       | FLTVAL
       | ID '(' expressionl ')' { printf("%s -> %s;\n", lastFunction, $1); }
       | ID

expressionl :
            | op ',' expressionl
            | op

type : VOID
     | CHAR
     | SHORT
     | INT
     | LONG
     | FLOAT
     | DOUBLE

%%

/*********************************************************
 * This method is invoked by the parser whenever an
 * error is encountered during parsing; just print
 * the error to stderr.
 ********************************************************/
void yyerror( char *err ) {
    fprintf( stderr, "at line %d: %s\n", yylineno, err );
}

/*********************************************************
 * This is the main function for the function call
 * graph program. We invoke the parser and return the
 * error/success code generated by it.
 ********************************************************/
int main( int argc, const char *argv[] ) {
    printf( "digraph funcgraph {\n" );
    int res = yyparse();
    printf( "}\n" );
    return res;
}
