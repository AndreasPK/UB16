%{
#include "attribute_types.h"
%}

%{ 
  #include <stdio.h>
  #include <string.h>
  int yylex(void);
  void yyerror(char* s);
  void msg(char* s);
  const char* someNumber = "someNumber";
 %}
%token STAR DO NOT LEXER_ERROR ID BREAK BRACEL CONTINUE COMMA EQUAL BRACER LESS RETURN PLUS VAR NUMBER MINUS COLON ARROWR OR ASSIGN SEMIC END CIRCUMFLEX


%start program

@attributes { T_AST ast; } dostat
@attributes { T_NAME name; } ID
@attributes { T_AST ast; } program
@attributes { T_AST ast; } guarded
@attributes { T_AST ast; } funcCall
@attributes { T_AST ast; } guardedlist
@attributes { T_AST ast; } parameterDef
@attributes { T_AST ast; } stats
@attributes { T_AST ast; } expr
@attributes { T_VALUE value; } NUMBER
@attributes { T_AST ast; } plusexpr
@attributes { T_AST ast; } stat
@attributes { T_AST ast; } arguments
@attributes { T_AST ast; } lexpr
@attributes { T_AST ast; } term
@attributes { T_AST ast; } preexpr
@attributes { T_AST ast; } orexpr
@attributes { T_NAME name; } maybeid
@attributes { T_AST ast; } multexpr

@traversal CompilerPasses

%%
multexpr : term STAR multexpr
           @{
               @i @multexpr.0.ast@ = newChildNode(MULTEXPR, @term.ast@, @multexpr.1.ast@);;
           @}
         | term
           @{
               @i @multexpr.ast@ = @term.ast@;
           @}
         ;
stat : RETURN expr
       @{
           @i @stat.ast@ = newChildNode(RETURNSTAT, @expr.ast@, NULL);;
       @}
     | dostat
       @{
           @i @stat.ast@ = @dostat.ast@;
       @}
     | VAR ID ASSIGN expr
       @{
           @i @stat.ast@ = newChildNode(VARDEF, @expr.ast@, NULL);
@stat.ast@->name = @ID.name@;;
       @}
     | lexpr ASSIGN expr
       @{
           @i @stat.ast@ = newChildNode(VARASSIGN, @lexpr.ast@, @expr.ast@);
       @}
     | term
       @{
           @i @stat.ast@ = newChildNode(TERMSTAT, @term.ast@, NULL);
       @}
     ;
program : program ID BRACEL parameterDef BRACER stats END SEMIC
          @{
              @i @program.0.ast@ = newChildNode(FUNCTION, @parameterDef.ast@, @stats.ast@);
@program.0.ast@->name = @ID.name@;;
              @CompilerPasses {
                 @program.0.ast@ = updateAstSymbols(@program.0.ast@);
              }
          @}
        | 
          @{
              @i @program.ast@ = NULL;;
          @}
        ;
parameterDef : ID COMMA parameterDef
               @{
                   @i @parameterDef.0.ast@ = newArgNode(@ID.name@);
@parameterDef.0.ast@->children[0] = @parameterDef.1.ast@;;
               @}
             | ID
               @{
                   @i @parameterDef.ast@ = newArgNode(@ID.name@);
               @}
             | 
               @{
                   @i @parameterDef.ast@ = NULL;
               @}
             ;
guarded : expr ARROWR stats CONTINUE maybeid
          @{
              @i @guarded.ast@ = newChildNode(GUARDED, @expr.ast@, @stats.ast@);
@guarded.ast@->name = @maybeid.name@;
          @}
        | expr ARROWR stats BREAK maybeid
          @{
              @i @guarded.ast@ = newChildNode(GUARDED, @expr.ast@, @stats.ast@);
@guarded.ast@->name = @maybeid.name@;
          @}
        ;
guardedlist : guarded SEMIC guardedlist
              @{
                  @i @guardedlist.0.ast@ = newChildNode(GUARDEDLIST, @guarded.ast@, @guardedlist.1.ast@);;
              @}
            | 
              @{
                  @i @guardedlist.ast@ = NULL;;
              @}
            ;
arguments : expr
            @{
                @i @arguments.ast@ = newChildNode(ARGEXPR, @expr.ast@, NULL);
            @}
          | expr COMMA arguments
            @{
                @i @arguments.0.ast@ = newChildNode(ARGEXPR, @expr.ast@, @arguments.1.ast@);
            @}
          | 
            @{
                @i @arguments.ast@ = NULL;;
            @}
          ;
stats : stat SEMIC stats
        @{
            @i @stats.0.ast@ = newChildNode(STATS, @stat.ast@, @stats.1.ast@);
        @}
      | 
        @{
            @i @stats.ast@ = NULL;
        @}
      ;
dostat : ID COLON DO guardedlist END
         @{
             @i @dostat.ast@ = newChildNode(DOSTAT, @guardedlist.ast@, NULL);
@dostat.ast@->name = @ID.name@;;
         @}
       | DO guardedlist END
         @{
             @i @dostat.ast@ = newChildNode(DOSTAT, @guardedlist.ast@, NULL);
@dostat.ast@->name = NULL;;
         @}
       ;
funcCall : ID BRACEL arguments BRACER
           @{
               @i @funcCall.ast@ = newChildNode(FCALL, @arguments.ast@, NULL);
@funcCall.ast@->name = @ID.name@;
           @}
         ;
expr : preexpr
       @{
           @i @expr.ast@ = @preexpr.ast@;
       @}
     | term CIRCUMFLEX
       @{
           @i @expr.ast@ = newChildNode(READEXPR, @term.ast@, NULL);
       @}
     | term PLUS plusexpr
       @{
           @i @expr.ast@ = newChildNode(PLUSEXPR, @term.ast@, @plusexpr.ast@);;
       @}
     | term STAR multexpr
       @{
           @i @expr.ast@ = newChildNode(MULTEXPR, @term.ast@, @multexpr.ast@);;
       @}
     | term OR orexpr
       @{
           @i @expr.ast@ = newChildNode(OREXPR, @term.ast@, @orexpr.ast@);
       @}
     | term LESS term
       @{
           @i @expr.ast@ = newChildNode(LESSEXPR, @term.0.ast@, @term.1.ast@);
       @}
     | term EQUAL term
       @{
           @i @expr.ast@ = newChildNode(EQUALEXPR, @term.0.ast@, @term.1.ast@);
       @}
     ;
plusexpr : term PLUS plusexpr
           @{
               @i /* INVALID ASSIGNMENT */@plusexpr.0.ast@ = @term.ast@;
           @}
         | term
           @{
               @i @plusexpr.ast@ = @term.ast@;
           @}
         ;
lexpr : ID
        @{
            @i @lexpr.ast@ = newNode(VARUSE);
@lexpr.ast@->name = @ID.name@;;
        @}
      | term CIRCUMFLEX
        @{
            @i @lexpr.ast@ = @term.ast@;
        @}
      ;
preexpr : NOT preexpr
          @{
              @i @preexpr.0.ast@ = newChildNode(NOTEXPR, @preexpr.1.ast@, NULL);;
          @}
        | MINUS preexpr
          @{
              @i @preexpr.0.ast@ = newChildNode(MINUSEXPR, @preexpr.1.ast@, NULL);
          @}
        | term
          @{
              @i @preexpr.ast@ = @term.ast@;
          @}
        ;
maybeid : ID
          @{
              @i @maybeid.name@ = @ID.name@;
          @}
        | 
          @{
              @i @maybeid.name@ = NULL;;
          @}
        ;
orexpr : term OR orexpr
         @{
             @i @orexpr.0.ast@ = newChildNode(OREXPR, @term.ast@, @orexpr.1.ast@);;
         @}
       | term
         @{
             @i @orexpr.ast@ = @term.ast@;
         @}
       ;
term : BRACEL expr BRACER
       @{
           @i @term.ast@ = newChildNode(EXPRTERM, @expr.ast@, NULL);;
       @}
     | NUMBER
       @{
           @i @term.ast@ = newNode(CONSTTERM);
@term.ast@->value = @NUMBER.value@;
       @}
     | funcCall
       @{
           @i @term.ast@ = @funcCall.ast@;
       @}
     | ID
       @{
           @i @term.ast@ = newNode(VARUSE);
@term.ast@->name = @ID.name@;
       @}
     ;

%%


int main()
{
  //yydebug = 1;
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

