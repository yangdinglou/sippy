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

DLNode * dll_append(DLNode * x1, DLNode * x2) 
  /*D_requires (dll^(x1) * dll^(x2)) */
  /*D_ensures  (dll^(ret) & (keys^(ret) s= (old(keys^(x1)) union old(keys^(x2))))) */
{
  if (x1 == NULL) {
    return x2;
  } else {
    if(x1->next != NULL) {
      assert(x1->next->prev == x1);
    }
    DLNode * tmp = dll_append(x1->next, x2);
    x1->next = tmp;
    if (tmp) tmp->prev = x1;
    return x1;
  }
}

int main() {
    DLNode * x1 = build_graph();
    assert(x1->prev == NULL);
    DLNode * x2 = malloc(sizeof(DLNode));
    x2->key = 10;
    x2->next = NULL;
    x2->prev = NULL;
    DLNode * x3 = dll_append(x1, x2);
    return 0;
}