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

DLNode * dl_filter(DLNode * x)
{
  //pre
  DLNode * prv = NULL;
  DLNode * curr = x;
  DLNode * res = x;
  DLNode * old_curr = NULL;
  DLNode * old_curr_next = NULL;
  while(curr != NULL)
  {
    //loop
    old_curr = curr;
    curr = curr->next;
    int nondet = rand();
    if(nondet) {
      if (prv != NULL) {
        old_curr_next = old_curr->next;
        prv->next = old_curr_next;
        if (old_curr_next != NULL) {
          old_curr_next->prev = prv;
        }
      } else {
        res = old_curr->next;
      }
      free(old_curr);
    } else {
      prv = old_curr;
    }
  }
  //post
  return res;
}

int main() {
    DLNode * x1 = build_graph();
    assert(x1->prev == NULL);
    assert(dll_check(x1)==1);
    return 0;
}