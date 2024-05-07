#include <cstdlib>
#include <ctime>
#include <cstdio>
#include <set>
#include <vector>
#include <iostream>


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

std::pair<int,std::vector<int> > print_bst(BNode * x) {
    if(x == NULL){
        printf("Empty tree\n");
        return std::make_pair(0,std::vector<int>());
    }
    std::vector<int> list_elements;
    list_elements.push_back(x->key);
    int height = 1;
    printf("key(node%d,%d).\n",x,x->key);
    if(x->left != NULL){
        printf("left(node%d,node%d).\n",x,x->left);
        auto lp=print_bst(x->left);
        height = std::max(height,lp.first+1);
        list_elements.insert(list_elements.end(),lp.second.begin(),lp.second.end());
    }
    if(x->right != NULL){
        printf("right(node%d,node%d).\n",x,x->right);
        auto rp=print_bst(x->right);
        height = std::max(height,rp.first+1);
        list_elements.insert(list_elements.end(),rp.second.begin(),rp.second.end());
    }
    return std::make_pair(height,list_elements);
}

BNode * bst_insert_rec(BNode * x, int k)
  /*D_requires (bst^(x) & (~ (k i-in keys^(x)))) */
  /*D_ensures  (bst^(ret) & (keys^(ret) s= (old(keys^(x)) union (singleton k)))) */
{

  if (x == NULL) {
    BNode * leaf = (BNode *) malloc(sizeof(BNode));

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
    BNode * x = NULL;
    srand((unsigned int)time(0));
    int length = rand()%30;
    for(int i = 0; i < length; i++){
        int k = rand()%40;
        x = bst_insert_rec(x, k);
    }
    auto res=print_bst(x);
    printf("Root: node%d\n", x);
    printf("Height: %d\n",res.first);
    printf("List elements: [");
    std::copy(res.second.begin(), res.second.end(), std::ostream_iterator<int>(std::cout, ","));
    printf("]\n");
    auto all_elements=std::set<int>(res.second.begin(),res.second.end());
    printf("Set elements: [");
    std::copy(all_elements.begin(), all_elements.end(), std::ostream_iterator<int>(std::cout, ","));
    printf("]\n");
    return 0;
}