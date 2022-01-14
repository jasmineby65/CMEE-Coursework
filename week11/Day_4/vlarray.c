#include <stdio.h>
#include <stdlib.h>

// So far we had to specify the size of array when we made them
// But this is difficult in real life where we might not know the final size of array
// So we need a method to make a arrays that can be any size 

// So far, pointer has always pointed to a specific variable type i.e. int * x 
// So it knew the size of variable it had to be represented 
// Pointing to void will point to undefined memory (bytes on memory without defined type)
// The data pointed by this kind of pointer can't be set as variable, will need to be defined before assigning to variable

// int* create_int_array(int nelems) // Return a pointer to a new array with element size nelems
//{
//    int newarray[nelems];
//
//    return newarray; 
//}
// But because the new stack will be destroyed when the function excution is done, this newarray will be destroyed too

// So instead:
int* create_int_array(int nelems) 
{
    int* newarray;

    // Declaration of malloc: void* malloc(site_t, n);
    newarray = malloc(sizeof(int) * nelems); // Allocate garbage memory to a variable
    // newarray = calloc(nelems, sizeof(int)); is a safer alternative

    return newarray; 
}

// To run this, first use "gcc -)3 vlarray.c -o vlarray" to compile and save a new program
// Then run "./vlarray 10" to specify the argument to input (10 in this case)
int main(int argc, char * argv[]) // char * argv[] is an array of pointers to characters i.e. a string (array of characters)
{
    int i;
    for (i =0; i<argc; ++i){
        printf("Argument %i is %s\n", i, argv[i]);
    }

    unsigned int nelems;

    // Expect one use argument, and it should be an integer
    if (argc != 2){
        printf("ERROR: program requries 1 (and only 1) arguments, which should be an int.\n");
        return 1;
    }

    nelems = atoi(argv[1]); 
    if (nelems == 0){
        printf("ERROR: Inputs must be non-zero.\n");
        return 1;
    }

    int* myintegers;
    myintegers = create_int_array(nelems);
    
    for (i =0; i<nelems; ++i){
        myintegers[i] = i + 1;
        printf("%i", myintegers[i]);
    }
    printf("\n");

    free(myintegers); // This is opposit to mallac and will free the memory allocated to a variable

    return 0;
}