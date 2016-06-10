#ifndef _FUTREE
#define _FUTREE

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/queue.h>
#include <assert.h>

#ifndef _BURM_WTF
typedef struct burm_state *STATEPTR_TYPE;
#endif

extern const char* regNames[];

//Symbol handling.
enum { ST_ANY = 0, ST_LABEL, ST_VAR };

enum variableLocation { VAR_STACK = 0, VAR_REG };

typedef struct symList
{
  struct symList *next;
  const char* name; //Name of the variable
  int ssaID;
  union {
    struct {
      enum variableLocation location;
      union {
        int reg; //Register index the variable is stored in.
        int offset; //Offset to ebp
      };
    } pos;
    int labelID;
  };
  int type; //Label or Variable
  int blockID; //Origin block. Invalid after leaving of this block.

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
  EXPRTERM, //10
  CONSTTERM,
  CALLTERM,
  VARTERM,
  LESSEXPR,
  READEXPR,
  EQUALEXPR,
  OREXPR,
  MULTEXPR,
  PLUSEXPR,
  MINUSEXPR, //20
  NOTEXPR,
  VARUSE,
  GUARDEDLIST,
  GUARDED,
  FCALL,
  ARGEXPR,
  LASTARG,
  EXPR,
  ADDRWRITE,
  CONT, //30
  BRK,
  ENDGUARD,
  CONDITION,
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
    struct { //Do stat related information
      union { //Either label ID for dostat or reference to surrounding dostats.
        int labelID;
        struct tNode* doStat;
      };
      const char* name; //Label name or NULL
      int guardID; //Guard ID for guards.
      int guardType; //BRK or CONT
    } dostat;
  };
  int reg; //Register for result/immediate value.

  union arg1{
    long l;
  } arg1;

  union arg2{
    long l;
  } arg2;

  long int ssaID;
  int blockID;

}* nodeptr;

typedef struct tNode tNode;

nodeptr newNode(int op);
nodeptr newArgNode(const char* name); //Create a new parameter node.
nodeptr newChildNode(int op, nodeptr left, nodeptr righ);


///Create a copy of the symbol list
psymList symClone(const psymList head);

///Adds the symbol to the symbol list, returning a "new" symbol table.
psymList symAdd(const psymList head, psymList symbol);
psymList symFind(const psymList head, const char* name);

//Updates symbols and checks for errors on the given AST.
nodeptr updateAstSymbols(nodeptr tree);
//BURM definitions


typedef struct regInfo
{
  int regNumber;
  int is_argument;
}* pregInfo;

extern struct regInfo* registers[];

int newReg(void);
int newArgReg(void);
void freeReg(int id);
void clearReg();
struct regInfo** pushRegisters(int* count);
void popRegisters(struct regInfo **pushed);


#define NODEPTR_TYPE   nodeptr
#define OP_LABEL(p)    ((p)->op)
#define LEFT_CHILD(p)  ((p)->children[0])
#define RIGHT_CHILD(p) ((p)->children[1])
#define STATE_LABEL(p) ((p)->state)
#define PANIC          printf

//Called with function node, enumerates unique block id's
void assignBlock(NODEPTR_TYPE node);

void generateBlock(NODEPTR_TYPE statements);
void generateDoStat(NODEPTR_TYPE dostat);
void generateCall(NODEPTR_TYPE call);
void invoke_burm(NODEPTR_TYPE root);

int runCompilerPasses(NODEPTR_TYPE root);

//Assign a id for a storable term.
long int assignSSA(NODEPTR_TYPE node);
int mapSSA(NODEPTR_TYPE node);
void freeSSA(NODEPTR_TYPE node);
void clearSSAMapping(void);

//Free all register assignments originating from the given node's block.
void freeBlockSSA(NODEPTR_TYPE bnode);

int assignBlocks(NODEPTR_TYPE root);

#endif
