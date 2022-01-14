#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void* my_malloc(size_t s)
{
    void* new_mem = NULL;

    new_mem = malloc(s);
    if(new_mem != NULL){
        memset(new_mem, 0, s); // initialise to all 0s
    } else {
        printf("Insufficient ofr required operation.\n");
        exit(EXIT_FAILURE); // A controlled program crash
    }

    return new_mem;

}

int main(void)
{
    int* intblock;

    intblock = NULL;

    /* 
    intblock = malloc(10*sizeof(int)); 
    // If malloc failed, could lead to crushing if you operate on intblock
    // So should check malloc if malloc worked everytime you use it
    
    if (intblock == NULL){ // If no memory was allocated by malloc
        printf("Insufficient ofr required operation.\n");
        exit(EXIT_FAILURE); // A controlled program crash
    }
    
    But having to write this everytime is quite a hassle so can make a function like above */

    intblock = my_malloc(10*sizeof(int));`
    if (intblock != NULL){ // Clearing the memory of intblock once its not needed
        free(intblock);
        intblock = NULL;
    }

    return 0;
}

