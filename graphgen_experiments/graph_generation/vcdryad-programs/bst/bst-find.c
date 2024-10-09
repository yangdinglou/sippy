#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <stdbool.h>

typedef
/*D_tag b_node */
struct b_node {
  struct b_node * left;
  struct b_node * right;
  int key;
} BNode;

BNode * build_graph();

bool cmp_with_key(BNode * x, int k, bool larger){
  if (x == NULL) return true;
  else {
    if (larger) {
      if (x->key < k) return false;
    } else {
      if (x->key > k) return false;
    }
    return cmp_with_key(x->left, k, larger) && cmp_with_key(x->right, k, larger);
  }
}
// _(dryad)
int bst_find_rec(BNode * x, int k)
  /*D_requires bst^(x)) */
  /*D_ensures  (((ret i= 1) & (k i-in old(keys^(x)))) | ((ret i= 0) & (~ (k i-in old(keys^(x)))))) */
{
  if (x == NULL) {
    return 0;
  } else {
      if (x->left != NULL) {
        assert(cmp_with_key(x->left, x->key, false));
        assert(x->left!=x->right);
      }
      if (x->right != NULL) {
        assert(cmp_with_key(x->right, x->key, true));
      }
      if (k == x->key) {
        return 1;
      } else if (k < x->key) {
        int r = bst_find_rec(x->left, k);
        return r;
      } else {
        int r = bst_find_rec(x->right, k);
        return r;
    }
  }
}


int main() {
  int ret = 0;
  BNode * root01 = build_graph();
  ret = bst_find_rec(root01, -1);
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