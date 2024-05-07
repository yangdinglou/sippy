#include <stdlib.h>
#include <assert.h>

typedef
/*D_tag b_node */
struct b_node {
  struct b_node * left;
  struct b_node * right;
  int key;
} BNode;

/*D_defs 
define pred bst^(x): 
  ( ((x l= nil) & emp) |
    ((x |-> loc left: lft; loc right: rgt; int key: ky) * ((bst^(lft) & (keys^(lft) set-lt ky)) * (bst^(rgt) & (ky lt-set keys^(rgt)))))  
  );

define set-fun keys^(x):
  (case (x l= nil): emptyset;
   case ((x |-> loc left: lft; loc right: rgt; int key: ky) * true): 
    ((singleton ky) union (keys^(lft) union keys^(rgt)));
   default: emptyset
  ) ;
*/
// -----------------------------------------------

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
    BNode * l = x->left;
    BNode * r = x->right;
    BNode * tmp = bst_insert_rec(l, k);

    x->left = tmp;

    return x;
  } else {
    BNode * l = x->left;
    BNode * r = x->right;
    BNode * tmp = bst_insert_rec(r, k);
    
    x->right = tmp;

    return x;
  } 
}


int main() {
    BNode * root = NULL;
    root = bst_insert_rec(root, 10);
    root = bst_insert_rec(root, 20);
    root = bst_insert_rec(root, 5);
    root = bst_insert_rec(root, 15);
    int r = bst_find_rec(root, 15);
    assert(r == 1);
    BNode * root2 = NULL;
    root2 = bst_insert_rec(root2, 10);
    root2 = bst_insert_rec(root2, 20);
    int r2 = bst_find_rec(root2, 15);
    assert(r2 == 0);

  return 0;
}