#include <stdio.h>

void print_interarray(int integers[], int numelement) // print the element inside an array
{
    int i;
    for (i = 0; i < numelement; ++i){
        printf("%i", integers[i]);
    }
    printf("\n");
}


// C will still return values for array element that DOESN'T EXIST! e.g. myarray1[5] that is out of bound will still return a value
// It will give a warning when run with gcc -Wall so always check!!
// To overcome this, you can use constant variable:
const int arraymax = 5;
// This will produce an error if you tried to access array element out of bound 

int main(void)
{
    int myarray1[arraymax]; // arrays in C will always contain a single variable type, [] used to define size of array - could just use number but that is dangerous for the reasons stated above
    int myarray2[] = {7, 9, 21, 60, 4} ; // Or could add the elements straight away, which will automatically assign the array size

    print_interarray(myarray1, arraymax);

    int x;
    
    for (x = 0; x < arraymax; ++x){ // length of loop is x<5 because 0 is counted as an element, same as Python so the length of array of size 5 is 0,1,2,3,4 
        myarray1[x] = 0;
    }

    print_interarray(myarray1, arraymax);
    return 0;
}