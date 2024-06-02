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

int sorted_find(SNnode * l, int k)
  /*D_requires sorted^(x) */
  /*D_ensures ((sorted^(x) & (keys^(x) s= old(keys^(x)))) & ((ret i= 1) <=> (k i-in old(keys^(x))))) */
{
	if (l == NULL) {
		return -1;
	} else if (l->key == k) {
		return 1;
	} else {
        if (l->next != NULL) {
            assert(l->key <= l->next->key);
        }
		int res = sorted_find(l->next, k);
		return res;
	}
}

int main() {
    SNnode * x = build_graph();
    int k1 = 20;
    int res = sorted_find(x, k1);
    int k2 = 30;
    int res2 = sorted_find(x, k2);
    return 0;
}
