/* output from Ox version G1.04 */
  int lexerError = 0;
%{
#include <stdlib.h>
#include "grammar.h"
#include <string.h>
#include "attribute_types.h"
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


%{


struct yyyT1 { T_AST ast; }; 
typedef struct yyyT1 *yyyP1; 


struct yyyT2 { T_AST ast; }; 
typedef struct yyyT2 *yyyP2; 


struct yyyT3 { T_AST ast; }; 
typedef struct yyyT3 *yyyP3; 


struct yyyT4 { T_AST ast; }; 
typedef struct yyyT4 *yyyP4; 


struct yyyT5 { T_AST ast; }; 
typedef struct yyyT5 *yyyP5; 


struct yyyT6 { T_VALUE value; }; 
typedef struct yyyT6 *yyyP6; 


struct yyyT7 { T_NAME name; }; 
typedef struct yyyT7 *yyyP7; 


struct yyyT8 { T_AST ast; }; 
typedef struct yyyT8 *yyyP8; 


struct yyyT9 { T_AST ast; }; 
typedef struct yyyT9 *yyyP9; 


struct yyyT10 { T_AST ast; }; 
typedef struct yyyT10 *yyyP10; 


struct yyyT11 { T_AST ast; }; 
typedef struct yyyT11 *yyyP11; 


struct yyyT12 { T_AST ast; }; 
typedef struct yyyT12 *yyyP12; 


struct yyyT13 { T_AST ast; }; 
typedef struct yyyT13 *yyyP13; 


struct yyyT14 { T_AST ast; }; 
typedef struct yyyT14 *yyyP14; 


struct yyyT15 { T_NAME name; }; 
typedef struct yyyT15 *yyyP15; 


struct yyyT16 { T_AST ast; }; 
typedef struct yyyT16 *yyyP16; 


struct yyyT17 { T_AST ast; }; 
typedef struct yyyT17 *yyyP17; 


struct yyyT18 { T_AST ast; }; 
typedef struct yyyT18 *yyyP18; 


struct yyyT19 { T_AST ast; }; 
typedef struct yyyT19 *yyyP19; 
                                                      /*custom*/  
typedef unsigned char yyyWAT; 
typedef unsigned char yyyRCT; 
typedef unsigned short yyyPNT; 
typedef unsigned char yyyWST; 

#include <limits.h>
#define yyyR UCHAR_MAX  

 /* funny type; as wide as the widest of yyyWAT,yyyWST,yyyRCT  */ 
typedef unsigned short yyyFT;

                                                      /*stock*/  




struct yyyGenNode {void *parent;  
                   struct yyyGenNode **cL; /* child list */ 
                   yyyRCT *refCountList; 
                   yyyPNT prodNum;                      
                   yyyWST whichSym; /* which child of parent? */ 
                  }; 

typedef struct yyyGenNode yyyGNT; 



struct yyyTB {int isEmpty; 
              int typeNum; 
              int nAttrbs; 
              char *snBufPtr; 
              yyyWAT *startP,*stopP; 
             };  




extern struct yyyTB yyyTermBuffer; 
extern yyyWAT yyyLRCIL[]; 
extern void yyyGenLeaf(); 


%}
%%

end     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return END;} 
return  {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return RETURN;} 
var     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return VAR;} 
do      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return DO;} 
continue {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return CONTINUE;} 
break   {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return BREAK;} 
or      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return OR;} 
not     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return NOT;} 

\;      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return SEMIC;} 
\(      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return BRACEL;} 
\)      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return BRACER;} 
\,      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return COMMA;} 
\:=     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return ASSIGN;} 
\:      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return COLON;} 
\->     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return ARROWR;} 
\*      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return STAR;} 
\+      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return PLUS;} 
\<      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return LESS;} 
\=      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return EQUAL;} 
\-      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return MINUS;} 
\^      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return CIRCUMFLEX;} 

{identifier} {yyyGenLeaf(1,7,yyyLRCIL+0,yyyLRCIL+1); (((yyyP7)(yyyTermBuffer.snBufPtr))->name) = strdup(yytext); return ID;} 
{decNumber}  {yyyGenLeaf(1,6,yyyLRCIL+1,yyyLRCIL+2); (((yyyP6)(yyyTermBuffer.snBufPtr))->value) = atol(yytext); return NUMBER;}  //printf("num %ld\n", atol(yytext));
{octNumber}  {yyyGenLeaf(1,6,yyyLRCIL+1,yyyLRCIL+2); (((yyyP6)(yyyTermBuffer.snBufPtr))->value) = strtol(yytext+2, NULL, 16); return NUMBER;} 

[" "\t\n] ;
{lineComment}   ;
.     fprintf(stderr, "Lexer Error: Found unexpected character %c\n", *yytext);exit(1);


%%

int yywrap(void)
{
  return 1;
}
