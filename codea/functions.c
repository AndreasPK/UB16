#include "functions.h"

symT* clone(const symT *table)
{
  if(table == NULL)
    return NULL;

  symT *start = (struct symT*) malloc(sizeof(struct symT));
  symT *nt = start;
  while(1)
  {
    memcpy(nt, table, sizeof(struct symT));
    table = table->next;
    if(table == NULL)
    {
      break;
    }
    else{
      nt->next = (struct symT*) malloc(sizeof(struct symT));
      nt = nt->next;
    }
  }
  return start;
}

symT *sym_add(symT *table, char* name, int type)
{
    if (name == NULL || strlen(name) == 0)
    {
        printf("Can't insert empty string\n");
        return table;
    }

    if (table == NULL)
    {
        symT* n = (symT*)malloc(sizeof(struct symT));
        n->next = NULL;
        n->name = name;
        n->type = type;
        return n;
    }

    table = clone(table);
    symT *index = table;
    while (index != NULL)
    {
        if (strcmp(name, index->name) == 0)
        {
            printf("String already contained\n");
            return table;
        }
        else
        {
            if (index->next != NULL)
                index = index->next;
            else
            {
                symT *n = (symT*)malloc(sizeof(struct symT));
                index->next = n;
                n->next = NULL;
                n->name = name;
                n->type = type;
                return table;
            }
        }
    }
}

//Finds the given symbol of type x and returns the entry, if ST_ANY finds any matching name
symT* sym_find(symT *table, char* name, int type)
{
  if(table == NULL)
  {
    printf("Caution, tried to search empty table for %s.\n", name);
    return NULL;
  }
    if (strcmp(name, table->name) == 0)
    {
      if(type == ST_ANY)
        return table;
      else
        if(table->type == type)
          return table;
        else
          return NULL;
    }
    else if (table->next == NULL)
        return NULL;
    else
        return sym_find(table->next, name, type);
}

symT* sym_combine(symT* t1, symT* t2)
{
    symT *start = (symT*)malloc(sizeof(struct symT));
    symT *head = start;

    while (t1 != NULL)
    {
        head->name = t1->name;
        head->type = t1->type;
        t1 = t1->next;
        if (t1 == NULL && t2 == NULL)
        {
            head->next = NULL;
            return start;
        }
        head->next = (symT*)malloc(sizeof(struct symT));
        head = head->next;

    }

    while (1)
    {
        head->name = t2->name;
        head->type = t2->type;
        if (t2->next == NULL)
        {
            head->next = NULL;
            return start;
        }
        else
        {
            t2 = t2->next;
            head->next = (symT*)malloc(sizeof(struct symT));
            head = head->next;
        }
    }

}

void sym_list(symT *head)
{
  if(head == NULL)
  {
    printf("No symbols in table.\n");
    return;
  }
  while(head != NULL)
  {
    char *type;
    if(head->type == ST_LABEL)
      type = "label";
    else if(head->type == ST_VAR)
      type = "variable";

    printf("%s: %s\n", type, head->name);
    head = head->next;
  }
}

//Check if its valid to use the given symbole according to the symbole table
int sym_use(symT *table, char* name, int type)
{
  if(table == NULL)
  {
    printf("No symbols defined!\n");
    return -1;
  }

  symT* elem = sym_find(table, name, ST_ANY);
  if(elem == NULL)
  {
    printf("Symbol not defined: %s\n", name);
    return -1;
  }
  else
  {
    if(elem->type != type)
    {
      printf("Symbol of wrong type: Requested %d got %d\n", type, elem->type);
      return -1;
    }
    else
    {
      printf("Usage of %s is valid.\n", name);
      return 0;
    }
  }
}

int sym_def(symT *table, char* name, int type)
{
  if(table == NULL)
  {
    printf("Caution: No symbols defined.\n");
  }

  if(sym_find(table, name, ST_ANY) != NULL)
  {
    printf("Error: Symbol %s already defined.\n", name);
    return -1;
  }

  printf("Symbol %s definition valid.\n", name);

  return 0;
}


