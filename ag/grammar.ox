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
%token STAR NUMBER DO NOT LEXER_ERROR MINUS ID BREAK COLON ARROWR BRACEL CONTINUE COMMA EQUAL BRACER OR LESS RETURN ASSIGN PLUS VAR SEMIC END CIRCUMFLEX


%start program

@attributes { T_SIN sin; } guardedlist
@attributes { T_SOUT sout; } parameterDef
@attributes { T_SIN sin; T_SOUT sout; } stats
@attributes { T_SIN sin; } expr
@attributes { T_SIN sin; } dostat
@attributes { T_NAME name; } ID
@attributes { T_SIN sin; } plusexpr
@attributes { T_SIN sin; T_SOUT sout; } stat
@attributes { T_SIN sin; } arguments
@attributes { T_SIN sin; } lexpr
@attributes { T_SIN sin; } term
@attributes { T_SIN sin; } preexpr
@attributes { T_SIN sin; } orexpr
@attributes { T_SIN sin; } maybeid
@attributes { T_SIN sin; } multexpr
@attributes { T_SIN sin; } guarded
@attributes { T_SIN sin; } funcCall

@traversal labelUse
@traversal listSymbols
@traversal varDef
@traversal varUse

%%
term : BRACEL expr BRACER
       @{
           @i @expr.sin@ = @term.sin@;
       @}
     | NUMBER
     | funcCall
       @{
           @i @funcCall.sin@ = @term.sin@;
       @}
     | ID
       @{
           @varUse {
              printf("Reading variable: %s\n", @ID.name@);
              if(sym_use(@term.sin@,@ID.name@,ST_VAR) != 0)
              {
                printf("Error variable can't be used.\n");
                exit(3);
              }
              
           }
       @}
     ;
funcCall : ID BRACEL arguments BRACER
           @{
               @i @arguments.sin@ = @funcCall.sin@;
           @}
         ;
lexpr : ID
        @{
            @varUse {
               if(sym_use(@lexpr.sin@,@ID.name@,ST_VAR) != 0)
               {
               	printf("Error, variable %s not defined but assigned!\n", @ID.name@);
               	exit(3);
               }
            }
        @}
      | term CIRCUMFLEX
        @{
            @i @term.sin@ = @lexpr.sin@;
        @}
      ;
maybeid : ID
          @{
              @labelUse {
                 if(sym_use(@maybeid.sin@, @ID.name@, ST_LABEL) != 0)
                 {
                 	printf("Label check failed for %s.\n", @ID.name@);
                 	sym_list(@maybeid.sin@);
                 	exit(3);
                 }
              }
          @}
        | 
        ;
stats : stat SEMIC stats
        @{
            @i @stats.1.sin@ = @stats.0.sout@;
            @i @stat.sin@ = @stats.0.sin@;
            @i @stats.0.sout@ = @stat.sout@;
        @}
      | 
        @{
            @i @stats.sout@ = @stats.sin@;
        @}
      ;
parameterDef : ID COMMA parameterDef
               @{
                   @i @parameterDef.0.sout@ = sym_add(@parameterDef.1.sout@, @ID.name@, ST_VAR);;
                   @varDef {
                      printf("%s\n", @ID.name@);
                      if(sym_find(@parameterDef.1.sout@, @ID.name@, ST_ANY) != NULL)
                      {
                      	printf("Error, Parameter defined twice!\n");
                      	exit(3);
                      }
                   }
               @}
             | ID
               @{
                   @i @parameterDef.sout@ = sym_add(NULL, @ID.name@, ST_VAR);;
               @}
             | 
               @{
                   @i @parameterDef.sout@ = NULL;;
               @}
             ;
dostat : ID COLON DO guardedlist END
         @{
             @i @guardedlist.sin@ = sym_add(@dostat.sin@, @ID.name@, ST_LABEL);;
             @varDef {
                if(sym_def(@dostat.sin@, @ID.name@, ST_LABEL) != 0)
                {
                  printf("Error defining label %s.\n", @ID.name@);
                  exit(3);
                }
             }
         @}
       | DO guardedlist END
         @{
             @i @guardedlist.sin@ = @dostat.sin@;
         @}
       ;
plusexpr : term PLUS plusexpr
           @{
               @i @plusexpr.1.sin@ = @plusexpr.0.sin@;
               @i @term.sin@ = @plusexpr.0.sin@;
           @}
         | term
           @{
               @i @term.sin@ = @plusexpr.sin@;
           @}
         ;
guarded : expr ARROWR stats CONTINUE maybeid
          @{
              @i @expr.sin@ = @guarded.sin@;
              @i @stats.sin@ = @guarded.sin@;
              @i @maybeid.sin@ = @guarded.sin@;
          @}
        | expr ARROWR stats BREAK maybeid
          @{
              @i @stats.sin@ = @guarded.sin@;
              @i @maybeid.sin@ = @guarded.sin@;
              @i @expr.sin@ = @guarded.sin@;
          @}
        ;
orexpr : term OR orexpr
         @{
             @i @orexpr.1.sin@ = @orexpr.0.sin@;
             @i @term.sin@ = @orexpr.0.sin@;
         @}
       | term
         @{
             @i @term.sin@ = @orexpr.sin@;
         @}
       ;
stat : RETURN expr
       @{
           @i @stat.sout@ = @stat.sin@;
           @i @expr.sin@ = @stat.sin@;
       @}
     | dostat
       @{
           @i @dostat.sin@ = @stat.sin@;
           @i @stat.sout@ = @stat.sin@;
       @}
     | VAR ID ASSIGN expr
       @{
           @i   @stat.sout@ = sym_add(@stat.sin@, @ID.name@, ST_VAR);
;
           @varDef {
              if(sym_def(@stat.sin@, @ID.name@, ST_VAR) != 0)
              {
                printf("Error, can't define variable %s.\n", @ID.name@);
                exit(3);
              }
           }
           @i @expr.sin@ = @stat.sin@;
       @}
     | lexpr ASSIGN expr
       @{
           @i @lexpr.sin@ = @stat.sin@;
           @i @stat.sout@ = @stat.sin@;
           @i @expr.sin@ = @stat.sin@;
       @}
     | term
       @{
           @i @term.sin@ = @stat.sin@;
           @i @stat.sout@ = @stat.sin@;
       @}
     ;
multexpr : term STAR multexpr
           @{
               @i @multexpr.1.sin@ = @multexpr.0.sin@;
               @i @term.sin@ = @multexpr.0.sin@;
           @}
         | term
           @{
               @i @term.sin@ = @multexpr.sin@;
           @}
         ;
arguments : expr
            @{
                @i @expr.sin@ = @arguments.sin@;
            @}
          | expr COMMA arguments
            @{
                @i @arguments.1.sin@ = @arguments.0.sin@;
                @i @expr.sin@ = @arguments.0.sin@;
            @}
          | 
          ;
expr : preexpr
       @{
           @i @preexpr.sin@ = @expr.sin@;
       @}
     | term CIRCUMFLEX
       @{
           @i @term.sin@ = @expr.sin@;
       @}
     | term PLUS plusexpr
       @{
           @i @term.sin@ = @expr.sin@;
           @i @plusexpr.sin@ = @expr.sin@;
       @}
     | term STAR multexpr
       @{
           @i @multexpr.sin@ = @expr.sin@;
           @i @term.sin@ = @expr.sin@;
       @}
     | term OR orexpr
       @{
           @i @term.sin@ = @expr.sin@;
           @i @orexpr.sin@ = @expr.sin@;
       @}
     | term LESS term
       @{
           @i @term.1.sin@ = @expr.sin@;
           @i @term.0.sin@ = @expr.sin@;
       @}
     | term EQUAL term
       @{
           @i @term.1.sin@ = @expr.sin@;
           @i @term.0.sin@ = @expr.sin@;
       @}
     ;
program : program ID BRACEL parameterDef BRACER stats END SEMIC
          @{
              @i @stats.sin@ = @parameterDef.sout@;
              @listSymbols {
                 sym_list(@parameterDef.sout@);
              }
          @}
        | 
        ;
guardedlist : guarded SEMIC guardedlist
              @{
                  @listSymbols {
                     sym_list(@guardedlist.0.sin@);
                  }
                  @i @guarded.sin@ = @guardedlist.0.sin@;
                  @i @guardedlist.1.sin@ = @guardedlist.0.sin@;
              @}
            | 
            ;
preexpr : NOT preexpr
          @{
              @i @preexpr.1.sin@ = @preexpr.0.sin@;
          @}
        | MINUS preexpr
          @{
              @i @preexpr.1.sin@ = @preexpr.0.sin@;
          @}
        | term
          @{
              @i @term.sin@ = @preexpr.sin@;
          @}
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

