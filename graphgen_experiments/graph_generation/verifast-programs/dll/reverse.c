/*

Full functional correctness proof of doubly-linked list reversal
Stephan van Staden, 2009

*/
#include <stdlib.h>
#include <assert.h>
#include <string.h>

typedef struct node {
	int key;
	struct node *next;
	struct node *prev;
} node;


node* build_graph();


void reverse(node * arg)
{
	node * ptr = arg;
	node * temp1 = NULL;
	node * temp2 = NULL;
	while (ptr != NULL)
	{
		temp1 = ptr->next;
		temp2 = ptr->prev;
    if (ptr->next != NULL) assert(ptr->next->prev == ptr);
		ptr->next = temp2;
		ptr->prev = temp1;
		ptr = temp1;
	}
	arg->next = temp2;
	arg->prev = NULL;
}

int main() {
    node * x1 = build_graph();
    assert(x1->prev == NULL);
    reverse(x1);
    return 0;
}