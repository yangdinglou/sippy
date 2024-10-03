// ---- Commmon definitions for doubly-linked list examples  ----
#include <stdlib.h>
#include <assert.h>
#include <string.h>

typedef
/*D_tag node */
struct node {
  int key;
  struct node * next;
  struct node * prev;
} DLNode;

DLNode* build_graph();

void dl_dispose(DLNode * a)
{
  DLNode * prv = NULL;
  while(a != NULL)
  {
    if(a->next != NULL) assert(a->next->prev == a);
    prv = a;
    a = a->next;
    free(prv);
  }
}

int main() {
    DLNode * x1 = build_graph();
    assert(x1->prev == NULL);
    dl_dispose(x1);
    return 0;
}