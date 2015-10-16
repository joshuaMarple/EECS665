%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <parser.yacc.h>

#ifndef NDEBUG
#   define DEBUGF(...) printf(__VA_ARGS__)
#else
#   define DEBUGF(...)
#endif
%}

%option noyywrap nounput yylineno
%x COMMENT
WHITESPACE [ \t\n\r]
ident [a-zA-Z][a-zA-Z0-9_]*
digit         [0-9]
hexdigit      [0-9a-fA-F]
octdigit      [0-7]

%%



\' {
}

"("         { DEBUGF( "(\n" ); return '('; }
")"         { DEBUGF( ")\n" ); return ')'; }
"{"         { DEBUGF( "{\n" ); return '{'; }
"}"         { DEBUGF( "}\n" ); return '}'; }
"["         { DEBUGF( "[\n" ); return '['; }
"]"         { DEBUGF( "]\n" ); return ']'; }
","         { DEBUGF( ",\n" ); return ','; }
";"         { DEBUGF( ";\n" ); return ';'; }

[0-9]*[.][0-9]+ {

    printf("DBLVAL");
    return DBLVAL;
}

[0-9]*[.][0-9]*"f" {

    printf("FLTVAL");
    return FLTVAL;
}

"'"(\\)?."'" {

    printf("CHARVAL");
    return CHARVAL;
}

"\"".*"\"" {

    printf("STRVAL");
    return STRVAL;
}

"void" {

    printf("VOID");
    return VOID;
}

"short" {

    printf("SHORT");
    return SHORT;
}

"long" {

    printf("LONG");
    return LONG;
}

"double" {

    printf("DOUBLE");
    return DOUBLE;
}

"char" {

    printf("CHAR");
    return CHAR;
}

"int" {

    printf("INT");
    return INT;
}

"float" {

    printf("FLOAT");
    return FLOAT;
}

"==" {

    printf("EQ");
    return EQ;
}

"<=" {

    printf("LE");
    return LE;
}

"+" {

    printf("ADD");
    return ADD;
}

"/" {

    printf("DIV");
    return DIV;
}

"&&" {

    printf("AND");
    return AND;
}

"^" {


    printf("BITXOR");
    return BITXOR;
}

"<<" {

    printf("LSH");
    return LSH;
}

"+=" {

    printf("SETADD");
    return SETADD;
}

"/=" {

    printf("SETDIV");
    return SETDIV;
}

"&=" {

    printf("SETAND");
    return SETAND;
}

">>=" {

    printf("SETRSH");
    return SETRSH;
}

"!=" {

    printf("NE");
    return NE;
}

">" {

    printf("GT");
    return GT;
}

"-" {

    printf("SUB");
    return SUB;
}

"%" {

    printf("MOD");
    return MOD;
}

"|" {

    printf("BITOR");
    return BITOR;
}

"!" {

    printf("NOT");
    return NOT;
}

">>" {

    printf("RSH");
    return RSH;
}

"-=" {

    printf("SETSUB");
    return SETSUB;
}

"%=" {

    printf("SETMOD");
    return SETMOD;
}

"^=" {

    printf("SETXOR");
    return SETXOR;
}

">=" {

    printf("GE");
    return GE;
}

"<" {

    printf("LT");
    return LT;
}

"*" {

    printf("MUL");
    return MUL;
}

"||" {

    printf("OR");
    return OR;
}

"&" {

    printf("BITAND");
    return BITAND;
}

"~" {

    printf("COM");
    return COM;
}

"=" {

    printf("SET");
    return SET;
}

"*=" {

    printf("SETMUL");
    return SETMUL;
}

"|=" {

    printf("SETOR");
    return SETOR;
}

"<<=" {

    printf("SETLSH");
    return SETLSH;
}

"return" {

    printf("RETURN");
    return RETURN;
}

"while" {

    printf("WHILE");
    return WHILE;
}

"switch" {

    printf("SWITCH");
    return SWITCH;
}

"default" {

    printf("DEFAULT");
    return DEFAULT;
}

"else" {

    printf("ELSE");
    return ELSE;
}

"break" {

    printf("BREAK");
    return BREAK;
}

"do" {

    printf("DO");
    return DO;
}

"for" {

    printf("FOR");
    return FOR;
}

"case" {

    printf("CASE");
    return CASE;
}

"if" {

    printf("IF");
    return IF;
}

"continue" {

    printf("CONTINUE");
    return CONTINUE;
}

"goto" {

    printf("GOTO");
    return GOTO;
}

"unsigned" {

    printf("UNSIGNED");
    return UNSIGNED;
}

"struct" {

    printf("STRUCT");
    return STRUCT;
}

"const" {

    printf("CONST");
    return CONST;
}

"extern" {

    printf("EXTERN");
    return EXTERN;
}

"register" {

    printf("REGISTER");
    return REGISTER;
}

"typedef" {

    printf("TYPEDEF");
    return TYPEDEF;
}

"union" {

    printf("UNION");
    return UNION;
}

"static" {

    printf("STATIC");
    return STATIC;
}

"auto" {

    printf("AUTO");
    return AUTO;
}

"sizeof" {

    printf("SIZEOF");
    return SIZEOF;
}

{ident} { DEBUGF( "ID\n" ); yylval.id = strdup(yytext); return ID; }

%{ 
 /**************************************************************************
  * Scan C literal values including strings, character literals, integer
  * literals, and floating point literals.
  *************************************************************************/
%}

"0x"{hexdigit}+ { DEBUGF( "INTVAL\n" ); return INTVAL; }
"0"{octdigit}*  { DEBUGF( "INTVAL\n" ); return INTVAL; }
[1-9]{digit}*   { DEBUGF( "INTVAL\n" ); return INTVAL; }

%{
 /**************************************************************************
  * Scan a multi-line C comment using left context or a C single line
  * comment to the end of the line.
  *************************************************************************/
%}

"//".*                      { /* ignored */ }

"/*"                        { BEGIN COMMENT; }
<COMMENT>"*/"               { BEGIN 0; }
<COMMENT>([\n](\r)?)|.      { /* ignored */ } 

%{
 /**************************************************************************
  * Scan white space in-between tokens and ignore it.
  *************************************************************************/
%}

{WHITESPACE}+ { /* ignored */  }

%{
 /**************************************************************************
  * Anything else that matches is unexpected so print an error.
  *************************************************************************/
%}



. {
    fprintf( stderr, "Unexpected input at line %d: '%s'\n", yylineno, yytext );
    exit( 1 );
}
%%
