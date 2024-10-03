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

SNnode * sls_double_all(SNnode * lst)
{
  if (lst == NULL) {
    return NULL;
  }
  SNnode * curr = lst;
  SNnode * cp = NULL;
  SNnode * res = (SNnode *) malloc(sizeof(SNnode));
  cp = res;
  int curr_key = curr->key;
  cp->key = (2 * curr_key);
  cp->next = NULL;
  SNnode * old_cp = NULL;
  while(curr->next != NULL)
  {
    assert(curr->key <= curr->next->key);
    old_cp = cp;
    cp = (SNnode *) malloc(sizeof(SNnode));
    old_cp->next = cp;
    curr = curr->next;
    curr_key = curr->key;
    cp->key = (2 * curr_key);
    cp->next = NULL;
  }
  return res;
}

int main() {
    SNnode * x = build_graph();
    SNnode * res = sls_double_all(x);
    return 0;
}
