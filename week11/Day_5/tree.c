#include <stdio.h>
#include <stdlib.h>

struct node {
    struct node* left; 
    /* the struct here is for node rather than left 
    i.e. it shows left is a pointer to node, which is a struct 
    (it knows left is a pointer so it don't need the variable type of left to be defined) */
    struct node* right;
    struct node* parent;
    int index;
    char* name;
}; typedef struct node node;

void traverse_node(node* n)
{
    if (n != NULL){
        traverse_node(n->left);
        traverse_node(n->right);
    }
}


int main(void)
{
    node n1;
    node n2;
    node n3;

    // initialising the pointers
    n1.left = n1.right = NULL;
    n2.left = n2.right = NULL;
    // joining the nodes
    n3.left = &n1;
    n3.right = &n2;

    traverse_node(&n1);

    return 0;
}