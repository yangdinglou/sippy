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
BNode * bst_insert_rec(BNode * x, int k)
  /*D_requires (bst^(x) & (~ (k i-in keys^(x)))) */
  /*D_ensures  (bst^(ret) & (keys^(ret) s= (old(keys^(x)) union (singleton k)))) */
{

  if (x == NULL) {
    BNode * leaf = (BNode *) malloc(sizeof(BNode));
    // _(assume leaf != NULL)

    leaf->key   = k;
    leaf->left  = NULL;
    leaf->right = NULL;

    return leaf;
  } else if (k < x->key) {
    if (x->left != NULL) {
        assert(cmp_with_key(x->left, x->key, false));
        assert(x->left!=x->right);
      }
      if (x->right != NULL) {
        assert(cmp_with_key(x->right, x->key, true));
      }
    BNode * l = x->left;
    BNode * r = x->right;
    BNode * tmp = bst_insert_rec(l, k);

    x->left = tmp;

    return x;
  } else {
    if (x->left != NULL) {
        assert(cmp_with_key(x->left, x->key, false));
        assert(x->left!=x->right);
      }
      if (x->right != NULL) {
        assert(cmp_with_key(x->right, x->key, true));
      }
    BNode * l = x->left;
    BNode * r = x->right;
    BNode * tmp = bst_insert_rec(r, k);
    
    x->right = tmp;

    return x;
  } 
}


int main() {
  BNode * root01 = build_graph();
  BNode* ret = bst_insert_rec(root01, -1);
  BNode * root0 = build_graph();
  ret = bst_insert_rec(root0, 0);
  BNode * root1 = build_graph();
  ret = bst_insert_rec(root1, 1);
  BNode * root2 = build_graph();
  ret = bst_insert_rec(root2, 2);
  BNode * root3 = build_graph();
  ret = bst_insert_rec(root3, 3);
  BNode * root4 = build_graph();
  ret = bst_insert_rec(root4, 4);
  BNode * root5 = build_graph();
  ret = bst_insert_rec(root5, 5);
  BNode * root6 = build_graph();
  ret = bst_insert_rec(root6, 6);
  BNode * root7 = build_graph();
  ret = bst_insert_rec(root7, 7);
  BNode * root8 = build_graph();
  ret = bst_insert_rec(root8, 8);
  BNode * root9 = build_graph();
  ret = bst_insert_rec(root9, 9);
  BNode * root10 = build_graph();
  ret = bst_insert_rec(root10, 10);


  return 0;
}