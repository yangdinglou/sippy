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
    struct tree *l=t->left;
    struct tree *r=t->right;
    free_tree(l);
    free_tree(r);
    free(t);
  }
}

int maximum(struct tree *t)
{
  int v=t->key;
  struct tree *r=t->right;
  if(r==0){
    return v;
  }else{
    int m= maximum(r);
    return m;
  }
}

struct tree* remove(struct tree *t, int x)
{
  if (t->left != NULL) {
        assert(cmp_with_key(t->left, t->key, false));
        assert(t->left!=t->right);
      }
      if (t->right != NULL) {
        assert(cmp_with_key(t->right, t->key, true));
      }
  int v=t->key;
  struct tree *l=t->left;
  struct tree *r=t->right;

  if(x < v){
    if(l!=0){
      struct tree *temp=remove(l,x);
      t->left=temp;
      return t;
    }
    return t;
  } else if(v < x){
    if(r!=0){
      struct tree *temp=remove(r,x);
      t->right=temp;
      return t;
    }
    return t;
  } else {
    if (l == 0) {
      if (r == 0) {
        free_tree(t);
        return 0;
      } else {
        free(t);
        return r;
      }
    } else {
      if(r==0){
        free(t);
        return l;
      } else {
        struct tree *temp=0;
        int m=maximum(l);
        t->key=m;
        temp=remove(l,m);
        t->left=temp;
        return t;
      }
    }
  }
}
int main(){

  BNode * root01 = build_graph();
  BNode * ret = remove(root01, -1);
  BNode * root0 = build_graph();
  ret = remove(root0, 0);
  BNode * root1 = build_graph();
  ret = remove(root1, 1);
  BNode * root2 = build_graph();
  ret = remove(root2, 2);
  BNode * root3 = build_graph();
  ret = remove(root3, 3);
  BNode * root4 = build_graph();
  ret = remove(root4, 4);

  return 0;
}