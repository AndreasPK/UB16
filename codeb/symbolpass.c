#include "passes.h"

//Updates the symbol table of an subtree
nodeptr updateArguments(nodeptr arg);

int getNextReg(psymList list);

void symPrint(psymList s)
{
    while(s != NULL)
    {
      printf("Symbol: %s , Type: %d\n", s->name, s->type);
      s = s->next;
    }
}

//Set symbol tables correctly for each node
nodeptr updateAstSymbols(nodeptr tree)
{
  //Empty tree is empty.
  if(tree == NULL)
    return NULL;

  //For a function create first parse argument symbols.
  if(tree->op == FUNCTION)
  {
    //Add parameters to function definitions
     nodeptr arguments = updateArguments(tree->children[0]);
    if(arguments != NULL) {
      tree->symbols = arguments->symbols;
    }
    else {
      tree->symbols = NULL;
    }
    //Pass symbols to righthand side of tree
    if(tree->children[1] != NULL)
    {
      tree->children[1]->symbols = tree->symbols;
    }
    //List symbols for debugging
    updateAstSymbols(tree->children[1]);
    return tree;
  }

  //For statement lists update left hand side, then transfer symbols to right side.
  if(tree->op == STATS)
  {
    assert(tree->children[0] != NULL);
    tree->children[0]->symbols = tree->symbols;
    //Update statement symbols based on current node
    nodeptr res = updateAstSymbols(tree->children[0]);

    //If there are following statements use update symbol list for those.
    if(tree->children[1] != NULL)
    {
      tree->children[1]->symbols = res->symbols;
      updateAstSymbols(tree->children[1]);
    }
    return tree;
  }

  //Variable definition: In it's expression don't use the symbol, but update for this node.
  if(tree->op == VARDEF)
  {
    psymList s = symFind(tree->symbols, tree->name);
    if(s != NULL)
    {
      fprintf(stderr, "Error, symbol %s already defined with type %d", tree->name, s->type);
      exit(3);
    }
    //During assignment symbol is not yet visible.
    tree->children[0]->symbols = tree->symbols;
    updateAstSymbols(tree->children[0]);

    //Define variable
    s = malloc(sizeof *s);
    s->name = tree->name;
    s->type = ST_VAR;
    s->blockID = tree->blockID;
    //s->reg = getNextReg(tree->symbols);
    s->next = tree->symbols;
    tree->symbols = s;
    return tree;
  }

  if(tree->op == VARUSE)
  {
    psymList s = symFind(tree->symbols, tree->name);
    if(s == NULL || s->type != ST_VAR)
    {
      fprintf(stderr, "Variable %s not defined as variable at this position.\n", tree->name);
      exit(3);
    }
  }

  //Do Statement check
  if(tree->op == DOSTAT)
  {
    psymList s;
    const char* name = tree->dostat.name;
    //If a label was provided check availability.
    if(name != NULL) {
      psymList s = symFind(tree->symbols, name);
      if(s != NULL) {
        fprintf(stderr, "Can't define label %s, already defined with type %d", s->name, s->type);
        exit(3);
      }

      //Allocate a new symbol table containing the label.
      s = (psymList) malloc(sizeof *s);
      memset(s, 0, sizeof(*s));
      s->name = name;
      s->type = ST_LABEL;
      s->reg = 666;
      s->next = tree->symbols;
      //We don't clean up labels when leaving a block so don't care about block id

      //Update symbol table for child nodes.
      tree->symbols = s;
      tree->children[0]->symbols = s;
    }
    //Unnamed do blocks reuse the parents symbol table.
    else
    {
      if(tree->children[0] != NULL)
        tree->children[0]->symbols = tree->symbols;
    }
    updateAstSymbols(tree->children[0]);
    return tree;
  }

  if(tree->op == GUARDED && tree->dostat.name != NULL)
  {
      psymList s = symFind(tree->symbols, tree->dostat.name);
      if(s == NULL)
      {
        fprintf(stderr, "Error, label %s not defined.\n", tree->dostat.name);
        exit(3);
      }
  }

  //Per default pass symbols down the tree:
  if(tree->children[0] != NULL)
  {
    tree->children[0]->symbols = tree->symbols;
    updateAstSymbols(tree->children[0]);
  }
  if(tree->children[1] != NULL)
  {
    tree->children[1]->symbols = tree->symbols;
    updateAstSymbols(tree->children[1]);
  }
  return tree;

}

//Get next free register according to the given symbol list
int getNextReg(psymList list)
{
  if(list == NULL)
    return 0;
  else {
    if(list->type == ST_VAR) {
      return list->reg +1;
    }
    else
    {
      return getNextReg(list->next);
    }
  }
}

//Build list of arguments and add them to symbols.
//element returned should contain the final argument list, can be 0
nodeptr updateArguments(nodeptr argument)
{
  //symPrint(argument->symbols);
  //Check for valid argument.
  if(argument == NULL)
    assert(0); //Argument tree should be terminated by lastarg

  if(argument->op == LASTARG)
    return argument;
  if(argument->op != ARG) {
    fprintf(stderr, "Error, non argument node in argument node position.\n");
    exit(3);
  }

  //Check if name is already defined.
  if(symFind(argument->symbols, argument->name) != NULL)
  {
    fprintf(stderr, "Error, argument %s already defined!\n", argument->name);
    exit(3);
  }

  psymList s = (psymList) malloc(sizeof(*s));
  memset(s, 0, sizeof (*s));

  s->name = argument->name;
  s->type = ST_VAR;
  s->next = argument->symbols;
  //Assign a register number to the argument. If there are none we start at zero, otherwise
  //we increment the latest register number by one. (The latest variable is at the head of the list).
  if(argument->symbols == NULL)
    s->reg = 0;
  else
    s->reg = argument->symbols->reg + 1;

  //ARG as last element, no children
  if(argument->children[0] == NULL)
  {
    //add lastarg for burm
    argument->children[0] = newNode(LASTARG);
  }
  argument->children[0]->symbols = s;
  nodeptr res = updateArguments(argument->children[0]);
  argument->symbols = res->symbols; //Backpropagate symbol additions
  return argument;

  assert(0);
}

