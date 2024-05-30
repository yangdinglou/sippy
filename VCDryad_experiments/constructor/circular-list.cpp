#include <cstdlib>
#include <cstdio>
#include <ctime>
#include <set>
#include <vector> 
#include <iostream>
#include <algorithm> 

typedef
/*D_tag node */
struct node {
  int key;
  struct node * next;
} CNode;

/*D_defs 
  define relation lseg^(head, tail): 
  ( 
  ((head l= tail) & emp) | 
  ((head |-> loc next: nxt) * lseg^(nxt, tail))  
  ) ;
*/
// ---------------------------------------------------------

void print_clist(CNode * x) {
    CNode * curr = x;
    int length = 0;
    std::vector<int> list_elements;
    std::set<int> all_elements;
    if(x == NULL){
        printf("Empty list\n");
        return;
    }
    list_elements.push_back(curr->key);
    all_elements.insert(curr->key);
    length++;
    printf("key(node%d,%d).\n",curr,curr->key);
    printf("next(node%d,node%d).\n",curr,curr->next);
    while (curr->next != x) {
        curr = curr->next;
        list_elements.push_back(curr->key);
        all_elements.insert(curr->key);
        length++;
        printf("key(node%d,%d).\n",curr,curr->key);
        printf("next(node%d,node%d).\n",curr,curr->next);
    }
    printf("\n");
    printf("Root: node%d\n", x);
    printf("List length: %d\n", length);
    std::cout << "List elements: [";
    std::copy(list_elements.begin(), list_elements.end(), std::ostream_iterator<int>(std::cout, ","));
    std::cout << "]\n";
    std::cout << "Set elements: [";
    std::copy(all_elements.begin(), all_elements.end(), std::ostream_iterator<int>(std::cout, ","));
    std::cout << "]\n";
}

CNode * circular_list_insert_front(CNode * x)
  /*D_requires ((x |-> loc next: nxt) * lseg^(nxt, x)) */
  /*D_ensures  ((x |-> loc next: ret) * lseg^(ret, x)) */
{
	CNode * tmp = x->next;
	CNode * hd = (CNode *) malloc(sizeof(CNode)) ;
	hd->next = tmp;
    hd->key = rand()%20;
	x->next = hd; 
	return hd;
}

int main() {
    srand((unsigned int)time(0));
    int length = rand()%10;
    CNode * root = (CNode *) malloc(sizeof(CNode));
    root->next = root;
    root->key = rand()%20;
    for (int i = 0; i < length; i++) {
        root = circular_list_insert_front(root);
    }
    print_clist(root);
    return 0;
}