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
%token STAR NUMBER DO NOT MINUS LEXER_ERROR ID BREAK COLON ARROWR CONTINUE BRACEL COMMA EQUAL OR BRACER ASSIGN RETURN LESS PLUS VAR END SEMIC CIRCUMFLEX


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
@attributes { T_SIN sin; } multexpr
@attributes { T_SIN sin; } guarded
@attributes { T_SIN sin; } funcCall

@traversal listSymbols

%%
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
funcCall : ID BRACEL arguments BRACER
           @{
               @i @arguments.sin@ = @funcCall.sin@;
           @}
         ;
stats : stat SEMIC stats
        @{
            @i @stat.sin@ = @stats.0.sin@;
            @i @stats.1.sin@ = @stats.0.sout@;
            @i @stats.0.sout@ = @stat.sout@;
        @}
      | 
        @{
            @i @stats.sout@ = @stats.sin@;
        @}
      ;
guardedlist : guarded SEMIC guardedlist
              @{
                  @i @guardedlist.1.sin@ = @guardedlist.0.sin@;
                  @i @guarded.sin@ = @guardedlist.0.sin@;
              @}
            | 
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
guarded : expr ARROWR stats CONTINUE maybeid
          @{
              @i @expr.sin@ = @guarded.sin@;
              @i @stats.sin@ = @guarded.sin@;
          @}
        | expr ARROWR stats BREAK maybeid
          @{
              @i @stats.sin@ = @guarded.sin@;
              @i @expr.sin@ = @guarded.sin@;
          @}
        ;
program : program ID BRACEL parameterDef BRACER stats END SEMIC
          @{
              @listSymbols {
                 sym_list(@parameterDef.sout@);
              }
              @i @stats.sin@ = @parameterDef.sout@;
          @}
        | 
        ;
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
           @i @plusexpr.sin@ = @expr.sin@;
           @i @term.sin@ = @expr.sin@;
       @}
     | term STAR multexpr
       @{
           @i @multexpr.sin@ = @expr.sin@;
           @i @term.sin@ = @expr.sin@;
       @}
     | term OR orexpr
       @{
           @i @orexpr.sin@ = @expr.sin@;
           @i @term.sin@ = @expr.sin@;
       @}
     | term LESS term
       @{
           @i @term.0.sin@ = @expr.sin@;
           @i @term.1.sin@ = @expr.sin@;
       @}
     | term EQUAL term
       @{
           @i @term.1.sin@ = @expr.sin@;
           @i @term.0.sin@ = @expr.sin@;
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
maybeid : ID
        | 
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
           @i @expr.sin@ = @stat.sin@;
           @i @stat.sout@ = sym_add(@stat.sin@, @ID.name@);;
       @}
     | lexpr ASSIGN expr
       @{
           @i @expr.sin@ = @stat.sin@;
           @i @lexpr.sin@ = @stat.sin@;
           @i @stat.sout@ = @stat.sin@;
       @}
     | term
       @{
           @i @stat.sout@ = @stat.sin@;
           @i @term.sin@ = @stat.sin@;
       @}
     ;
dostat : ID COLON DO guardedlist END
         @{
             @i @guardedlist.sin@ = sym_add(@dostat.sin@, @ID.name@);;
         @}
       | DO guardedlist END
         @{
             @i @guardedlist.sin@ = @dostat.sin@;
         @}
       ;
parameterDef : ID COMMA parameterDef
               @{
                   @i @parameterDef.0.sout@ = sym_add(@parameterDef.1.sout@, @ID.name@);
               @}
             | ID
               @{
                   @i @parameterDef.sout@ = sym_add(NULL, @ID.name@);;
               @}
             | 
               @{
                   @i @parameterDef.sout@ = NULL;;
               @}
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
lexpr : ID
      | term CIRCUMFLEX
        @{
            @i @term.sin@ = @lexpr.sin@;
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

