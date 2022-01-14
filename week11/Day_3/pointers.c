#include <stdio.h>
#include <stdlib.h> // main library, which include "NULL"

// There are two data types in C: integer type (char, int, long) and float type (float, double)
// Pointer is a type of variable within the integer type 
// It is used to refer to a specific address in the momory i.e. used to refer to specific data 
// Created as "int * int_ptr;" so define the variable type first, then *, and then the name for the pointer variable made
// This line of code is read in the order of variable referenced (if this was a function, it will run the funtion first), then the *, and then the variable type 
// At this point, data in int_ptr is still just garbage
// To assign an address, use "int_ptr = &x", which will assign the address of x to int_ptr
// "*int_ptr" will now be treated as x (* here is called an indirection operator), while just "int_ptr" will only evaluate as the address of x
// Doing "*int_ptr = 3" will overwrite the value of x and make x=3 and can use "y= *int_ptr" to assign y as x

// *int_ptr is also equivalent to int_ptr[0] 
// pointer and array syntax are basically interchangable 


void doubler(int* i) // can only import the pointer but not the value pointer is referring to 
{
    *i = *i * 2;
}

int main(void)
{
    int x;
    int* xp; // making a pointer called xp

    int integs[] = {1,2,3,4,5};

    int *z;
    z = &integs[0]; 
    z = integs; // this line is actually the equivalant to above, pointer assgiend to an array will point to the start of the array

    printf("Third element of the array is %i.\n", *(z+2));
    printf("Third element of the array is %i.\n", z[2]);

    xp = NULL;

    xp = &x;
    printf("x before initialisation is %i.\n", x);

    *xp = 7;
    printf("x after initialisation is %i.\n", x);

    doubler(xp);

    return 0;

}
