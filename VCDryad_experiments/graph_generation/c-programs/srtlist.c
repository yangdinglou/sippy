#include <stdlib.h>
#include <assert.h>

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

SNnode* build_graph(){
SNnode * n0 = (SNnode *) malloc(sizeof(SNnode));
SNnode * n1 = (SNnode *) malloc(sizeof(SNnode));
SNnode * n2 = (SNnode *) malloc(sizeof(SNnode));
SNnode * n3 = (SNnode *) malloc(sizeof(SNnode));
SNnode * n4 = (SNnode *) malloc(sizeof(SNnode));
n1->next = n3;
n0->next = n4;
n3->next = NULL;
n2->next = n1;
n4->next = n2;
n4->key = 4;
n1->key = 2;
n0->key = 1;
n2->key = 12;
n3->key = 17;
return n0;
}