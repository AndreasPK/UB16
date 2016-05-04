%{
#include "attribute_types.h"
%}

%{ 
  #include <stdio.h>
  #include <string.h>
  #include "functions.h"
  int yylex(void);
  void yyerror(char* s);
  void msg(char* s);
  const char* someNumber = "someNumber";
 %}
%token STAR DO NOT LEXER_ERROR ID BREAK BRACEL CONTINUE COMMA EQUAL BRACER LESS RETURN PLUS VAR NUMBER MINUS COLON ARROWR OR ASSIGN SEMIC END CIRCUMFLEX


%start program

@attributes { T_NAME name; } ID


%%
multexpr : term STAR multexpr
         | term
         ;
guardedlist : guarded SEMIC guardedlist
            | 
            ;
term : BRACEL expr BRACER
     | NUMBER
     | funcCall
     | ID
     ;
preexpr : NOT preexpr
        | MINUS preexpr
        | term
        ;
funcCall : ID BRACEL arguments BRACER
         ;
plusexpr : term PLUS plusexpr
         | term
         ;
maybeid : ID
        | 
        ;
parameterDef : ID COMMA parameterDef
             | ID
             | 
             ;
lexpr : ID
      | term CIRCUMFLEX
      ;
expr : preexpr
     | term CIRCUMFLEX
     | term PLUS plusexpr
     | term STAR multexpr
     | term OR orexpr
     | term LESS term
     | term EQUAL term
     ;
arguments : expr
          | expr COMMA arguments
          | 
          ;
stat : RETURN expr
     | dostat
     | VAR ID ASSIGN expr
     | lexpr ASSIGN expr
     | term
     ;
dostat : ID COLON DO guardedlist END
       | guardedlist END
       ;
program : ID BRACEL parameterDef BRACER stats END SEMIC program
        | 
        ;
stats : stat SEMIC stats
      | 
      ;
orexpr : term OR orexpr
       | term
       ;
guarded : expr ARROWR stats CONTINUE maybeid
        | expr ARROWR stats BREAK maybeid
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

