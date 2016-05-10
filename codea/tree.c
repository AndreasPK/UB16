#include "tree.h"
#include <assert.h>


const char* regNames[] = { /*parameters*/ "%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9",
  /*general registers*/ "%r10", "%r11", "TooManyRegistersUsed", };
#define REG_COUNT (8)

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
  for(int i = 0; i < REG_COUNT; i++)
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
  if(id == -1)
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

