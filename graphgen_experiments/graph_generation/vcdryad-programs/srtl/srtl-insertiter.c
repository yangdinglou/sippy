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

SNnode * sorted_insert_iter(SNnode * l, int k)
  /*D_requires (sorted^(x) & (~ (k i-in keys^(x)))) */
  /*D_ensures  (sorted^(ret) & (keys^(ret) s= (keys^(x) union (singleton k)))) */
{
	if (l == NULL) {
		SNnode * tl = (SNnode *) malloc(sizeof(SNnode));
		tl->key = k;
		tl->next = NULL;
		return tl;
	} else {
    if (l->next != NULL) {
        assert(l->key <= l->next->key);
    }
		if (k <= l->key) {

			SNnode * hd = (SNnode *) malloc(sizeof(SNnode));

			hd->key = k;
			hd->next = l;

			return hd;
			
		} else {

			SNnode * prev = l;
			SNnode * next = l->next;

			while(next != NULL && k > next->key) 
        /*D_invariant ( ((sorted^(next) & ((prevk lt-set keys^(next)) & (~ (k i-in keys^(next))))) 
                     * ((prev |-> loc next: next; int key: prevk) & (prevk < k))) 
                     * (lseg^(x, prev) & (lseg-keys^(x, prev) set-lt prevk)) )  */
			{
				prev = next;
				next = next->next;
        if(next != NULL) {
            assert(prev->key <= next->key);
        }
			}

			SNnode * curr = (SNnode *) malloc(sizeof(SNnode));

			curr->key = k;
			curr->next = next;
			
			prev->next = curr;
			return l;
		}
	}
}

int main() {
    SNnode * x0 = build_graph();
    int to_insert = 0;
    SNnode* res = sorted_insert_iter(x0, to_insert);

    SNnode * x1 = build_graph();
    to_insert = 1;
    res = sorted_insert_iter(x1, to_insert);

    SNnode * x2 = build_graph();
    to_insert = 2;
    res = sorted_insert_iter(x2, to_insert);

    SNnode * x3 = build_graph();
    to_insert = 3;
    res = sorted_insert_iter(x3, to_insert);

    SNnode * x4 = build_graph();
    to_insert = 4;
    res = sorted_insert_iter(x4, to_insert);

    SNnode * x5 = build_graph();
    to_insert = 5;
    res = sorted_insert_iter(x5, to_insert);

    SNnode * x6 = build_graph();
    to_insert = 6;
    res = sorted_insert_iter(x6, to_insert);

    SNnode * x7 = build_graph();
    to_insert = 7;
    res = sorted_insert_iter(x7, to_insert);

    SNnode * x8 = build_graph();
    to_insert = 8;
    res = sorted_insert_iter(x8, to_insert);

    SNnode * x9 = build_graph();
    to_insert = 9;
    res = sorted_insert_iter(x9, to_insert);

    SNnode * x10 = build_graph();
    to_insert = 10;
    res = sorted_insert_iter(x10, to_insert);
    return 0;
}