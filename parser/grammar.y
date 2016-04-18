%{
  #include <stdio.h>
  #include <string.h>
  int yylex(void);
  void yyerror(char* s);
  void msg(char* s);
  const char* someNumber = "someNumber";
%}

%define parse.trace

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
%token LEXER_ERROR

%type <name> ID id stat stats funcdef program term expr

%%

//Angabe:
//Program: { Funcdef ’;’ }
//       ;
//

program: program funcdef SEMIC { msg("funcDef"); }
       |
       ;

//Funcdef: id ’(’ Pars ’)’ Stats end  /* Funktionsdefinition */
//       ;


funcdef: id BRACEL parameterDef BRACER stats END { msg("funcDef"); };

//Pars: { id ’,’ } [ id ]     /* Parameterdefinition */
//    ;

parameterDef: id COMMA parameterDef
            | id
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

guarded: expr ARROWR stats CONTINUE maybeid
       | expr ARROWR stats BREAK maybeid
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

expr: NOT expr
    | MINUS expr
    | term
    | term CIRCUMFLEX
    | pexpr
    | mulexpr
    | orexpr
    | lessexpr
    | eqexpr
    ; //TODO: Finish

pexpr: term PLUS pexpr
     | term
     ;

orexpr: term OR orexpr
      | term
      ;

mulexpr: term STAR mulexpr
       | term
       ;

lessexpr: term LESS lessexpr
        | term
        ;

eqexpr: term EQUAL eqexpr
      | term
      ;

//Term: ’(’ Expr ’)’
//    | num
//    | id                               /* Variablenverwendung */
//    | id ’(’ { Expr ’,’ } [ Expr ] ’)’ /* Funktionsaufruf */
//    ;


term: BRACEL expr BRACER { $$ = $2; }
    | num { $$ = (char*) someNumber; }
    | funcCall
    | id
    ;

funcCall: id BRACEL arguments BRACER ;

arguments: expr
         | expr COMMA arguments
         |
         ;

id: ID { printf("Found id: %s\n", $1); $$ = $1; };

num: NUMBER ;
%%

int main()
{
//  yydebug = 1;
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
