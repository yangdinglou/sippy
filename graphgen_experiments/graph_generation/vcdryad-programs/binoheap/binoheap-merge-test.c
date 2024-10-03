
#include <stdlib.h>
#include <assert.h>
#include <string.h>

typedef 
/*D_tag node */
struct node {
  int key;
  int order;
  struct node * children;
  struct node * sibling;
} SNnode;

SNnode * build_graph();

int binomial_heap_check(SNnode * x)
/*D_requires ( (binomial-heap^(x) * binomial-heap^(y)) &
 (
 (((x l= nil) & (xord i= 0)) |
 ((((x |-> int order: xord) * (orders^(x->sibling) set-le xord)) & (orders^(x) s= (orders^(x->sibling) union (singleton xord)))) * (0 < xord))) &
 (((y l= nil) & (yord i= 0)) |
 ((((y |-> int order: yord) * (orders^(y->sibling) set-le yord)) & (orders^(y) s= (orders^(y->sibling) union (singleton yord)))) * (0 < yord)))
 ) ) */
/*D_ensures (
 (binomial-heap^(ret) & (keys^(ret) s= (old(keys^(x)) union old(keys^(y))))) &
 ((((xord i= 0) & (yord i= 0)) & ((ret l= nil) & emp)) |
 ( (((~ (xord i= 0)) | (~ (yord i= 0))) &
    (((xord i= yord) & (ret->order i= (xord + 1))) |
 ((((xord < yord) & (ret->order i= (yord + 1))) |
 ((xord < yord) & (ret->order i= yord))) |
 (((yord < xord) & (ret->order i= (xord + 1))) |
 ((yord < xord) & (ret->order i= xord)))))
 )
 &
 ((true * (orders^(ret->sibling) set-le ret->order)) & ((orders^(ret) s= (orders^(ret->sibling) union (singleton ret->order))) * true)) )
 )
 ) */
{
    int ret = 1;
	if (x == NULL) {
        return 1;
	}
    else {
        if(x->order != 0){
            assert(x->children != NULL);
            assert(x->children->order == x->order - 1);
            ret *= binomial_heap_check(x->children);
            if(x->children->sibling != NULL){
                assert(x->children->sibling->order == x->order - 2);
            }
            if(x->sibling != NULL){
                assert(x->sibling->order < x->order);
                ret*= binomial_heap_check(x->sibling);
            }
        }
        else{
            assert(x->children == NULL);
        }

    }
    return 1;
}

int main() {
    SNnode * x = build_graph();
    SNnode* tmp = x;
    while(tmp != NULL){
        SNnode* sib = tmp->sibling;
        if(sib != NULL){
            assert(sib->order > tmp->order);
        }
        assert(binomial_heap_check(tmp)==1);
        tmp = sib;
    }
    // assert(binomial_heap_check(x)==1);
    // SNnode * x0 = build_graph();
    // SNnode * y0 = malloc(sizeof(SNnode));
    // y0->key = 0;
    // y0->order = 0;
    // y0->children = NULL;
    // y0->sibling = NULL;
    // SNnode * z0 = binomial_heap_merge_rec(x0, y0);

    // SNnode * x1 = build_graph();
    // SNnode * y1 = malloc(sizeof(SNnode));
    // y1->key = 1;
    // y1->order = 0;
    // y1->children = NULL;
    // y1->sibling = NULL;
    // SNnode * z1 = binomial_heap_merge_rec(x1, y1);

    // SNnode* x2 = build_graph();
    // SNnode* y2 = malloc(sizeof(SNnode));
    // y2->key = 2;
    // y2->order = 0;
    // y2->children = NULL;
    // y2->sibling = NULL;
    // SNnode * z2 = binomial_heap_merge_rec(x2, y2);

    // SNnode* x3 = build_graph();
    // SNnode* y3 = malloc(sizeof(SNnode));
    // y3->key = 3;
    // y3->order = 0;
    // y3->children = NULL;
    // y3->sibling = NULL;
    // SNnode * z3 = binomial_heap_merge_rec(x3, y3);

    // SNnode* x4 = build_graph();
    // SNnode* y4 = malloc(sizeof(SNnode));
    // y4->key = 4;
    // y4->order = 0;
    // y4->children = NULL;
    // y4->sibling = NULL;
    // SNnode * z4 = binomial_heap_merge_rec(x4, y4);

    // SNnode* x5 = build_graph();
    // SNnode* y5 = malloc(sizeof(SNnode));
    // y5->key = 5;
    // y5->order = 0;
    // y5->children = NULL;
    // y5->sibling = NULL;
    // SNnode * z5 = binomial_heap_merge_rec(x5, y5);

    // SNnode* x6 = build_graph();
    // SNnode* y6 = malloc(sizeof(SNnode));
    // y6->key = 6;
    // y6->order = 0;
    // y6->children = NULL;
    // y6->sibling = NULL;
    // SNnode * z6 = binomial_heap_merge_rec(x6, y6);

    // SNnode* x7 = build_graph();
    // SNnode* y7 = malloc(sizeof(SNnode));
    // y7->key = 7;
    // y7->order = 0;
    // y7->children = NULL;
    // y7->sibling = NULL;
    // SNnode * z7 = binomial_heap_merge_rec(x7, y7);

    // SNnode* x8 = build_graph();
    // SNnode* y8 = malloc(sizeof(SNnode));
    // y8->key = 8;
    // y8->order = 0;
    // y8->children = NULL;
    // y8->sibling = NULL;
    // SNnode * z8 = binomial_heap_merge_rec(x8, y8);

    // SNnode* x9 = build_graph();
    // SNnode* y9 = malloc(sizeof(SNnode));
    // y9->key = 9;
    // y9->order = 0;
    // y9->children = NULL;
    // y9->sibling = NULL;
    // SNnode * z9 = binomial_heap_merge_rec(x9, y9);
    
    // SNnode* x10 = build_graph();
    // SNnode* y10 = malloc(sizeof(SNnode));
    // y10->key = 10;
    // y10->order = 0;
    // y10->children = NULL;
    // y10->sibling = NULL;
    // SNnode * z10 = binomial_heap_merge_rec(x10, y10);
    return 0;
}
// [node(n00), node(n01), node(n02), node(n03), num_of_nodes(4), start(n00), relation(key,n00,0), relation(key,n01,0), relation(key,n02,0), relation(key,n03,0), relation(order,n00,0), relation(order,n01,4), relation(order,n02,0), relation(order,n03,0), relation(children,n01,n02), relation(children,n02,n03), relation(sibling,n00,n01)]


SNnode* build_graph(){
SNnode * n00 = (SNnode *) malloc(sizeof(SNnode));
memset(n00, 0, sizeof(SNnode));
SNnode * n01 = (SNnode *) malloc(sizeof(SNnode));
memset(n01, 0, sizeof(SNnode));
SNnode * n02 = (SNnode *) malloc(sizeof(SNnode));
memset(n02, 0, sizeof(SNnode));
SNnode * n03 = (SNnode *) malloc(sizeof(SNnode));
memset(n03, 0, sizeof(SNnode));
n00->children = n01;
n01->children = n03;
n00->sibling = n03;
n01->sibling = n02;
n01->key = 0;
n02->order = 0;
n03->order = 0;
n02->key = 1;
n01->order = 1;
n03->key = 2;
n00->order = 2;
n00->key = 3;
return n00;
}