#include <stdio.h>

int doubler(int i)
{
    i = i*2;

    return i;
}

void array_doubler(int arr[], int nelems)
{
    int i;
    for(i=0; i<nelems; ++i){

        arr[i] = doubler(arr[i]);
    }
}

void print_intarray(int *arr, int nelems) // *arr is the same as arr[]
{
    int i;
    for(i = 0; i < nelems; ++i) { 
        printf("%i\n", arr[i]);
    }
}

int main(void)
{
    int x=7;
    int integs[5];

    int i;
    for (i=0; i<5; ++i)
    {
        integs[i] = i + 1;
    }

    x = doubler(x);
    printf("The value of x is %i.\n", x);

    array_doubler(integs, 5);

    return 0;
}


// referencing to an array (i.e. uses a pointer) will modify the original array in the stack below
// without pointers, the upper stackframe will only get a copy of the array from the lower stackframe 
// and can't access anything from the lower stackframe 