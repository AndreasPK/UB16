  int lexerError = 0;
%{
#include <stdlib.h>
#include "grammar.h"
#include <string.h>
void yyerror(char*);
%}

digit [0-9]
char [a-zA-Z]
hexCode [0-9a-fA-F]
decNumber {digit}+
octNumber 0x{hexCode}+
number ({decNumber}|{octNumber})
identifier ({char}|_)({char}|{digit}|_)*
lineComment "//".*

  void echoLine(char* s) { printf("%s\n", s); }

%{
/*
  Keywords: end return var do continue break or not
  lexems  : "; ( ) , := : -> * + < = - ˆ "
*/
%}

%%

end     return END; //echoLine(yytext);return END;
return  return RETURN; //echoLine(yytext);
var     return VAR; //echoLine(yytext);
do      return DO; //echoLine(yytext);
continue return CONTINUE; //echoLine(yytext);
break   return BREAK; //echoLine(yytext);
or      return OR; //echoLine(yytext);
not     return NOT; //echoLine(yytext);

\;      return SEMIC; //echoLine(yytext);
\(      return BRACEL; //echoLine(yytext);
\)      return BRACER; //echoLine(yytext);
\,      return COMMA; //echoLine(yytext);
\:=     return ASSIGN; //echoLine(yytext);
\:      return COLON; //echoLine(yytext);
\->     return ARROWR; //echoLine(yytext);
\*      return STAR; //echoLine(yytext);
\+      return PLUS; //echoLine(yytext);
\<      return LESS; //echoLine(yytext);
\=      return EQUAL; //echoLine(yytext);
\-      return MINUS; //echoLine(yytext);
\^      return CIRCUMFLEX; //echoLine(yytext);

{identifier} /*yylval.name = strdup(yytext);*/ return ID; //printf("id %s\n", yytext);
{decNumber}     /*yylval.number = atol(yytext);*/ return NUMBER; //printf("num %ld\n", atol(yytext));
{octNumber}     /*yylval.number = strtol(yytext+2, NULL, 16);*/ return NUMBER; 

[" "\t\n] ;
{lineComment}   ;
.     fprintf(stderr, "Lexer Error: Found unexpected character %c\n", *yytext);exit(1);


%%

int yywrap(void)
{
  return 1;
}
