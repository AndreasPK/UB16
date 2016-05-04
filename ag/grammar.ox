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
parameterDef : ID COMMA parameterDef
             | ID
             | 
             ;
preexpr : NOT preexpr
        | MINUS preexpr
        | term
        ;
maybeid : ID
        | 
        ;
dostat : ID COLON DO guardedlist END
       | DO guardedlist END
       ;
term : BRACEL expr BRACER
     | NUMBER
     | funcCall
     | ID
     ;
plusexpr : term PLUS plusexpr
         | term
         ;
expr : preexpr
     | term CIRCUMFLEX
     | term PLUS plusexpr
     | term STAR multexpr
     | term OR orexpr
     | term LESS term
     | term EQUAL term
     ;
funcCall : ID BRACEL arguments BRACER
         ;
orexpr : term OR orexpr
       | term
       ;
stats : stat SEMIC stats
      | 
      ;
multexpr : term STAR multexpr
         | term
         ;
guardedlist : guarded SEMIC guardedlist
            | 
            ;
arguments : expr
          | expr COMMA arguments
          | 
          ;
guarded : expr ARROWR stats CONTINUE maybeid
        | expr ARROWR stats BREAK maybeid
        ;
stat : RETURN expr
     | dostat
     | VAR ID ASSIGN expr
     | lexpr ASSIGN expr
     | term
     ;
lexpr : ID
      | term CIRCUMFLEX
      ;
program : ID BRACEL parameterDef BRACER stats END SEMIC program
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

