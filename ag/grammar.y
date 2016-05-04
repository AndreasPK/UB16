%{
  #include <stdio.h>
  #include <string.h>
  #include "functions.h"
  int yylex(void);
  void yyerror(char* s);
  void msg(char* s);
  const char* someNumber = "someNumber";
%}

%token END
%token RETURN
%token VAR
%token DO
%token CONTINUE
%token BREAK
%token OR
%token NOT



%token SEMIC // ;
%token BRACEL // (
%token BRACER // )
%token COMMA // ,
%token ASSIGN // :=
%token COLON // :
%token ARROWR // ->
%token STAR // *
%token PLUS // +
%token LESS // <
%token EQUAL // =
%token MINUS // -
%token CIRCUMFLEX // ^

%token ID
%token NUMBER
%token LEXER_ERROR

%start program

%%

//Angabe:
//Program: { Funcdef ’;’ }
//       ;
//

program: ID BRACEL parameterDef BRACER stats END SEMIC program
       |
       ;

//Funcdef: id ’(’ Pars ’)’ Stats end  /* Funktionsdefinition */
//       ;


//Pars: { id ’,’ } [ id ]     /* Parameterdefinition */
//    ;

parameterDef: ID COMMA parameterDef
            | ID
            |
            ;

//Stats: { Stat ’;’ }
//     ;
stats: stat SEMIC stats
     |
     ;

//Stat: return Expr
//    | DoStat
//    | var id ’:=’ Expr /* Variablendefinition */
//    | Lexpr ’:=’ Expr  /* Zuweisung */
//    | Term
//    ;

stat: RETURN expr
    | dostat
    | VAR ID ASSIGN expr
    | lexpr ASSIGN expr
    | term
    ;

//DoStat: [ id ’:’ ] /* Labeldefinition */
//        do { Guarded ’;’ } end
//      ;
//labeldef: ID COLON
//        |
//        ;

dostat: ID COLON DO guardedlist END
      |          DO guardedlist END
      ;

guardedlist: guarded SEMIC guardedlist ;
           |
           ;

//Guarded: Expr ’->’ Stats
//         ( continue | break ) [ id ] /* Labelverwendung */
//       ;

guarded: expr ARROWR stats CONTINUE maybeid
       | expr ARROWR stats BREAK maybeid
       ;

maybeid: ID
       |
       ;

//Lexpr: id        /* schreibender Variablenzugriff */
//     | Term ’^’ /* schreibender Speicherzugriff */
//     ;

lexpr: ID
     | term CIRCUMFLEX
     ;

//Expr: { not | ’-’ } Term
//    | Term ’^’   /* lesender Speicherzugriff */
//    | Term { ’+’ Term }
//    | Term { ’*’ Term }
//    | Term { or Term }
//    | Term ( ’<’ | ’=’ ) Term
//    ;

expr: preexpr
    | term CIRCUMFLEX
    | term PLUS plusexpr
    | term STAR multexpr
    | term OR orexpr
    | term LESS term
    | term EQUAL term
    ; //TODO: Finish

preexpr: NOT preexpr
       | MINUS preexpr
       | term
       ;

plusexpr: term PLUS plusexpr
        | term
        ;

multexpr: term STAR multexpr
        | term
        ;

orexpr: term OR orexpr
        | term
        ;

//Term: ’(’ Expr ’)’
//    | num
//    | id                               /* Variablenverwendung */
//    | id ’(’ { Expr ’,’ } [ Expr ] ’)’ /* Funktionsaufruf */
//    ;


term: BRACEL expr BRACER
    | NUMBER
    | funcCall
    | ID
    ;

funcCall: ID BRACEL arguments BRACER ;

arguments: expr
         | expr COMMA arguments
         |
         ;

%%

int main()
{
  yydebug = 1;
  int pres = yyparse();
  if(pres == 0) return 0;
  if(pres == 1) return 2;
  return pres;
}

void yyerror(char* s)
{
  fprintf(stderr, "%s\n", s);
}

void msg(char* s)
{
  printf("%s\n", s);
}
