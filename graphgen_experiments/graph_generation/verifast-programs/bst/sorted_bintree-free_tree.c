#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <stdbool.h>

typedef struct tree{
  int key;
  struct tree *left;
  struct tree *right;
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

void free_tree(struct tree *t)
{
  if(t==0){
  }else{
    if (t->left != NULL) {
        assert(cmp_with_key(t->left, t->key, false));
        assert(t->left!=t->right);
      }
      if (t->right != NULL) {
        assert(cmp_with_key(t->right, t->key, true));
      }
    struct tree *l=t->left;
    struct tree *r=t->right;
    
    free_tree(l);
    free_tree(r);
    free(t);
  }
}

int main() 
{
  BNode * root01 = build_graph();
  free_tree(root01);

  return 0;
}