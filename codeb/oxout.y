/* output from Ox version G1.04 */
%{
%}
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
%token STAR NUMBER DO NOT LEXER_ERROR MINUS ID BREAK COLON ARROWR BRACEL CONTINUE COMMA EQUAL BRACER OR LESS RETURN ASSIGN PLUS VAR SEMIC END CIRCUMFLEX


%start yyyAugNonterm

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 




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


struct yyyT15 { T_AST ast; }; 
typedef struct yyyT15 *yyyP15; 


struct yyyT16 { T_NAME name; }; 
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

%{
#include <stdio.h>

int yyyYok = 1;
int yyyInitDone = 0;
char *yyySTsn;
yyyGNT *yyySTN;
int yyyGNSz = sizeof(yyyGNT);
int yyyProdNum,yyyRHSlength,yyyNattrbs,yyyTypeNum; 

extern yyyFT yyyRCIL[];

void yyyExecuteRRsection();
void yyyYoxInit();
void yyyYoxReset();
void yyyDecorate();
void yyyGenIntNode();
void yyyAdjustINRC();
void yyyPrune();
void yyyUnsolvedInstSearchTrav();
void yyyUnsolvedInstSearchTravAux();
void yyyerror();
void yyyShift();



#define yyyRSU(NUM1,NUM2,NUM3,NUM4) \
   yyyProdNum=NUM1;yyyRHSlength=NUM2;yyyNattrbs=NUM3;yyyTypeNum=NUM4;\
   if ((yychar <= 0) && (!yyyTermBuffer.isEmpty)) yyyShift(); 
%}


%%
yyyAugNonterm 
	:	{if (!yyyInitDone) 
		    {yyyYoxInit(); 
		     yyyInitDone = 1;
		    }
		 yyyYoxReset();
		}
		program
		{
		 yyyDecorate(); yyyExecuteRRsection();
		}
	;
program : program ID BRACEL parameterDef BRACER stats END SEMIC
          {if(yyyYok){
yyyRSU(1,8,1,13);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+0,yyyRCIL+3);/*yyyPrune(1);*/}}
        | 
          {if(yyyYok){
yyyRSU(2,0,1,13);
yyyGenIntNode();
 (((yyyP13)yyySTsn)->ast) = NULL;;
          yyyAdjustINRC(yyyRCIL+3,yyyRCIL+6);}}
        ;
maybeid : ID
          {if(yyyYok){
yyyRSU(3,1,1,16);
yyyGenIntNode();
 (((yyyP16)yyySTsn)->name) = (((yyyP7)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->name);
          yyyAdjustINRC(yyyRCIL+6,yyyRCIL+9);/*yyyPrune(3);*/}}
        | 
          {if(yyyYok){
yyyRSU(4,0,1,16);
yyyGenIntNode();
 (((yyyP16)yyySTsn)->name) = NULL;
;
          yyyAdjustINRC(yyyRCIL+9,yyyRCIL+12);}}
        ;
preexpr : NOT preexpr
          {if(yyyYok){
yyyRSU(5,2,1,14);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+12,yyyRCIL+15);/*yyyPrune(5);*/}}
        | MINUS preexpr
          {if(yyyYok){
yyyRSU(6,2,1,14);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+15,yyyRCIL+18);/*yyyPrune(6);*/}}
        | term
          {if(yyyYok){
yyyRSU(7,1,1,14);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+18,yyyRCIL+21);/*yyyPrune(7);*/}}
        ;
lexpr : ID
        {if(yyyYok){
yyyRSU(8,1,1,11);
yyyGenIntNode();
 (((yyyP11)yyySTsn)->ast) = newNode(VARUSE);
(((yyyP11)yyySTsn)->ast)->name = (((yyyP7)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->name);;
        yyyAdjustINRC(yyyRCIL+21,yyyRCIL+24);/*yyyPrune(8);*/}}
      | term CIRCUMFLEX
        {if(yyyYok){
yyyRSU(9,2,1,11);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+24,yyyRCIL+27);/*yyyPrune(9);*/}}
      ;
parameterDef : ID COMMA parameterDef
               {if(yyyYok){
yyyRSU(10,3,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+27,yyyRCIL+30);/*yyyPrune(10);*/}}
             | ID
               {if(yyyYok){
yyyRSU(11,1,1,2);
yyyGenIntNode();
 (((yyyP2)yyySTsn)->ast) = newArgNode((((yyyP7)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->name));
               yyyAdjustINRC(yyyRCIL+30,yyyRCIL+33);/*yyyPrune(11);*/}}
             | 
               {if(yyyYok){
yyyRSU(12,0,1,2);
yyyGenIntNode();
 (((yyyP2)yyySTsn)->ast) = newNode(LASTARG);;
               yyyAdjustINRC(yyyRCIL+33,yyyRCIL+36);}}
             ;
term : BRACEL expr BRACER
       {if(yyyYok){
yyyRSU(13,3,1,12);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+36,yyyRCIL+39);/*yyyPrune(13);*/}}
     | NUMBER
       {if(yyyYok){
yyyRSU(14,1,1,12);
yyyGenIntNode();
 (((yyyP12)yyySTsn)->ast) = newNode(CONSTTERM);
(((yyyP12)yyySTsn)->ast)->value = (((yyyP6)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->value);
       yyyAdjustINRC(yyyRCIL+39,yyyRCIL+42);/*yyyPrune(14);*/}}
     | funcCall
       {if(yyyYok){
yyyRSU(15,1,1,12);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+42,yyyRCIL+45);/*yyyPrune(15);*/}}
     | ID
       {if(yyyYok){
yyyRSU(16,1,1,12);
yyyGenIntNode();
 (((yyyP12)yyySTsn)->ast) = newNode(VARUSE);
(((yyyP12)yyySTsn)->ast)->name = (((yyyP7)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->name);
       yyyAdjustINRC(yyyRCIL+45,yyyRCIL+48);/*yyyPrune(16);*/}}
     ;
guarded : expr ARROWR stats CONTINUE maybeid
          {if(yyyYok){
yyyRSU(17,5,1,18);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+48,yyyRCIL+51);/*yyyPrune(17);*/}}
        | expr ARROWR stats BREAK maybeid
          {if(yyyYok){
yyyRSU(18,5,1,18);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+51,yyyRCIL+54);/*yyyPrune(18);*/}}
        ;
dostat : ID COLON DO guardedlist END
         {if(yyyYok){
yyyRSU(19,5,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+54,yyyRCIL+57);/*yyyPrune(19);*/}}
       | DO guardedlist END
         {if(yyyYok){
yyyRSU(20,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+57,yyyRCIL+60);/*yyyPrune(20);*/}}
       ;
funcCall : ID BRACEL arguments BRACER
           {if(yyyYok){
yyyRSU(21,4,1,19);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+60,yyyRCIL+63);/*yyyPrune(21);*/}}
         ;
guardedlist : guarded SEMIC guardedlist
              {if(yyyYok){
yyyRSU(22,3,1,1);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+63,yyyRCIL+66);/*yyyPrune(22);*/}}
            | 
              {if(yyyYok){
yyyRSU(23,0,1,1);
yyyGenIntNode();
 (((yyyP1)yyySTsn)->ast) = newChildNode(ENDGUARD, NULL, NULL);;
              yyyAdjustINRC(yyyRCIL+66,yyyRCIL+69);}}
            ;
multexpr : term STAR multexpr
           {if(yyyYok){
yyyRSU(24,3,1,17);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+69,yyyRCIL+72);/*yyyPrune(24);*/}}
         | term
           {if(yyyYok){
yyyRSU(25,1,1,17);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+72,yyyRCIL+75);/*yyyPrune(25);*/}}
         ;
orexpr : term OR orexpr
         {if(yyyYok){
yyyRSU(26,3,1,15);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+75,yyyRCIL+78);/*yyyPrune(26);*/}}
       | term
         {if(yyyYok){
yyyRSU(27,1,1,15);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+78,yyyRCIL+81);/*yyyPrune(27);*/}}
       ;
expr : preexpr
       {if(yyyYok){
yyyRSU(28,1,1,4);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+81,yyyRCIL+84);/*yyyPrune(28);*/}}
     | term CIRCUMFLEX
       {if(yyyYok){
yyyRSU(29,2,1,4);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+84,yyyRCIL+87);/*yyyPrune(29);*/}}
     | term PLUS plusexpr
       {if(yyyYok){
yyyRSU(30,3,1,4);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+87,yyyRCIL+90);/*yyyPrune(30);*/}}
     | term STAR multexpr
       {if(yyyYok){
yyyRSU(31,3,1,4);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+90,yyyRCIL+93);/*yyyPrune(31);*/}}
     | term OR orexpr
       {if(yyyYok){
yyyRSU(32,3,1,4);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+93,yyyRCIL+96);/*yyyPrune(32);*/}}
     | term LESS term
       {if(yyyYok){
yyyRSU(33,3,1,4);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+96,yyyRCIL+99);/*yyyPrune(33);*/}}
     | term EQUAL term
       {if(yyyYok){
yyyRSU(34,3,1,4);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+99,yyyRCIL+102);/*yyyPrune(34);*/}}
     ;
plusexpr : term PLUS plusexpr
           {if(yyyYok){
yyyRSU(35,3,1,8);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+102,yyyRCIL+105);/*yyyPrune(35);*/}}
         | term
           {if(yyyYok){
yyyRSU(36,1,1,8);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+105,yyyRCIL+108);/*yyyPrune(36);*/}}
         ;
stat : RETURN expr
       {if(yyyYok){
yyyRSU(37,2,1,9);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+108,yyyRCIL+111);/*yyyPrune(37);*/}}
     | dostat
       {if(yyyYok){
yyyRSU(38,1,1,9);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+111,yyyRCIL+114);/*yyyPrune(38);*/}}
     | VAR ID ASSIGN expr
       {if(yyyYok){
yyyRSU(39,4,1,9);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+114,yyyRCIL+117);/*yyyPrune(39);*/}}
     | lexpr ASSIGN expr
       {if(yyyYok){
yyyRSU(40,3,1,9);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+117,yyyRCIL+120);/*yyyPrune(40);*/}}
     | term
       {if(yyyYok){
yyyRSU(41,1,1,9);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+120,yyyRCIL+123);/*yyyPrune(41);*/}}
     ;
stats : stat SEMIC stats
        {if(yyyYok){
yyyRSU(42,3,1,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+123,yyyRCIL+126);/*yyyPrune(42);*/}}
      | 
        {if(yyyYok){
yyyRSU(43,0,1,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->ast) = NULL;;
        yyyAdjustINRC(yyyRCIL+126,yyyRCIL+129);}}
      ;
arguments : expr
            {if(yyyYok){
yyyRSU(44,1,1,10);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+129,yyyRCIL+132);/*yyyPrune(44);*/}}
          | expr COMMA arguments
            {if(yyyYok){
yyyRSU(45,3,1,10);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+132,yyyRCIL+135);/*yyyPrune(45);*/}}
          | 
            {if(yyyYok){
yyyRSU(46,0,1,10);
yyyGenIntNode();
 (((yyyP10)yyySTsn)->ast) = NULL;;
            yyyAdjustINRC(yyyRCIL+135,yyyRCIL+138);}}
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

                                                      /*custom*/  
long yyyMaxNbytesNodeStg = 2000000; 
long yyyMaxNrefCounts =    500000; 
long yyyMaxNchildren =     60000; 
long yyyMaxStackSize =     2000; 
long yyySSALspaceSize =    20000; 
long yyyRSmaxSize =        1000; 
long yyyTravStackMaxSize = 2000; 


struct yyyTB yyyTermBuffer; 

char *yyyNodeAndStackSpace; 

char *yyyNodeSpace;
char *yyyNextNodeSpace; 
char *yyyAfterNodeSpace; 


 
struct yyyGenNode **yyyChildListSpace;  
struct yyyGenNode **yyyNextCLspace; 
struct yyyGenNode **yyyAfterChildListSpace; 



yyyRCT *yyyRefCountListSpace;
yyyRCT *yyyNextRCLspace;  
yyyRCT *yyyAfterRefCountListSpace;   



struct yyySolvedSAlistCell {yyyWAT attrbNum; 
                            long next; 
                           }; 
#define yyyLambdaSSAL 0 
long yyySSALCfreeList = yyyLambdaSSAL; 
long yyyNewSSALC = 1; 
 
struct yyySolvedSAlistCell *yyySSALspace; 


 
struct yyyStackItem {struct yyyGenNode *node; 
                     long solvedSAlist; 
                     struct yyyGenNode *oldestNode; 
                    };  

long yyyNbytesStackStg; 
struct yyyStackItem *yyyStack; 
struct yyyStackItem *yyyAfterStack; 
struct yyyStackItem *yyyStackTop; 



struct yyyRSitem {yyyGNT *node; 
                  yyyWST whichSym; 
                  yyyWAT wa;  
                 };  

struct yyyRSitem *yyyRS;  
struct yyyRSitem *yyyRSTop;  
struct yyyRSitem *yyyAfterRS;  
 





yyyFT yyyRCIL[] = {
yyyR,0,2, yyyR,0,0, yyyR,0,0, yyyR,0,0, yyyR,0,1, yyyR,0,1, 
yyyR,0,1, yyyR,0,0, yyyR,0,1, yyyR,0,1, yyyR,0,0, yyyR,0,0, 
yyyR,0,1, yyyR,0,0, yyyR,0,1, yyyR,0,0, yyyR,0,3, yyyR,0,3, 
yyyR,0,1, yyyR,0,1, yyyR,0,1, yyyR,0,2, yyyR,0,0, yyyR,0,2, 
yyyR,0,1, yyyR,0,2, yyyR,0,1, yyyR,0,1, yyyR,0,1, yyyR,0,2, 
yyyR,0,2, yyyR,0,2, yyyR,0,2, yyyR,0,2, yyyR,0,2, yyyR,0,1, 
yyyR,0,1, yyyR,0,1, yyyR,0,1, yyyR,0,2, yyyR,0,1, yyyR,0,2, 
yyyR,0,0, yyyR,0,1, yyyR,0,2, yyyR,0,0, 
};

short yyyIIIEL[] = {0,
0,9,10,12,13,16,19,21,23,26,
30,32,33,37,39,41,43,49,55,61,
65,70,74,75,79,81,85,87,89,92,
96,100,104,108,112,116,118,121,123,128,
132,134,138,139,141,145,
};

long yyyIIEL[] = {
0,1,2,3,3,4,4,5,5,5,6,7,
8,9,10,10,11,12,12,13,14,15,16,17,
18,19,19,20,21,21,22,23,24,25,26,26,
27,27,28,29,30,31,32,33,34,35,35,36,
36,37,38,39,39,40,40,41,42,43,43,43,
44,44,45,45,46,46,47,48,48,49,49,50,
51,51,52,53,54,55,55,56,57,58,59,60,
60,61,62,63,64,65,66,67,67,68,69,69,
70,71,72,72,73,74,75,75,76,77,78,78,
79,80,81,81,82,83,84,84,85,86,87,88,
88,89,90,91,92,92,93,93,94,95,96,96,
97,98,99,100,101,101,102,103,104,105,106,107,
107,108,
};

long yyyIEL[] = {
0,0,0,2,4,6,6,6,
8,8,8,10,10,12,12,14,
14,16,16,18,18,20,22,22,
24,24,24,26,26,28,28,30,
30,32,32,34,36,38,38,40,
42,44,44,46,48,48,50,50,
52,54,54,56,58,58,58,60,
62,62,64,64,66,68,68,70,
70,72,72,74,74,76,78,78,
80,82,82,84,86,86,88,90,
90,92,94,94,96,98,98,100,
100,102,102,104,104,106,108,108,
110,112,112,114,114,116,118,118,
118,120,120,122,124,124,
};

yyyFT yyyEntL[] = {
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,
};

#define yyyPermitUserAlloc  0 


void yyyfatal(msg)
  char *msg; 
{fprintf(stderr,msg);exit(-1);} 



#define yyyNSof   'n' 
#define yyyRCof   'r' 
#define yyyCLof   'c' 
#define yyySof    's' 
#define yyySSALof 'S' 
#define yyyRSof   'q' 
#define yyyTSof   't' 



void yyyHandleOverflow(which) 
  char which; 
  {char *msg1,*msg2; 
   long  oldSize,newSize; 
   switch(which) 
     {
      case yyyNSof   : 
           msg1 = "node storage overflow: ";
           oldSize = yyyMaxNbytesNodeStg; 
           break; 
      case yyyRCof   : 
           msg1 = "dependee count overflow: ";
           oldSize = yyyMaxNrefCounts; 
           break; 
      case yyyCLof   : 
           msg1 = "child list overflow: ";
           oldSize = yyyMaxNchildren; 
           break; 
      case yyySof    : 
           msg1 = "parse-tree stack overflow: ";
           oldSize = yyyMaxStackSize; 
           break; 
      case yyySSALof : 
           msg1 = "SSAL overflow: ";
           oldSize = yyySSALspaceSize; 
           break; 
      case yyyRSof   : 
           msg1 = "ready set overflow: ";
           oldSize = yyyRSmaxSize; 
           break; 
      case yyyTSof   : 
           msg1 = "traversal stack overflow: ";
           oldSize = yyyTravStackMaxSize; 
           break; 
      default        :;  
     }
   newSize = (3*oldSize)/2; 
   if (newSize < 100) newSize = 100; 
   fprintf(stderr,msg1); 
   fprintf(stderr,"size was %d.\n",oldSize); 
   if (yyyPermitUserAlloc) 
      msg2 = "     Try -Y%c%d option.\n"; 
      else 
      msg2 = "     Have to modify evaluator:  -Y%c%d.\n"; 
   fprintf(stderr,msg2,which,newSize); 
   exit(-1); 
  }



void yyySignalEnts(node,startP,stopP) 
  register yyyGNT *node; 
  register yyyFT *startP,*stopP;  
  {register yyyGNT *dumNode; 

   while (startP < stopP)  
     {
      if (!(*startP)) dumNode = node;  
         else dumNode = (node->cL)[(*startP)-1];   
      if (!(--((dumNode->refCountList)[*(startP+1)]
              ) 
           )
         ) 
         { 
          if (++yyyRSTop == yyyAfterRS) 
             {yyyHandleOverflow(yyyRSof); 
              break; 
             }
          yyyRSTop->node = dumNode; 
          yyyRSTop->whichSym = *startP;  
          yyyRSTop->wa = *(startP+1);  
         }  
      startP += 2;  
     }  
  } 




#define yyyCeiling(num,inc) (((inc) * ((num)/(inc))) + (((num)%(inc))?(inc):0)) 



int yyyAlignSize = 8;
int yyyNdSz[20];

int yyyNdPrSz[20];

typedef int yyyCopyType;

int yyyNdCopySz[20];
long yyyBiggestNodeSize = 0;

void yyyNodeSizeCalc()
  {int i;
   yyyGNSz = yyyCeiling(yyyGNSz,yyyAlignSize); 
   yyyNdSz[0] = 0;
   yyyNdSz[1] = sizeof(struct yyyT1);
   yyyNdSz[2] = sizeof(struct yyyT2);
   yyyNdSz[3] = sizeof(struct yyyT3);
   yyyNdSz[4] = sizeof(struct yyyT4);
   yyyNdSz[5] = sizeof(struct yyyT5);
   yyyNdSz[6] = sizeof(struct yyyT6);
   yyyNdSz[7] = sizeof(struct yyyT7);
   yyyNdSz[8] = sizeof(struct yyyT8);
   yyyNdSz[9] = sizeof(struct yyyT9);
   yyyNdSz[10] = sizeof(struct yyyT10);
   yyyNdSz[11] = sizeof(struct yyyT11);
   yyyNdSz[12] = sizeof(struct yyyT12);
   yyyNdSz[13] = sizeof(struct yyyT13);
   yyyNdSz[14] = sizeof(struct yyyT14);
   yyyNdSz[15] = sizeof(struct yyyT15);
   yyyNdSz[16] = sizeof(struct yyyT16);
   yyyNdSz[17] = sizeof(struct yyyT17);
   yyyNdSz[18] = sizeof(struct yyyT18);
   yyyNdSz[19] = sizeof(struct yyyT19);
   for (i=0;i<20;i++) 
       {yyyNdSz[i] = yyyCeiling(yyyNdSz[i],yyyAlignSize); 
        yyyNdPrSz[i] = yyyNdSz[i] + yyyGNSz;
        if (yyyBiggestNodeSize < yyyNdSz[i])
           yyyBiggestNodeSize = yyyNdSz[i];
        yyyNdCopySz[i] = yyyCeiling(yyyNdSz[i],sizeof(yyyCopyType)) / 
                         sizeof(yyyCopyType); 
       }
  }




void yyySolveAndSignal() {
register long yyyiDum,*yyypL;
register int yyyws,yyywa;
register yyyGNT *yyyRSTopN,*yyyRefN; 
register void *yyyRSTopNp; 


yyyRSTopNp = (yyyRSTopN = yyyRSTop->node)->parent;
yyyRefN= (yyyws = (yyyRSTop->whichSym))?((yyyGNT *)yyyRSTopNp):yyyRSTopN;
yyywa = yyyRSTop->wa; 
yyyRSTop--;
switch(yyyRefN->prodNum) {
case 1:  /***yacc rule 1***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP13)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(FUNCTION, (((yyyP2)(((char *)((yyyRefN->cL)[3]))+yyyGNSz))->ast), (((yyyP3)(((char *)((yyyRefN->cL)[5]))+yyyGNSz))->ast));
(((yyyP13)(((char *)yyyRSTopN)+yyyGNSz))->ast)->name = (((yyyP7)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->name);;
                  break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    }
  break;
  case 6:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 2:  /***yacc rule 2***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 3:  /***yacc rule 3***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 4:  /***yacc rule 4***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 5:  /***yacc rule 5***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP14)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(NOTEXPR, (((yyyP14)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ast), NULL);;
              break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 6:  /***yacc rule 6***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP14)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(MINUSEXPR, (((yyyP14)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ast), NULL);
              break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 7:  /***yacc rule 7***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP14)(((char *)yyyRSTopN)+yyyGNSz))->ast) = (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast);
              break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 8:  /***yacc rule 8***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 9:  /***yacc rule 9***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP11)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(ADDRWRITE, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), NULL);
            break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 10:  /***yacc rule 10***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newArgNode((((yyyP7)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->name));
(((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ast)->children[0] = (((yyyP2)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast);;
                   break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 11:  /***yacc rule 11***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 12:  /***yacc rule 12***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 13:  /***yacc rule 13***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP12)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(EXPRTERM, (((yyyP4)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ast), NULL);;
           break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 14:  /***yacc rule 14***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 15:  /***yacc rule 15***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP12)(((char *)yyyRSTopN)+yyyGNSz))->ast) = (((yyyP19)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast);
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 16:  /***yacc rule 16***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 17:  /***yacc rule 17***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP18)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(
  GUARDED,
  newChildNode(CONDITION, (((yyyP4)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), NULL),
 (((yyyP3)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));
(((yyyP18)(((char *)yyyRSTopN)+yyyGNSz))->ast)->dostat.name = (((yyyP16)(((char *)((yyyRefN->cL)[4]))+yyyGNSz))->name);
(((yyyP18)(((char *)yyyRSTopN)+yyyGNSz))->ast)->dostat.guardType = CONT;;
              break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  case 5:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 18:  /***yacc rule 18***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP18)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(
  GUARDED,
  newChildNode(CONDITION, (((yyyP4)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), NULL),
 (((yyyP3)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));
(((yyyP18)(((char *)yyyRSTopN)+yyyGNSz))->ast)->dostat.name = (((yyyP16)(((char *)((yyyRefN->cL)[4]))+yyyGNSz))->name);
(((yyyP18)(((char *)yyyRSTopN)+yyyGNSz))->ast)->dostat.guardType = BRK;;
              break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  case 5:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 19:  /***yacc rule 19***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(DOSTAT, (((yyyP1)(((char *)((yyyRefN->cL)[3]))+yyyGNSz))->ast), NULL);
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ast)->dostat.name = (((yyyP7)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->name);;
             break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 20:  /***yacc rule 20***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(DOSTAT, (((yyyP1)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ast), NULL);
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ast)->dostat.name = NULL;;
             break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 21:  /***yacc rule 21***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP19)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(FCALL, (((yyyP10)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast), NULL);
(((yyyP19)(((char *)yyyRSTopN)+yyyGNSz))->ast)->name = (((yyyP7)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->name);
               break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 22:  /***yacc rule 22***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP1)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(GUARDEDLIST, (((yyyP18)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP1)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));;
                  break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 23:  /***yacc rule 23***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 24:  /***yacc rule 24***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP17)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(MULTEXPR, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP17)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));;
               break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 25:  /***yacc rule 25***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP17)(((char *)yyyRSTopN)+yyyGNSz))->ast) = (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast);
               break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 26:  /***yacc rule 26***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP15)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(OREXPR, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP15)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));;
             break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 27:  /***yacc rule 27***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP15)(((char *)yyyRSTopN)+yyyGNSz))->ast) = (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast);
             break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 28:  /***yacc rule 28***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP4)(((char *)yyyRSTopN)+yyyGNSz))->ast) = (((yyyP14)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast);
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 29:  /***yacc rule 29***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP4)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(READEXPR, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), NULL);
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 30:  /***yacc rule 30***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP4)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(PLUSEXPR, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP8)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));;
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 31:  /***yacc rule 31***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP4)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(MULTEXPR, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP17)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));;
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 32:  /***yacc rule 32***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP4)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(OREXPR, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP15)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 33:  /***yacc rule 33***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP4)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(LESSEXPR, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP12)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 34:  /***yacc rule 34***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP4)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(EQUALEXPR, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP12)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 35:  /***yacc rule 35***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP8)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(PLUSEXPR, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP8)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));;
               break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 36:  /***yacc rule 36***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP8)(((char *)yyyRSTopN)+yyyGNSz))->ast) = (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast);
               break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 37:  /***yacc rule 37***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP9)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(RETURNSTAT,
	(((yyyP4)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ast),
	NULL);;
           break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 38:  /***yacc rule 38***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP9)(((char *)yyyRSTopN)+yyyGNSz))->ast) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast);
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 39:  /***yacc rule 39***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP9)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(VARDEF, (((yyyP4)(((char *)((yyyRefN->cL)[3]))+yyyGNSz))->ast), NULL);
(((yyyP9)(((char *)yyyRSTopN)+yyyGNSz))->ast)->name = (((yyyP7)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->name);;
           break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 40:  /***yacc rule 40***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP9)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(VARASSIGN, (((yyyP11)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP4)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 41:  /***yacc rule 41***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP9)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(TERMSTAT, (((yyyP12)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), NULL);
           break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 42:  /***yacc rule 42***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(STATS, (((yyyP9)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP3)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));
                break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 43:  /***yacc rule 43***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 44:  /***yacc rule 44***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP10)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(ARGEXPR, (((yyyP4)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), NULL);
                break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 45:  /***yacc rule 45***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP10)(((char *)yyyRSTopN)+yyyGNSz))->ast) = newChildNode(ARGEXPR, (((yyyP4)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ast), (((yyyP10)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ast));
                break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 46:  /***yacc rule 46***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
} /* switch */ 

if (yyyws)  /* the just-solved instance was inherited. */ 
   {if (yyyRSTopN->prodNum) 
       {yyyiDum = yyyIIEL[yyyIIIEL[yyyRSTopN->prodNum]] + yyywa;
        yyySignalEnts(yyyRSTopN,yyyEntL + yyyIEL[yyyiDum],
                                yyyEntL + yyyIEL[yyyiDum+1]
                     );
       }
   } 
   else     /* the just-solved instance was synthesized. */ 
   {if ((char *)yyyRSTopNp >= yyyNodeSpace) /* node has a parent. */ 
       {yyyiDum = yyyIIEL[yyyIIIEL[((yyyGNT *)yyyRSTopNp)->prodNum] + 
                          yyyRSTopN->whichSym 
                         ] + 
                  yyywa;
        yyySignalEnts((yyyGNT *)yyyRSTopNp,
                      yyyEntL + yyyIEL[yyyiDum],
                      yyyEntL + yyyIEL[yyyiDum+1] 
                     );
       } 
       else   /* node is still on the stack--it has no parent yet. */ 
       {yyypL = &(((struct yyyStackItem *)yyyRSTopNp)->solvedSAlist); 
        if (yyySSALCfreeList == yyyLambdaSSAL) 
           {yyySSALspace[yyyNewSSALC].next = *yyypL; 
            if ((*yyypL = yyyNewSSALC++) == yyySSALspaceSize) 
               yyyHandleOverflow(yyySSALof); 
           }  
           else
           {yyyiDum = yyySSALCfreeList; 
            yyySSALCfreeList = yyySSALspace[yyySSALCfreeList].next; 
            yyySSALspace[yyyiDum].next = *yyypL; 
            *yyypL = yyyiDum;  
           } 
        yyySSALspace[*yyypL].attrbNum = yyywa; 
       } 
   }

} /* yyySolveAndSignal */ 






#define condStg unsigned int conds;
#define yyyClearConds {yyyTST->conds = 0;}
#define yyySetCond(n) {yyyTST->conds += (1<<(n));}
#define yyyCond(n) ((yyyTST->conds & (1<<(n)))?1:0)



struct yyyTravStackItem {yyyGNT *node; 
                         char isReady;
                         condStg
                        };



void yyyDoTraversals()
{struct yyyTravStackItem *yyyTravStack,*yyyTST,*yyyAfterTravStack;
 register yyyGNT *yyyTSTn,**yyyCLptr1,**yyyCLptr2; 
 register int yyyi,yyyRL,yyyPass;

 if (!yyyYok) return;
 if ((yyyTravStack = 
                 ((struct yyyTravStackItem *) 
                  malloc((yyyTravStackMaxSize * 
                                  sizeof(struct yyyTravStackItem)
                                 )
                        )
                 )
     )
     == 
     (struct yyyTravStackItem *)NULL
    ) 
    {fprintf(stderr,"malloc error in traversal stack allocation\n"); 
     exit(-1); 
    } 

yyyAfterTravStack = yyyTravStack + yyyTravStackMaxSize; 
yyyTravStack++; 


for (yyyi=0; yyyi<1; yyyi++) {
yyyTST = yyyTravStack; 
yyyTST->node = yyyStack->node;
yyyTST->isReady = 0;
yyyClearConds

while(yyyTST >= yyyTravStack)
  {yyyTSTn = yyyTST->node;
   if (yyyTST->isReady)  
      {yyyPass = 1;
       goto yyyTravSwitch;
yyyTpop:
       yyyTST--;
      } 
      else 
      {yyyPass = 0;
       goto yyyTravSwitch;
yyyTpush:
       yyyTST->isReady = 1;  
       if (yyyTSTn->prodNum)
          if (yyyRL)
             {yyyCLptr2 = yyyTSTn->cL; 
              while 
                ((yyyCLptr2 != yyyNextCLspace)
                 &&
                 ((*yyyCLptr2)->parent == yyyTSTn) 
                )  
                {if (++yyyTST == yyyAfterTravStack)
                    yyyHandleOverflow(yyyTSof);
                    else
                    {yyyTST->node = *yyyCLptr2; 
                     yyyTST->isReady = 0; 
                     yyyClearConds
                    }
                 yyyCLptr2++; 
                } 
             } /* right to left */
             else  /* left to right */
             {yyyCLptr1 = yyyCLptr2 = yyyTSTn->cL; 
              while 
                ((yyyCLptr2 != yyyNextCLspace)
                 &&
                 ((*yyyCLptr2)->parent == yyyTSTn) 
                )  
                yyyCLptr2++; 
              while (yyyCLptr2-- > yyyCLptr1)
                if (++yyyTST == yyyAfterTravStack)
                   yyyHandleOverflow(yyyTSof);
                   else
                   {yyyTST->node = *yyyCLptr2; 
                    yyyTST->isReady = 0; 
                    yyyClearConds
                   }
             } /* left to right */
      } /* else */
   continue;
yyyTravSwitch:
				switch(yyyTSTn->prodNum)	{
case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

if (yyyCond(0) != yyyPass) { {
                 nodeptr root = (((yyyP13)(((char *)yyyTSTn)+yyyGNSz))->ast);
                 runCompilerPasses(root);
              }
          }
				break;
					}

break;
case 2:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 3:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 4:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 5:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 6:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 7:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 8:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 9:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 10:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 11:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 12:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 13:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 14:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 15:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 16:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 17:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 18:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 19:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 20:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 21:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 22:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 23:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 24:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 25:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 26:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 27:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 28:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 29:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 30:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 31:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 32:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 33:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 34:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 35:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 36:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 37:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 38:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 39:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 40:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 41:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 42:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

if (yyyCond(0) != yyyPass) { {
               //Useless ....nodeptr root = @stats.0.ast@;
               //invoke_burm(root->children[0]);
            }
        }
				break;
					}

break;
case 43:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 44:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 45:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 46:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
								} /* switch */ 
   if (yyyPass) goto yyyTpop; else goto yyyTpush; 
  } /* while */ 
 } /* for */ 
} /* yyyDoTraversals */ 

void yyyExecuteRRsection()  {
   int yyyi; 
   long yyynRefCounts; 
   long cycleSum = 0;
   long nNZrc = 0;

   if (!yyyYok) return; 
   yyynRefCounts = yyyNextRCLspace - yyyRefCountListSpace; 
   for (yyyi=0;yyyi<yyynRefCounts;yyyi++) 
     if (yyyRefCountListSpace[yyyi])
        {cycleSum += yyyRefCountListSpace[yyyi]; nNZrc++;} 
   if (nNZrc) 
      {
       fprintf(stderr,"\n\n\n**********\n");
       fprintf(stderr,
               "cycle detected in completed parse tree");
       fprintf(stderr,
               " after decoration.\n");
       fprintf(stderr,
         "searching parse tree for %d unsolved instances:\n",
               nNZrc
              );
       yyyUnsolvedInstSearchTravAux(yyyStackTop->node);
      }
   yyyDoTraversals();
} /* yyyExecuteRRsection */ 



yyyWAT yyyLRCIL[2] = {0,0,
};



void yyyYoxInit()                                  /*stock*/  
  { 

   yyyNodeSizeCalc(); 

   if ((yyyTermBuffer.snBufPtr = 
        (char *) malloc((yyyBiggestNodeSize + sizeof(yyyCopyType)))
       )  
       == 
       ((char *) NULL) 
      )   
      yyyfatal("malloc error in yyyTermBuffer allocation\n");  
  
  
   yyyNbytesStackStg = yyyMaxStackSize*sizeof(struct yyyStackItem); 
   yyyNbytesStackStg = ((yyyNbytesStackStg/yyyAlignSize)+1)*yyyAlignSize;  
   if ((yyyNodeAndStackSpace = 
        (char *) malloc((yyyNbytesStackStg + 
                                 yyyMaxNbytesNodeStg + 
                                 yyyGNSz + 
                                 yyyBiggestNodeSize + 
                                 sizeof(yyyCopyType) 
                                )
                       )
       )  
       == 
       ((char *) NULL) 
      )   
      yyyfatal("malloc error in ox node and stack space allocation\n");
   yyyStack = (struct yyyStackItem *) yyyNodeAndStackSpace; 
   yyyAfterStack = yyyStack + yyyMaxStackSize;  
   yyyNodeSpace = yyyNodeAndStackSpace + yyyNbytesStackStg;
   yyyAfterNodeSpace = yyyNodeSpace + yyyMaxNbytesNodeStg;
 
 
   if ((yyyRS = (struct yyyRSitem *) 
         malloc(((yyyRSmaxSize+1)*sizeof(struct yyyRSitem)))
       )  
       == 
       ((struct yyyRSitem *) NULL) 
      )   
      yyyfatal("malloc error in ox ready set space allocation\n");  
   yyyRS++; 
   yyyAfterRS = yyyRS + yyyRSmaxSize; 

 
   if ((yyyChildListSpace = 
        (yyyGNT **) malloc((yyyMaxNchildren*sizeof(yyyGNT *)))
       )  
       == 
       ((yyyGNT **) NULL) 
      )   
      yyyfatal("malloc error in ox child list space allocation\n");  
   yyyAfterChildListSpace = yyyChildListSpace + yyyMaxNchildren; 

 
   if ((yyyRefCountListSpace = 
        (yyyRCT *) malloc((yyyMaxNrefCounts * sizeof(yyyRCT)))
       )  
       == 
       ((yyyRCT *) NULL) 
      )   
      yyyfatal("malloc error in ox reference count list space allocation\n");  
   yyyAfterRefCountListSpace = yyyRefCountListSpace + yyyMaxNrefCounts;  
  
 
   if ((yyySSALspace = (struct yyySolvedSAlistCell *) 
          malloc(((yyySSALspaceSize+1) * 
                          sizeof(struct yyySolvedSAlistCell))
                         ) 
       ) 
       == 
       ((struct yyySolvedSAlistCell *) NULL) 
      ) 
      yyyfatal("malloc error in stack solved list space allocation\n"); 
  } /* yyyYoxInit */ 



void yyyYoxReset() 
  { 
   yyyTermBuffer.isEmpty = 1; 
   yyyStackTop = yyyStack; 
   while (yyyStackTop != yyyAfterStack) 
     (yyyStackTop++)->solvedSAlist = yyyLambdaSSAL; 
   yyyStackTop = yyyStack - 1; 
   yyyNextNodeSpace = yyyNodeSpace; 
   yyyRSTop = yyyRS - 1; 
   yyyNextCLspace = yyyChildListSpace;
   yyyNextRCLspace = yyyRefCountListSpace; 
  }  



void yyyDecorate() 
  { 
   while (yyyRSTop >= yyyRS) 
      yyySolveAndSignal();  
  } 



void yyyShift() 
  {yyyRCT *rcPdum; 
   register yyyCopyType *CTp1,*CTp2,*CTp3; 
   register yyyWAT *startP,*stopP;  

   if ((++yyyStackTop) == yyyAfterStack) 
      yyyHandleOverflow(yyySof);
   CTp2 = (yyyCopyType *)(yyyStackTop->oldestNode = 
                          yyyStackTop->node = 
                          (yyyGNT *)yyyNextNodeSpace 
                         ); 
   yyyTermBuffer.isEmpty = 1;
   ((yyyGNT *)CTp2)->parent = (void *)yyyStackTop; 
   ((yyyGNT *)CTp2)->cL = yyyNextCLspace;  
   rcPdum = ((yyyGNT *)CTp2)->refCountList = yyyNextRCLspace;  
   ((yyyGNT *)CTp2)->prodNum = 0; 
   if ((yyyNextRCLspace += yyyTermBuffer.nAttrbs) 
       > 
       yyyAfterRefCountListSpace 
      ) 
      yyyHandleOverflow(yyyRCof); 
   startP = yyyTermBuffer.startP;  
   stopP = yyyTermBuffer.stopP;  
   while (startP < stopP) rcPdum[*(startP++)] = 0; 
   if ((yyyNextNodeSpace += yyyNdPrSz[yyyTermBuffer.typeNum]) 
       > 
       yyyAfterNodeSpace 
      ) 
      yyyHandleOverflow(yyyNSof);  
   CTp1 = (yyyCopyType *)(yyyTermBuffer.snBufPtr); 
   CTp2 = (yyyCopyType *)(((char *)CTp2) + yyyGNSz); 
   CTp3 = CTp2 + yyyNdCopySz[yyyTermBuffer.typeNum]; 
   while (CTp2 < CTp3) *CTp2++ = *CTp1++; 
  } 



void yyyGenIntNode() 
  {register yyyWST i;
   register struct yyyStackItem *stDum;  
   register yyyGNT *gnpDum; 

   if ((stDum = (yyyStackTop -= (yyyRHSlength-1))) >= yyyAfterStack) 
      yyyHandleOverflow(yyySof);
   yyySTsn = ((char *)(yyySTN = (yyyGNT *)yyyNextNodeSpace)) + yyyGNSz; 
   yyySTN->parent       =  (void *)yyyStackTop;  
   yyySTN->cL           =  yyyNextCLspace; 
   yyySTN->refCountList =  yyyNextRCLspace; 
   yyySTN->prodNum      =  yyyProdNum; 
   if ((yyyNextCLspace+yyyRHSlength) > yyyAfterChildListSpace) 
      yyyHandleOverflow(yyyCLof); 
   for (i=1;i<=yyyRHSlength;i++) 
     {gnpDum = *(yyyNextCLspace++) = (stDum++)->node;  
      gnpDum->whichSym = i;  
      gnpDum->parent = (void *)yyyNextNodeSpace; 
     } 
   if ((yyyNextRCLspace += yyyNattrbs) > yyyAfterRefCountListSpace) 
      yyyHandleOverflow(yyyRCof); 
   if ((yyyNextNodeSpace += yyyNdPrSz[yyyTypeNum]) > yyyAfterNodeSpace) 
      yyyHandleOverflow(yyyNSof);  
  } 



#define yyyDECORfREQ 50 



void yyyAdjustINRC(startP,stopP) 
  register yyyFT *startP,*stopP;
  {yyyWST i;
   long SSALptr,SSALptrHead,*cPtrPtr; 
   long *pL; 
   struct yyyStackItem *stDum;  
   yyyGNT *gnpDum; 
   long iTemp;
   register yyyFT *nextP;
   static unsigned short intNodeCount = yyyDECORfREQ;

   nextP = startP;
   while (nextP < stopP) 
     {if ((*nextP) == yyyR)  
         {(yyySTN->refCountList)[*(nextP+1)] = *(nextP+2);
         } 
         else 
         {(((yyySTN->cL)[*nextP])->refCountList)[*(nextP+1)] = *(nextP+2);
         } 
      nextP += 3;  
     }
   pL = yyyIIEL + yyyIIIEL[yyyProdNum]; 
   stDum = yyyStackTop;  
   for (i=1;i<=yyyRHSlength;i++) 
     {pL++; 
      SSALptrHead = SSALptr = *(cPtrPtr = &((stDum++)->solvedSAlist)); 
      if (SSALptr != yyyLambdaSSAL) 
         {*cPtrPtr = yyyLambdaSSAL; 
          do 
            {
             iTemp = (*pL+yyySSALspace[SSALptr].attrbNum);
             yyySignalEnts(yyySTN,
                           yyyEntL + yyyIEL[iTemp],
                           yyyEntL + yyyIEL[iTemp+1]
                          );  
             SSALptr = *(cPtrPtr = &(yyySSALspace[SSALptr].next)); 
            } 
            while (SSALptr != yyyLambdaSSAL);  
          *cPtrPtr = yyySSALCfreeList;  
          yyySSALCfreeList = SSALptrHead;  
         } 
     } 
   nextP = startP + 2;
   while (nextP < stopP) 
     {if (!(*nextP))
         {if ((*(nextP-2)) == yyyR)  
             {pL = &(yyyStackTop->solvedSAlist); 
              if (yyySSALCfreeList == yyyLambdaSSAL) 
                 {yyySSALspace[yyyNewSSALC].next = *pL; 
                  if ((*pL = yyyNewSSALC++) == yyySSALspaceSize) 
                     yyyHandleOverflow(yyySSALof); 
                 }  
                 else
                 {iTemp = yyySSALCfreeList; 
                  yyySSALCfreeList = yyySSALspace[yyySSALCfreeList].next; 
                  yyySSALspace[iTemp].next = *pL; 
                  *pL = iTemp;  
                 } 
              yyySSALspace[*pL].attrbNum = *(nextP-1); 
             } 
             else 
             {if ((gnpDum = (yyySTN->cL)[*(nextP-2)])->prodNum != 0)
                 {
                  iTemp = yyyIIEL[yyyIIIEL[gnpDum->prodNum]] + *(nextP-1);
                  yyySignalEnts(gnpDum, 
                                yyyEntL + yyyIEL[iTemp],  
                                yyyEntL + yyyIEL[iTemp+1] 
                               );    
                 }  
             } 
         } 
      nextP += 3; 
     } 
   yyyStackTop->node = yyySTN;
   if (!yyyRHSlength) yyyStackTop->oldestNode = yyySTN; 
   if (!--intNodeCount) 
      {intNodeCount = yyyDECORfREQ; 
       yyyDecorate(); 
      } 
  } 



void yyyPrune(prodNum) 
  long prodNum;
  {  
   int i,n; 
   register char *cp1,*cp2;  
   register yyyRCT *rcp1,*rcp2,*rcp3;  
   long cycleSum = 0;
   long nNZrc = 0;
   yyyRCT *tempNextRCLspace;
   
   yyyDecorate();
   tempNextRCLspace = yyyNextRCLspace;
   yyyNextRCLspace = 
     (rcp1 = rcp2 = (yyyStackTop->oldestNode)->refCountList) + yyyNattrbs;
   rcp3 = (yyyStackTop->node)->refCountList; 
   while (rcp2 < rcp3) 
     if (*rcp2++) {cycleSum += *(rcp2 - 1); nNZrc++;} 
   if (nNZrc) 
      {
       fprintf(stderr,"\n\n\n----------\n");
       fprintf(stderr,
         "cycle detected during pruning of a subtree\n");
       fprintf(stderr,
         "  at whose root production %d is applied.\n",prodNum);
       yyyNextRCLspace = tempNextRCLspace; 
       fprintf(stderr,
         "prune aborted: searching subtree for %d unsolved instances:\n",
               nNZrc
              );
       yyyUnsolvedInstSearchTrav(yyyStackTop->node);
       return; 
      }
   for (i=0;i<yyyNattrbs;i++) rcp1[i] = rcp3[i]; 
   yyyNextCLspace = (yyyStackTop->oldestNode)->cL; 
   yyyNextNodeSpace = (char *)(yyyStackTop->oldestNode) + 
                      (n = yyyNdPrSz[yyyTypeNum]);
   cp1 = (char *)yyyStackTop->oldestNode; 
   cp2 = (char *)yyyStackTop->node; 
   for (i=0;i<n;i++) *cp1++ = *cp2++; 
   yyyStackTop->node = yyyStackTop->oldestNode; 
   (yyyStackTop->node)->refCountList = rcp1; 
   (yyyStackTop->node)->cL = yyyNextCLspace; 
  } 



void yyyGenLeaf(nAttrbs,typeNum,startP,stopP) 
  int nAttrbs,typeNum; 
  yyyWAT *startP,*stopP; 
  {
   if  (!(yyyTermBuffer.isEmpty)) yyyShift(); 
   yyyTermBuffer.isEmpty = 0;
   yyyTermBuffer.typeNum = typeNum; 
   yyyTermBuffer.nAttrbs = nAttrbs; 
   yyyTermBuffer.startP = startP; 
   yyyTermBuffer.stopP = stopP; 
   
  } 



void yyyerror()
  {yyyYok = 0; 
  } 



/* read the command line for changes in sizes of 
                  the evaluator's data structures */
void yyyCheckForResizes(argc,argv) 
  int argc; 
  char *argv[]; 
  {int i; 
   long dum; 
 
   if (!yyyPermitUserAlloc) return; 
   for (i=1;i<argc;i++) 
     { 
      if ((argv[i][0] != '-') || (argv[i][1] != 'Y')) continue; 
      if (strlen(argv[i]) < 4) goto yyyErrO1; 
      if (sscanf(argv[i]+3,"%d",&dum) != 1) goto yyyErrO1;
      if (dum < 2) dum = 2;
      switch (argv[i][2]) 
        {case yyyNSof:   yyyMaxNbytesNodeStg = dum; break; 
         case yyyRCof:   yyyMaxNrefCounts    = dum; break; 
         case yyyCLof:   yyyMaxNchildren     = dum; break; 
         case yyySof:    yyyMaxStackSize     = dum; break; 
         case yyySSALof: yyySSALspaceSize    = dum; break; 
         case yyyRSof:   yyyRSmaxSize        = dum; break; 
         case yyyTSof:   yyyTravStackMaxSize = dum; break; 
         default : goto yyyErrO1; 
        }
      continue;  
   yyyErrO1 : fprintf(stderr,"invalid command line option: %s\n",
                             argv[i] 
                     ); 
     } 
  } 
   
   
   


#define yyyLastProdNum 46


#define yyyNsorts 19


int yyyProdsInd[] = {
   0,
   0,   9,  10,  12,  13,  16,  19,  21,  23,  26,
  30,  32,  33,  37,  39,  41,  43,  49,  55,  61,
  65,  70,  74,  75,  79,  81,  85,  87,  89,  92,
  96, 100, 104, 108, 112, 116, 118, 121, 123, 128,
 132, 134, 138, 139, 141, 145,
 146,
};


int yyyProds[][2] = {
{1045,  13},{1045,  13},{ 619,   7},{ 297,   0},{  52,   2},
{ 681,   0},{  95,   3},{ 124,   0},{ 450,   0},{1045,  13},
{ 733,  16},{ 619,   7},{ 733,  16},{ 428,  14},{1165,   0},
{ 428,  14},{ 428,  14},{ 258,   0},{ 428,  14},{ 428,  14},
{1029,  12},{ 318,  11},{ 619,   7},{ 318,  11},{1029,  12},
{ 998,   0},{  52,   2},{ 619,   7},{1203,   0},{  52,   2},
{  52,   2},{ 619,   7},{  52,   2},{1029,  12},{ 297,   0},
{ 462,   4},{ 681,   0},{1029,  12},{ 717,   6},{1029,  12},
{ 473,  19},{1029,  12},{ 619,   7},{  70,  18},{ 462,   4},
{  48,   0},{  95,   3},{ 634,   0},{ 733,  16},{  70,  18},
{ 462,   4},{  48,   0},{  95,   3},{ 646,   0},{ 733,  16},
{ 226,   5},{ 619,   7},{ 597,   0},{ 702,   0},{ 880,   1},
{ 124,   0},{ 226,   5},{ 702,   0},{ 880,   1},{ 124,   0},
{ 473,  19},{ 619,   7},{ 297,   0},{  65,  10},{ 681,   0},
{ 880,   1},{  70,  18},{ 450,   0},{ 880,   1},{ 880,   1},
{ 451,  17},{1029,  12},{1126,   0},{ 451,  17},{ 451,  17},
{1029,  12},{ 426,  15},{1029,  12},{ 737,   0},{ 426,  15},
{ 426,  15},{1029,  12},{ 462,   4},{ 428,  14},{ 462,   4},
{1029,  12},{ 998,   0},{ 462,   4},{1029,  12},{ 284,   0},
{ 382,   8},{ 462,   4},{1029,  12},{1126,   0},{ 451,  17},
{ 462,   4},{1029,  12},{ 737,   0},{ 426,  15},{ 462,   4},
{1029,  12},{ 431,   0},{1029,  12},{ 462,   4},{1029,  12},
{ 705,   0},{1029,  12},{ 382,   8},{1029,  12},{ 284,   0},
{ 382,   8},{ 382,   8},{1029,  12},{ 278,   9},{ 838,   0},
{ 462,   4},{ 278,   9},{ 226,   5},{ 278,   9},{ 933,   0},
{ 619,   7},{ 225,   0},{ 462,   4},{ 278,   9},{ 318,  11},
{ 225,   0},{ 462,   4},{ 278,   9},{1029,  12},{  95,   3},
{ 278,   9},{ 450,   0},{  95,   3},{  95,   3},{  65,  10},
{ 462,   4},{  65,  10},{ 462,   4},{1203,   0},{  65,  10},
{  65,  10},
};


int yyySortsInd[] = {
  0,
  0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
 10, 11, 12, 13, 14, 15, 16, 17, 18,
 19,
};


int yyySorts[] = {
 1058, 1058, 1058, 1058, 1058,  793,  381, 1058, 1058, 1058,
 1058, 1058, 1058, 1058, 1058,  381, 1058, 1058, 1058,
};



char *yyyStringTab[] = {
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"root",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"ADDRWRITE",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"ARROWR",0,
0,0,"parameterDef",0,0,
0,0,0,0,0,
0,0,0,0,0,
"arguments","LESSEXPR",0,0,0,
"guarded","FCALL","READEXPR",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"stats",0,0,0,0,
"MINUSEXPR",0,0,0,0,
"VARASSIGN",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"y",0,"END",
0,"PLUSEXPR",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"NOTEXPR",0,0,
0,0,0,0,0,
0,"EQUALEXPR",0,"ARGEXPR",0,
0,0,0,0,0,
0,0,0,0,0,
0,"OREXPR",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"MULTEXPR",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"NULL",0,0,
"ASSIGN","dostat",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"MINUS","ENDGUARD",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"stat",0,
0,0,0,0,"PLUS",
0,0,0,0,0,
0,0,0,0,0,
0,0,"BRACEL",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"lexpr",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"LASTARG",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"T_NAME",
0,0,0,0,0,
0,"name","plusexpr",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"strdup",0,0,0,
0,0,0,0,0,
0,"orexpr",0,"preexpr",0,
0,"LESS",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"SEMIC","multexpr",0,0,0,
0,0,0,0,0,
0,0,"expr",0,0,
0,0,0,"CONT",0,
0,0,0,"funcCall",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"COLON",0,0,
0,"CONDITION","BRK","children",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"ID",
0,0,0,0,0,
"GUARDEDLIST",0,0,0,0,
0,0,0,0,"CONTINUE",
0,0,0,0,0,
0,0,0,0,0,
0,"BREAK",0,0,0,
0,"FUNCTION",0,0,0,
0,0,0,"codegen",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"BRACER",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"DO",0,0,
"EQUAL",0,0,0,0,
0,0,"T_AST",0,0,
0,0,"NUMBER",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"newNode","maybeid",0,
"newArgNode",0,"OR","newChildNode",0,
0,0,0,0,0,
0,"VARUSE",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"atol",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"T_VALUE",0,
0,"strtol",0,0,0,
0,0,0,"LEXER_ERROR",0,
0,0,0,"value",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"RETURN",0,
0,0,"CONSTTERM",0,"guardType",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"guardedlist",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"EXPRTERM",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"VAR",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"CIRCUMFLEX",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"yytext",0,
0,0,0,"VARDEF","term",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"program","GUARDED",0,0,0,
0,"runCompilerPasses",0,0,0,
0,0,0,"ast",0,
0,0,0,0,0,
0,0,0,0,0,
0,"STATS",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"STAR",0,0,0,
0,0,0,0,0,
0,0,0,0,"RETURNSTAT",
"TERMSTAT",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"NOT",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"DOSTAT",0,"COMMA",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"nodeptr",
0,0,0,0,0,
0,0,0,0,0,
0,
};



#define yyySizeofProd(num) (yyyProdsInd[(num)+1] - yyyProdsInd[(num)])

#define yyyGSoccurStr(prodNum,symPos) \
   (yyyStringTab[yyyProds[yyyProdsInd[(prodNum)] + (symPos)][0]])

#define yyySizeofSort(num) (yyySortsInd[(num)+1] - yyySortsInd[(num)])

#define yyySortOf(prodNum,symPos) \
  (yyyProds[yyyProdsInd[(prodNum)] + (symPos)][1]) 

#define yyyAttrbStr(prodNum,symPos,attrbNum)                      \
  (yyyStringTab[yyySorts[yyySortsInd[yyySortOf(prodNum,symPos)] + \
                         (attrbNum)                               \
                        ]                                         \
               ]                                                  \
  )



void yyyShowProd(i)
  int i;
  {int j,nSyms;

   nSyms = yyySizeofProd(i);
   for (j=0; j<nSyms; j++)
     {
      fprintf(stderr,"%s",yyyGSoccurStr(i,j));
      if (j == 0) fprintf(stderr," : "); else fprintf(stderr," ");
     }
   fprintf(stderr,";\n");
  }



void yyyShowProds()
  {int i; for (i=1; i<=yyyLastProdNum; i++) yyyShowProd(i);}



void yyyShowSymsAndSorts()
  {int i; 

   for (i=1; i<=yyyLastProdNum; i++) 
     {int j, nSyms;

      fprintf(stderr,
              "\n\n\n---------------------------------- %3.1d\n",i);
      /* yyyShowProd(i); */ 
      nSyms = yyySizeofProd(i); 
      for (j=0; j<nSyms; j++) 
        {int k, sortSize;

         fprintf(stderr,"%s\n",yyyGSoccurStr(i,j));
         sortSize = yyySizeofSort(yyySortOf(i,j));
         for (k=0; k<sortSize; k++) 
            fprintf(stderr,"  %s\n",yyyAttrbStr(i,j,k));
         if (j == 0) fprintf(stderr,"->\n"); 
              else 
              fprintf(stderr,"\n"); 
        }
     }
  }



void yyyCheckNodeInstancesSolved(np)
  yyyGNT *np;
  {int mysort,sortSize,i,prodNum,symPos,inTerminalNode;
   int nUnsolvedInsts = 0;

   if (np->prodNum != 0)
     {inTerminalNode = 0;
      prodNum = np->prodNum;
      symPos = 0;
     }
   else
     {inTerminalNode = 1;
      prodNum = ((yyyGNT *)(np->parent))->prodNum;
      symPos = np->whichSym;
     }
   mysort = yyySortOf(prodNum,symPos);
   sortSize = yyySizeofSort(mysort);
   for (i=0; i<sortSize; i++)
     if ((np->refCountList)[i] != 0) nUnsolvedInsts += 1;
   if (nUnsolvedInsts)
     {fprintf(stderr,
      "\nFound node that has %d unsolved attribute instance(s).\n",
              nUnsolvedInsts
             );
      fprintf(stderr,"Node is labeled \"%s\".\n",
             yyyGSoccurStr(prodNum,symPos));
      if (inTerminalNode)
        {fprintf(stderr,
                 "Node is terminal.  Its parent production is:\n  ");
         yyyShowProd(prodNum);
        }
      else
        {fprintf(stderr,"Node is nonterminal.  ");
         if (((char *)(np->parent)) >= yyyNodeSpace)
           {fprintf(stderr,
                    "Node is %dth child in its parent production:\n  ",
                   np->whichSym
                  );
            yyyShowProd(((yyyGNT *)(np->parent))->prodNum);
           }
         fprintf(stderr,
                 "Node is on left hand side of this production:\n  ");
         yyyShowProd(np->prodNum);
        }
      fprintf(stderr,"The following instances are unsolved:\n");
      for (i=0; i<sortSize; i++)
        if ((np->refCountList)[i] != 0)
          fprintf(stderr,"     %-16s still has %1d dependencies.\n",
                  yyyAttrbStr(prodNum,symPos,i),(np->refCountList)[i]);
     }
  }



void yyyUnsolvedInstSearchTravAux(pNode)
  yyyGNT *pNode;
  {yyyGNT **yyyCLpdum;
   int i;
  
   yyyCheckNodeInstancesSolved(pNode); 
   yyyCLpdum = pNode->cL;
   while
     ((yyyCLpdum != yyyNextCLspace) && ((*yyyCLpdum)->parent == pNode))
     {
      yyyUnsolvedInstSearchTravAux(*yyyCLpdum);
      yyyCLpdum++;
     }
  }



void yyyUnsolvedInstSearchTrav(pNode)
  yyyGNT *pNode;
  {yyyGNT **yyyCLpdum;
   int i;
  
   yyyCLpdum = pNode->cL;
   while
     ((yyyCLpdum != yyyNextCLspace) && ((*yyyCLpdum)->parent == pNode))
     {
      yyyUnsolvedInstSearchTravAux(*yyyCLpdum);
      yyyCLpdum++;
     }
  }



