#include <stdlib.h>
#include <assert.h>
#include <string.h>

typedef
/*D_tag node */
struct node {
  struct node * next;
} SNnode;

SNnode* build_graph();

SNnode * sl_reverse(SNnode * lst)
{
  //pre
  SNnode * curr = lst;
  SNnode * rev = NULL;
  SNnode * tmp = NULL;
  while(curr != NULL)
  {
    //loop
    //SNnode * tmp;
    tmp = curr;
    curr = curr->next;
    tmp->next = rev;
    rev = tmp;
  }
  //post
  return rev;
}

int main() {
    SNnode * x0 = build_graph();
    SNnode * res = sl_reverse(x0);
    return 0;
}