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

int dll_check(DLNode * x1) 
  /*D_requires (dll^(x1) * dll^(x2)) */
  /*D_ensures  (dll^(ret) & (keys^(ret) s= (old(keys^(x1)) union old(keys^(x2))))) */
{
  if (x1 == NULL) {
    return 1;
  } else {
    if(x1->next != NULL) {
      assert(x1->next->prev == x1);
    }
    return dll_check(x1->next);
  }
}

int main() {
    DLNode * x1 = build_graph();
    assert(x1->prev == NULL);
    assert(dll_check(x1)==1);
    return 0;
}