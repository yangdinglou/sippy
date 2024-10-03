#include <stdlib.h>
#include <assert.h>
#include <string.h>

typedef
/*D_tag node */
struct node {
  int key;
  struct node * next;
} SNnode;

SNnode* build_graph();

SNnode * sls_copy(SNnode * lst)
{
  SNnode * head = NULL;
  if (lst == NULL) {
    return NULL;
  }
  SNnode * curr = lst;
  head = (SNnode *) malloc(sizeof(SNnode));
  SNnode * cp = head;
  int lst_key = lst->key;
  cp->key = lst_key;
  cp->next = NULL;
  SNnode * old_cp = NULL;
  int curr_key = 0;
  while(curr->next != NULL)
  {
    assert(curr->key <= curr->next->key);
    old_cp = cp;
    cp = (SNnode *) malloc(sizeof(SNnode));
    old_cp->next = cp;
    curr = curr->next;
    curr_key = curr->key;
    cp->key = curr_key;
    cp->next = NULL;
  }
  return head;
}

int main() {
    SNnode * x = build_graph();
    SNnode * res = sls_copy(x);
    return 0;
}
