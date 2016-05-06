#ifndef _FUTREE
#define _FUTREE

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "functions.h"

//#define STATEPTR_TYPE int
typedef struct burm_state *STATEPTR_TYPE;

#define OP_NOOP 1

typedef struct tNode
{
  int op_type;
  struct tNode* children[2];
  STATEPTR_TYPE state;

}* nodeptr;

typedef struct tNode tNode;


nodeptr newNode(int op);


#define NODEPTR_TYPE   nodeptr
#define OP_LABEL(p)    ((p)->op_type)
#define LEFT_CHILD(p)  ((p)->children[0])
#define RIGHT_CHILD(p) ((p)->children[1])
#define STATE_LABEL(p) ((p)->state)
#define PANIC          printf



#endif
