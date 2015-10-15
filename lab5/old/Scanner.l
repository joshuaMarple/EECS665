%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <parser.yacc.h>

int list_type;
%}

%option       noyywrap nounput yylineno
%x            COMMENT

%%

"/*" {BEGIN COMMENT;}
<COMMENT>.|\n {}
<COMMENT>"*/" {BEGIN 0;}
"//"[^\n]*"\n" {}
[ \t\n\r]+ {}
"#"[^\n]*"\n" {
	return PREPROC;
}
"(" {
	return '(';
}
"{" {
	return '{';
}
"[" {
	return '[';
}
"," {
	return ',';
}
")" {
	return ')';
}
"}" {
	return '}';
}
"]" {
	return ']';
}
";" {
	return ';';
}
[0-9][.][0-9] {
	return DBLVAL;
}
"\'"[^\']*"\'" {
	return CHARVAL;
}
[0-9][.][0-9]"f" {
	return FLTVAL;
}
"\""[^\"]*"\"" {
	return STRVAL;
}
"void" {
	return VOID;
}
"short" {
	return SHORT;
}
"long" {
	return LONG;
}
"double" {
	return DOUBLE;
}
"char" {
	return CHAR;
}
"int" {
	return INT;
}
"float" {
	return FLOAT;
}
"==" {
	return EQ;
}
"<=" {
	return LE;
}
"+" {
	return ADD;
}
"/" {
	return DIV;
}
"&&" {
	return AND;
}
"^" {
	return BITXOR;
}
"<<" {
	return LSH;
}
"+=" {
	return SETADD;
}
"/=" {
	return SETDIV;
}
"&=" {
	return SETAND;
}
">>=" {
	return SETRSH;
}
"!=" {
	return NE;
}
">" {
	return GT;
}
"-" {
	return SUB;
}
"%" {
	return MOD;
}
"|" {
	return BITOR;
}
"!" {
	return NOT;
}
">>" {
	return RSH;
}
"-=" {
	return SETSUB;
}
"%=" {
	return SETMOD;
}
"^=" {
	return SETXOR;
}
">=" {
	return GE;
}
"<" {
	return LT;
}
"*" {
	return MUL;
}
"||" {
	return OR;
}
"&" {
	return BITAND;
}
"~" {
	return COM;
}
"=" {
	return SET;
}
"*=" {
	return SETMUL;
}
"|=" {
	return SETOR;
}
"<<=" {
	return SETLSH;
}
"return" {
	return RETURN;
}
"while" {
	return WHILE;
}
"switch" {
	return SWITCH;
}
"default" {
	return DEFAULT;
}
"else" {
	return ELSE;
}
"break" {
	return BREAK;
}
"do" {
	return DO;
}
"for" {
	return FOR;
}
"case" {
	return CASE;
}
"if" {
	return IF;
}
"continue" {
	return CONTINUE;
}
"goto" {
	return GOTO;
}
"unsigned" {
	return UNSIGNED;
}
"struct" {
	return STRUCT;
}
"const" {
	return CONST;
}
"extern" {
	return EXTERN;
}
"register" {
	return REGISTER;
}
"typedef" {
	return TYPEDEF;
}
"union" {
	return UNION;
}
"static" {
	return STATIC;
}
"auto" {
	return AUTO;
}
"sizeof" {
	return SIZEOF;
}
[a-zA-Z][a-zA-Z0-9_]* {
	yylval.id = strdup(yytext);
	return ID;
}
[1-9][0-9]* {
	return INTVAL;
}
"0"[0-7]* {
	return INTVAL;
}
"0x"[0-9a-fA-F]+ {
	return INTVAL;
}
