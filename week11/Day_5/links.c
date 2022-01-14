#include <stdio.h>
#include <stdlib.h>

// Want to make object that if a point is removed, will automatically connect the adjacent two points together
struct ilink {  
    int data;
    struct ilink* next;
}; 
typedef struct ilink ilink;

/*
void traverse_list(ilink* p)
{
    if(p != NULL){
        printf("%i\n", p->data); 
        traverse_list(p->next); // p->next is the equivelant to (*p).next
    }
} This prints from i1 to i3 */

void traverse_list(ilink* p)
{
    if(p != NULL){
        traverse_list(p->next); 
        printf("%i\n", p->data); 
    }
} /* This prints from i3 to i1
This is because everytime traverse_list is called, a new stack is made
So traverse_list(&i1) will first reach traverse_list(&i2), which will open a new stack before reaching the printf()
traverse_list(&i2) will then reach &i3 before printing anything, which will then move to NULL
Since its NULL, it will return, closing the stack for NULL and go back to stack for i3 where it will finally reach the printf() line
This then return to i2 and i1 closing the stacks and runnin the printf() */


int main(void)
{
    ilink i1;
    ilink i2;
    ilink i3;

    i1.data = 47;
    i2.data = 23;
    i3.data = 9;

    i1.next = &i2;
    i2.next = &i3;
    i3.next = NULL;

    traverse_list(&i1);

    // Now removing i2 and joining i1 and i3
    printf("Eliminate one element:\n");
    i1.next = i1.next->next; // i1 now has same link as i2 and replace its position

    traverse_list(&i1);

    return 0;
}