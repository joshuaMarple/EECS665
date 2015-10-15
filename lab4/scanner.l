%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//Define the tokens that you want to return from your lex as follows
#define ID 256
#define INTVAL 257
#define PREPROC 258
#define DBLVAL 259
#define CHARVAL 260
#define FLTVAL 261
#define STRVAL 262
#define VOID 263
#define SHORT 264
#define LONG 265
#define DOUBLE 266
#define CHAR 267
#define INT 268
#define FLOAT 269
#define EQ 270
#define LE 271
#define ADD 271
#define DIV 273
#define AND 274
#define BITXOR 275
#define LSH 276
#define SETADD 277
#define SETDIV 278
#define SETAND 279
#define SETRSH 280
#define NE 281
#define GT 282
#define SUB 283
#define MOD 284
#define BITOR 285
#define NOT 286
#define RSH 287
#define SETSUB 288
#define SETMOD 289
#define SETXOR 290
#define GE 291
#define LT 292
#define MUL 293
#define OR 294
#define BITAND 295
#define COM 296
#define SET 297
#define SETMUL 298
#define SETOR 299
#define SETLSH 300
#define RETURN 301
#define WHILE 302
#define SWITCH 303
#define DEFAULT 304
#define ELSE 305
#define BREAK 306
#define DO 307
#define FOR 308
#define CASE 309
#define IF 310
#define CONTINUE 311
#define GOTO 312
#define UNSIGNED 313
#define STRUCT 314
#define CONST 315
#define EXTERN 316
#define REGISTER 317
#define TYPEDEF 318
#define UNION 319
#define STATIC 320
#define AUTO 321
#define SIZEOF 322
int pre_proc = 0;
int list_type;
%}

%option noyywrap nounput yylineno
ID [a-zA-Z][a-zA-Z0-9_]*
%x SCOMMENT MCOMMENT
WHITESPACE [ \t\n]

%%
"//" {
/****************************************
* Matching with Single line comments in our
* C code
******************************************/
BEGIN SCOMMENT;
}

"/\*" {
/****************************************
* Matching with multi line comments in our
* C code
******************************************/
BEGIN MCOMMENT;
}

<SCOMMENT>[\n](\r)? {
/****************************************
* A new line indicates end of a single
* line comment in C
****************************************/

BEGIN 0;
}

<MCOMMENT>"\*/" {

BEGIN 0;
}

<SCOMMENT,MCOMMENT>[ \t] {
/****************************************
* Lexer ignores the comments section
* by Ignoring anything inside a comment
****************************************/
}

<SCOMMENT,MCOMMENT>. {
}

"#"[^\n]*"\n" {

    if (pre_proc == 0) {
        pre_proc = 1;
        printf("PREPROC"); 
        return PREPROC; 
    }
}

[ \t\n\r]+ {
}

\' {
}


"(" {

    printf("(\n");
}

")" {

    printf(")\n");
}

"{" {

    printf("{\n");
}

"}" {

    printf("}\n");
}

"[" {

    printf("[\n");
}

"]" {

    printf("]\n");
}

"," {

    printf(",\n");
}

";" {

    printf(";\n");
}

"[A-z][A-z0-9_]*" {

    printf("ID");
    return ID;
}

"0x"[0-9A-f]+ {

    printf("INTVAL");
    return INTVAL;
}

"0"[0-7]* {

    printf("INTVAL");
    return INTVAL;
}

[1-9][0-9]* {

    printf("INTVAL");
    return INTVAL;
}

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
{ID} {
/**************************************
* If an identifier is matched, then
* print ID and return a token ID
**************************************/

    printf("ID");
    return ID;
     }

%%
int main(int argc, const char* argv[])
{
  /*Make a call to yylex() recursively. Whenever yylex() is called, it scans tokens from the
    global input file yyin (which defaults to stdin). It continues until it either reaches an
    end-of-file (at which point it returns the value 0) or one of its actions executes a return statement.*/
    while(yylex()) printf("\n");
return 0;
}
