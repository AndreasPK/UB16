#ifndef _FUFUNCTIONS
#define _FUFUNCTIONS

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define ST_ANY (0)
#define ST_LABEL (1)
#define ST_VAR   (2)

typedef struct symT
{
    char* name;
    struct symT* next;
    int type;
} symT;

symT *sym_add(symT* table, char* name, int type);
symT* sym_find(symT *table, char* name, int type);
symT* sym_combine(symT *table, symT* t2);
int sym_use(symT *table, char* name, int type);
int sym_def(symT *table, char* name, int type);
void sym_list(symT* head);


#endif

