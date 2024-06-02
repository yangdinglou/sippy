#include <stdlib.h>
#include <assert.h>
#include <string.h>

typedef
/*D_tag b_node */
struct b_node {
  struct b_node * left;
  struct b_node * right;
  int key;
} BNode;

BNode * build_graph();

// _(dryad)
int bst_find_rec(BNode * x, int k)
  /*D_requires bst^(x)) */
  /*D_ensures  (((ret i= 1) & (k i-in old(keys^(x)))) | ((ret i= 0) & (~ (k i-in old(keys^(x)))))) */
{
  if (x == NULL) {
    return 0;
  } else {
      if (k == x->key) {
        return 1;
      } else if (k < x->key) {
        if (x->left != NULL) {
          assert(x->left->key <= x->key);
          assert(x->left!=x->right);
        }
        int r = bst_find_rec(x->left, k);
        return r;
      } else {
        if (x->right != NULL) {
          assert(x->right->key >= x->key);
        }
        int r = bst_find_rec(x->right, k);
        return r;
    }
  }
}


int main() {
  int ret = 0;
  BNode * root0 = build_graph();
  ret = bst_find_rec(root0, 0);
  BNode * root1 = build_graph();
  ret = bst_find_rec(root1, 1);
  BNode * root2 = build_graph();
  ret = bst_find_rec(root2, 2);
  BNode * root3 = build_graph();
  ret = bst_find_rec(root3, 3);
  BNode * root4 = build_graph();
  ret = bst_find_rec(root4, 4);


  return 0;
}