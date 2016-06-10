#include "passes.h"
#include <assert.h>
#include <stdio.h>

const char* regNames[] = { /*immediate val*/ "%rax", /*parameters*/ "%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9",
  /*general registers*/ "%r10", "%r11", "T9", "T10", "T11", "T12", "T13" };
#define REG_COUNT (13)

int stackOffset = 0; //Number of bytes on the stackframe


//Called on each function node.
int runCompilerPasses(NODEPTR_TYPE root)
{
  //Assign block ids:
  assignBlock(root);

  //Create and verify symbol tables.
  //Adjust symbol block information
  updateAstSymbols(root);

  //Reserve argument ids.
  clearReg();
  NODEPTR_TYPE arg = root->children[0];
  while(arg != NULL && arg->op != LASTARG)
  {
    arg->reg = newReg();
    psymList s = symFind(arg->symbols, arg->name);
    s->pos.location = VAR_REG;
    s->pos.reg = arg->reg;
    s->blockID = arg->blockID;
    //fprintf(stderr, "Assigned par %s to ssa:%ld reg:%d(%s) \n", arg->name, s->ssaID, s->reg, regNames[s->reg]);
    arg = arg->children[0];
  }
  assert(arg == NULL || arg->op == LASTARG);


  //Generate code for this function. (Function label)
  invoke_burm(root);

  //Run codegen for Function statements.
  generateBlock(root->children[1]);
  puts("leave\n#Default return:\nret");
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

///head is changed and should not be reused.
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
  assert(name != NULL);
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

//Keeps a list of allocated registers. NULL for free registers.
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

/**
 * push all allocated registers to the stack. Return pointer to register information before register pushing.
 * Updates count to the number of registers saved to the stack.
 * All registers can be used for terms afterwards.
 * rax doesn't get pushed to the stack.
 * */
struct regInfo **pushRegisters(int* count)
{
  assert(count != NULL);

  pregInfo* pushed = (pregInfo*) malloc(sizeof (registers));
  memcpy(pushed, registers, sizeof(registers));
  *count == 0;
  for(int i = 1; i < REG_COUNT; i++)
  {
    if(registers[i] != NULL)
    {
      printf("push %s\n", regNames[i]);
      *count++;
      registers[i] = NULL;
    }
  }
  return pushed;
}

//Takes a pointer describing the information of previously pushed registers.
//Pops these registers from the stack.
//RAX doesn't get overwritten.
void popRegisters(pregInfo* pushed)
{
  memcpy(registers, pushed, sizeof(registers));
  for(int i = REG_COUNT-1; i > 0; i--)
  {
    if(pushed[i] != NULL)
    {
      printf("pop %s\n", regNames[i]);
    }
  }
  free(pushed);
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

//Move variable to stack, free variable register increase stack offset
void pushVariable(psymList var)
{
  assert(var->type == ST_VAR && var->pos.location == VAR_REG);
  printf("push %s #pushvar\n", regNames[var->pos.reg]);
  stackOffset++;
  var->pos.offset = stackOffset;
  var->pos.location = VAR_STACK;
}

void copyVariableToRegister(psymList var, int registerID)
{
  assert(var->type == ST_VAR && var->pos.location == VAR_STACK);
  printf("movq -%d(%%rbp), %s #var2reg\n", var->pos.offset*8, regNames[registerID]);
}

//Walk the tree of stats, invoking burg for each statement.
//Called on the STATS node.
void generateBlock(NODEPTR_TYPE statements)
{
  if(statements == NULL)
    return;

  NODEPTR_TYPE stat = statements->children[0];
  //Invoke burm for each statement.
  if(stat != NULL)
  {

    //Dostat special casing.
    if(stat->op == DOSTAT)
    {
      generateDoStat(stat);
    }
    else
    {
      //Generate code for this statement.
      invoke_burm(stat);
    }
  }

  NODEPTR_TYPE right = statements->children[1];
  if(right != NULL) {
    generateBlock(statements->children[1]);
  }
  else //right == NULL
  { //Last statement in block reached so free block specific registers.
    freeBlockSSA(statements);//Free variables of this block.
  }
}

void generateCall(NODEPTR_TYPE call)
{
  const char* name = call->name;
  assert(name != NULL);

  printf(".extern %s\n", name);

  int regCount = 0;
  call->reg = newReg();//Reserve register for function result.
  pregInfo *registers = pushRegisters(&regCount);

  //Execute argument setup
  NODEPTR_TYPE arg = call->children[0];
  while(arg != NULL)
  {
    arg->reg = newReg();
    invoke_burm(arg);
    arg = arg->children[1];
  }

  //Call function
  printf("call %s\n", name);

  popRegisters(registers);

  printf("movq %%rax, %s\n", regNames[call->reg]);
  //Move rax to call->reg

}

int guardID = 0;
int labelID = 0;

//Generate code for a do block
void generateDoStat(NODEPTR_TYPE dostat)
{
  assert(dostat->op == DOSTAT);

  char* label;
  const char* name = dostat->dostat.name;
  dostat->dostat.labelID = ++labelID;
  if(name != NULL)
  {
    asprintf(&label, "do_%s_%d", name, dostat->dostat.labelID);
    psymList s = symFind(dostat->symbols, name);
    s->labelID = dostat->dostat.labelID;
  }
  else
    asprintf(&label, "do_%d", dostat->dostat.labelID);


  //Start label
  printf("%s_start:\n", label);

  assert(dostat->children[0] != NULL);

  //Generate code for each guard statement
  for(NODEPTR_TYPE guardedlist = dostat->children[0]; guardedlist->op != ENDGUARD; guardedlist = guardedlist->children[1] )
  {
    /* Create the conditional jump followed by the code block terminated by the end guard label.
     * */
    NODEPTR_TYPE guarded = guardedlist->children[0];
    NODEPTR_TYPE condition = guarded->children[0];
    assert(condition->op == CONDITION);
    NODEPTR_TYPE stats = guarded->children[1];

    guarded->dostat.guardID = ++guardID;
    condition->dostat.guardID = guarded->dostat.guardID;
    invoke_burm(condition);
    generateBlock(stats);

    const char* name = guarded->dostat.name;
    char* targetLabel;
    if(name == NULL)
      targetLabel = label;
    else
    {
      psymList s = symFind(guarded->symbols, name);
      asprintf(&targetLabel, "do_%s_%d", name, s->labelID);
    }
    if(guarded->dostat.guardType == BRK)
    {
      printf("#BREAK\njmp %s_end\n", targetLabel);
    }
    else if(guarded->dostat.guardType == CONT)
    {
      printf("#CONTINUE\njmp %s_start\n", targetLabel);
    }
    printf("end_guard_%d:\n", guarded->dostat.guardID);

  }

  printf("%s_end:\n", label);
}

/**
 * assignment infrastructure. We can:
 * * Assign an id to a node.
 * * Map a nodes id to a register.
 * * Free a nodes register.
 *
 * Methods get called by burg while traversing the tree.
 * Basically not usefuel in how we actually allocate registers here, mistakes were made ....
 * */
long int ssaID;

typedef struct ssaMapping{
  long int ssaID;
  int registerID;
  struct ssaMapping* next;
}* pRegMap;

pRegMap ssaMappings = NULL;

//For each symbol defined in the nodes block free it's register.
void freeBlockSSA(NODEPTR_TYPE bnode)
{
  psymList s;
  s = bnode->symbols;
  while(1)
  {
    if(s == NULL)
      return;
    if(s->blockID == bnode->blockID && s->type == ST_VAR)
    {
      if(s->pos.location == VAR_REG)
        freeReg(s->pos.reg);
      else if(s->pos.location == VAR_STACK)
      {
        printf(
            "#remove var from stack"
            "subq $8, %%esp\n");
      }
    }
    s = s->next;
  }
}

/* Block assignment */

int blockID = 0;

void assignBlock(NODEPTR_TYPE node)
{
  if(node == NULL)
    return;

  switch(node->op)
  {
    case FUNCTION:
      node->blockID = ++blockID;
      break;
    case NOOP:
      assert(0);
      break;
    case GUARDEDLIST:
      node->blockID = ++blockID;
      break;
    default:
      break;
  }
  if(LEFT_CHILD(node))
  {
    LEFT_CHILD(node)->blockID = node->blockID;
    assignBlock(LEFT_CHILD(node));
  }
  if(RIGHT_CHILD(node))
  {
    RIGHT_CHILD(node)->blockID = node->blockID;
    assignBlock(RIGHT_CHILD(node));
  }

}
