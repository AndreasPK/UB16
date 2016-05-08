#include "tree.h"
#include <assert.h>


const char* regNames[] = { /*parameters*/ "%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9",
  /*general registers*/ "%rax", "%r10", "%r11", "TooManyRegistersUsed", };

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

int registers[9];

int newReg()
{
  for(int i = 0; i < 9; i++)
  {
    if(registers[i] == 0)
    {
      registers[i] = 1;
      printf("Allocation r%d\n", i);
      return i;
    }
  }
  assert(0);
}

void freeReg(int id)
{
  if(id == -1)
    return;
  printf("Freeing r%d\n", id);
  if(registers[id] == 0)
  {
    assert(0);
  }

  registers[id] = 0;
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

