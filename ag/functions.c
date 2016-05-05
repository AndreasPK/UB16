#include "functions.h"

symT *sym_add(symT *table, char* name, int type)
{
    if (name == NULL || strlen(name) == 0)
    {
        printf("Empty string added\n");
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
    if (strcmp(name, table->name) == ST_ANY)
    {
      if(type == ST_ANY)
        return table;
      else
        if(table->type == type)
          return table;
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
  while(head != NULL)
  {
    char *type;
    if(head->type = ST_LABEL)
      type = "label";
    else if(head->type = ST_VAR)
      type = "variable";

    printf("%s: %s\n", type, head->name);
    head = head->next;
  }
}
