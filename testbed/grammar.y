%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(char* s);
%}

%union
{
  long number;
  char* name;
}

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

%%

//Angabe:
//Program: { Funcdef ’;’ }  
//       ;  
//

program: funcList { } ;

funcList: funcdef SEMIC funcList { }
        | /*Empty*/
        ;

//Funcdef: id ’(’ Pars ’)’ Stats end  /* Funktionsdefinition */  
//       ;  


funcdef: id BRACEL pars BRACER stats END {};

//Pars: { id ’,’ } [ id ]     /* Parameterdefinition */  
//    ;  

pars: pars COLON id
    | id
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
labeldef: id COLON
        |
        ;

dostat: labeldef DO guardedlist END ;

guardedlist: guarded SEMIC guardedlist ;
           |
           ;

//Guarded: Expr ’->’ Stats  
//         ( continue | break ) [ id ] /* Labelverwendung */  
//       ;  

guarded: expr ARROWR stats cbswitch maybeid;

cbswitch: CONTINUE
        | BREAK
        ;

maybeid: id
       |
       ;

//Lexpr: id        /* schreibender Variablenzugriff */  
//     | Term ’^’ /* schreibender Speicherzugriff */  
//     ;  

lexpr: id
     | term CIRCUMFLEX
     ;

//Expr: { not | ’-’ } Term  
//    | Term ’^’   /* lesender Speicherzugriff */  
//    | Term { ’+’ Term }  
//    | Term { ’*’ Term }  
//    | Term { or Term }  
//    | Term ( ’<’ | ’=’ ) Term  
//    ;  

preexpr: preexpr NOT
       | preexpr MINUS
       |
       ;

expr: preexpr term
    | term CIRCUMFLEX
    | term PLUS term
    ; //TODO: Finish

//Term: ’(’ Expr ’)’  
//    | num  
//    | id                               /* Variablenverwendung */  
//    | id ’(’ { Expr ’,’ } [ Expr ] ’)’ /* Funktionsaufruf */  
//    ;

exprlist: exprlist expr
        | expr COMMA
        |
        ;

term: BRACEL expr BRACER
    | num
    | id
    | id BRACEL exprlist BRACER
    ;

id: ID ;

num: NUMBER ;
%%

int main()
{
  yyparse();
  return 0;
}

void yyerror(char* s)
{
  fprintf(stderr, "%s\n", s);
}

