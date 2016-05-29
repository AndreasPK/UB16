#include "passes.h"
#include <assert.h>


const char* regNames[] = { /*immediate val*/ "%rax", /*parameters*/ "%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9",
  /*general registers*/ "%r10", "%r11", "TooManyRegistersUsed", };
#define REG_COUNT (9)

//Called on each function node.
int runCompilerPasses(NODEPTR_TYPE root)
{
  //Assign block ids:
  assignBlock(root, -1000); //Block id argument is ignored at function node

  //Create and verify symbol tables.
  updateAstSymbols(root);

  //Reserve argument ids.
  //Reserve registers for arguments.
  clearReg();
  NODEPTR_TYPE arg = root->children[0];
  while(arg != NULL && arg->op != LASTARG)
  {
    assignSSA(arg);
    mapSSA(arg);
    psymList s = symFind(arg->symbols, arg->name);
    s->reg = arg->reg;
    s->ssaID = arg->ssaID;
    fprintf(stderr, "Assigned par %s to ssa:%ld reg:%d \n", arg->name, s->ssaID, s->reg);
    arg = arg->children[0];
  }
  assert(arg == NULL || arg->op == LASTARG);


  //Generate code for this function. (Function label & argument reserving)
  invoke_burm(root);

  //Run codegen for Function statements.
  createProgramCode(root->children[1]);
}

///Create a copy of the symbol list
psymList symClone(psymList head)
{
  if(head == NULL)
    return NULL;


  psymList n, start;
  start = (psymList) malloc(sizeof(struct symList));
  n = start;
  while(head != NULL)
  {
    memcpy(n, head, sizeof(struct symList));
    head = head->next;
    if(head != NULL) {
      n->next = (psymList) malloc(sizeof(struct symList));
      n = n->next;
    }
    else
    {
      n->next == NULL;
      break;
    }
  }
  return start;
}

///Symbol is changed and should not be reused.
///Symbol is added to beginning of the list.
psymList symAdd(const psymList head, const psymList symbol)
{
  psymList s = (psymList) malloc(sizeof(struct symList));
  memcpy(s, symbol, sizeof(struct symList));
  s->next = head;
  return symbol;
}

psymList symFind(const psymList head, const char* name)
{
  psymList index = head;
  while(index != NULL)
  {
    if(strcmp(index->name, name) == 0)
      return index;
    index = index->next;
  }
  return NULL;
}

nodeptr newNode(int op)
{
  nodeptr n = (nodeptr) malloc(sizeof *n);
  memset(n, 0, sizeof(*n));
  n->op = op;
  return n;
}

nodeptr newArgNode(const char* name)
{
  nodeptr n = newNode(ARG);
  n->name = name;
  return n;
}

nodeptr newChildNode(int op, nodeptr left, nodeptr right)
{
  nodeptr n = newNode(op);
  n->children[0] = left;
  n->children[1] = right;
  return n;
}

typedef struct regInfo
{
  int regNumber;
  int is_argument;
}* pregInfo;

struct regInfo* registers[REG_COUNT];

int newReg()
{
  for(int i = 1; i < REG_COUNT; i++)
  {
    if(registers[i] == NULL)
    {
      pregInfo r = (pregInfo) malloc(sizeof(*r));
      memset(r, 0, sizeof(*r));
      r->regNumber = i;
      registers[i] = r;
      //printf("Allocation r%d\n", i);
      return i;
    }
  }
  fprintf(stderr, "Too many registers allocated!\n");
  assert(0);
}

int newArgReg(void)
{
  int reg = newReg();
  registers[reg]->is_argument = 1;
  return reg;
}

void freeReg(int id)
{
  if(id == -1 || id == 0)
    return;
  if(registers[id]->is_argument) {
    //printf("Keeping argument in register.\n");
    return;
  }

  //printf("Freeing r%d\n", id);
  if(registers[id] == NULL)
  {
    assert(0);
  }

  free(registers[id]);
  registers[id] = NULL;
}

void clearReg()
{
  memset(registers, 0, sizeof(registers));
}

void createProgramCode(NODEPTR_TYPE statements)
{
  if(statements == NULL)
    return;

  if(statements->children[0] != NULL)
    invoke_burm(statements->children[0]);

  createProgramCode(statements->children[1]);
}


/**
 * Single static assignment infrastructure. We can:
 * * Assign an id to a node.
 * * Map a nodes id to a register.
 * * Free a nodes register.
 *
 * Methods get called by burg while traversing the tree.
 * */
long int ssaID;

typedef struct ssaMapping{
  long int ssaID;
  int registerID;
  struct ssaMapping* next;
}* pRegMap;

pRegMap ssaMappings = NULL;

int mapSSA(NODEPTR_TYPE node)
{
  assert(node->ssaID != 0);
  pRegMap m = (pRegMap) malloc(sizeof(*m));
  m->ssaID = node->ssaID;
  m->registerID = newReg();
  m->next = 0;

  if(ssaMappings == NULL)
  {
    ssaMappings = m;
  }
  else
  {
    pRegMap index = ssaMappings;
    while(index->next != NULL)
    {
      index = index->next;
    }
    index->next = m;
  }
  node->reg = m->registerID;
  return m->registerID;
}

void freeSSA(NODEPTR_TYPE node)
{
  pRegMap index = ssaMappings;
  pRegMap prev;
  assert(index !=NULL);
  if(index->ssaID == node->ssaID)
  {
    freeReg(index->registerID);
    ssaMappings = index->next;
    return;
  }

  while(index->next != NULL)
  {
    prev = index;
    index = index->next;
    if(index->ssaID == node->ssaID)
    {
      prev->next = index->next;
      freeReg(index->registerID);
      free(index);
      return;
    }
  }
  if(index->ssaID == node->ssaID)
  {
    prev->next = NULL;
    freeReg(index->registerID);
    free(index);
    return;
  }
  assert(0);

}

void clearSSAMapping()
{
  if(ssaMappings == NULL)
    return;
  pRegMap next;
  do {
    next = ssaMappings->next;
    free(ssaMappings);
    ssaMappings = next;
  } while(ssaMappings != NULL);
  ssaMappings = NULL;
}

long int assignSSA(NODEPTR_TYPE node)
{
  node->ssaID = ++ssaID;
}


/* Block assignment */

int blockID = 0;

void assignBlock(NODEPTR_TYPE node, int blockID)
{
  if(node == NULL)
    return;

  switch(node->op)
  {
    case ARG: //Defines an argument (by name).
      assignBlock(LEFT_CHILD(node), blockID);
      break;
    case FUNCTION: 
      node->blockID = ++blockID;
      assignBlock(LEFT_CHILD(node), node->blockID);
      assignBlock(RIGHT_CHILD(node), node->blockID);
      break;
    case NOOP:
      assert(0);
      break;
    //case DOSTAT:
    //case VARDEF: default
    //default case VARASSIGN,
    //default case TERMSTAT,
    //default case STATS,
    //default case EXPRTERM,
    //default case CONSTTERM,
    //default case CALLTERM,
    //default case VARTERM,
    //default case LESSEXPR,
    //default case READEXPR,
    //default case EQUALEXPR,
    //default case OREXPR,
    //default case MULTEXPR,
    //default case PLUSEXPR,
    //default case MINUSEXPR,
    //default case NOTEXPR,
    //default case VARUSE,
    case GUARDEDLIST:
      node->blockID = ++blockID;
      assignBlock(LEFT_CHILD(node), node->blockID);
      assignBlock(RIGHT_CHILD(node), node->blockID);
      break;
    //default case GUARDED,
    //default case FCALL,
    //default case ARGEXPR,
    //default case LASTARG,
    //default case EXPR,
    //default case ADDRWRITE,
    default:
      assignBlock(LEFT_CHILD(node), node->blockID);
      assignBlock(RIGHT_CHILD(node), node->blockID);
      break;
  }

}
