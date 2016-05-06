#include "tree.h"

nodeptr newNode(int op)
{
  nodeptr n = (nodeptr) malloc(sizeof(tNode));
  memset(n, 0, sizeof(tNode));
  n->op_type = op;
}
