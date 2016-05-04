#ifndef _FUFUNCTIONS
#define _FUFUNCTIONS

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct symT
{
    char* name;
    struct symT* next;
} symT;

symT *sym_add(symT* table, char* name);
symT* sym_find(symT *table, char* name);
symT* sym_combine(symT *table, symT* t2);
void sym_list(symT* head);



#endif
