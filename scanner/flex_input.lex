  int num_lines = 0, num_chars = 0;

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

end     echoLine(yytext);
return  echoLine(yytext);
var     echoLine(yytext);
do      echoLine(yytext);
continue  echoLine(yytext);
break   echoLine(yytext);
or      echoLine(yytext);
not     echoLine(yytext);

\;      echoLine(yytext);
\(      echoLine(yytext);
\)      echoLine(yytext);
\,      echoLine(yytext);
\:=     echoLine(yytext);
\:      echoLine(yytext);
\->     echoLine(yytext);
\*      echoLine(yytext);
\+      echoLine(yytext);
\<      echoLine(yytext);
\=      echoLine(yytext);
\-      echoLine(yytext);
\^      echoLine(yytext);

{identifier} printf("id %s\n", yytext);
{decNumber}     printf("num %ld\n", atol(yytext));
{octNumber}     printf("num %ld\n", strtol(yytext+2, NULL, 16));

[" "\t\n] ;
{lineComment}   ;
.     printf("Found unexpected character %c\n", *yytext);return 1;


%%

int main()
{
  yylex();
  return 0;
}

int yywrap(void)
{
  return 1;
}
