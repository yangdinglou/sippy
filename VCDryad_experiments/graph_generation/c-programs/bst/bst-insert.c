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
    assert(x->left!=x->right || (x->left==NULL && x->right==NULL));
    if(x->left != NULL) {
      assert(x->left->key <= x->key);
    }
    BNode * l = x->left;
    BNode * r = x->right;
    BNode * tmp = bst_insert_rec(l, k);

    x->left = tmp;

    return x;
  } else {
    assert(x->left!=x->right || (x->left==NULL && x->right==NULL));
    if(x->right != NULL) {
      assert(x->right->key >= x->key);
    }
    BNode * l = x->left;
    BNode * r = x->right;
    BNode * tmp = bst_insert_rec(r, k);
    
    x->right = tmp;

    return x;
  } 
}


int main() {
    
  BNode * root0 = build_graph();
  BNode* ret = bst_insert_rec(root0, 0);
  BNode * root1 = build_graph();
  ret = bst_insert_rec(root1, 1);
  BNode * root2 = build_graph();
  ret = bst_insert_rec(root2, 2);
  BNode * root3 = build_graph();
  ret = bst_insert_rec(root3, 3);
  BNode * root4 = build_graph();
  ret = bst_insert_rec(root4, 4);

  return 0;
}