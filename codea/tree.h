#ifndef _FUTREE
#define _FUTREE

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/queue.h>
#include <assert.h>

typedef struct burm_state *STATEPTR_TYPE;

extern const char* regNames[];

//Symbol handling.
enum { ST_ANY = 0, ST_LABEL, ST_VAR };

typedef struct symList
{
  struct symList *next;
  const char* name; //Name of the variable
  int reg; //Register index the variable is stored in.
  int type; //Label or Variable

  //Variable attributes
}* psymList;
typedef psymList psym;


//AST Node types
enum {
  ARG = 1, //Defines an argument (by name).
  FUNCTION, //Defines an Function
  NOOP,
  RETURNSTAT,
  DOSTAT,
  VARDEF,
  VARASSIGN,
  TERMSTAT,
  STATS,
  EXPRTERM,
  CONSTTERM,
  CALLTERM,
  VARTERM,
  LESSEXPR,
  READEXPR,
  EQUALEXPR,
  OREXPR,
  MULTEXPR,
  PLUSEXPR,
  MINUSEXPR,
  NOTEXPR,
  VARUSE,
  GUARDEDLIST,
  GUARDED,
  FCALL,
  ARGEXPR,
  LASTARG,
  EXPR,
};

///AST-Node
typedef struct tNode
{
  int op;
  struct tNode* children[2];
  STATEPTR_TYPE state;

  //List of defined, valid symbols
  psymList symbols;

  //AST Node extra data
  union {
    const char* name;
    long int value;
  };
  int reg; //Register for immediate value.

}* nodeptr;

typedef struct tNode tNode;

nodeptr newNode(int op);
nodeptr newArgNode(const char* name);
nodeptr newChildNode(int op, nodeptr left, nodeptr righ);


///Create a copy of the symbol list
psymList symClone(const psymList head);

///Adds the symbol to the symbol list, returning a "new" symbol table.
psymList symAdd(const psymList head, psymList symbol);
psymList symFind(const psymList head, const char* name);

//Updates symbols and checks for errors on the given AST.
nodeptr updateAstSymbols(nodeptr tree);
//BURM definitions

extern int registers[];

int newReg(void);
int freeReg(int id);
void clearReg();

#define NODEPTR_TYPE   nodeptr
#define OP_LABEL(p)    ((p)->op)
#define LEFT_CHILD(p)  ((p)->children[0])
#define RIGHT_CHILD(p) ((p)->children[1])
#define STATE_LABEL(p) ((p)->state)
#define PANIC          printf

void invoke_burm(NODEPTR_TYPE root);


#endif
