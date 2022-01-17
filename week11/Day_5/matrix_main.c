#include <stdio.h>
#include <stdlib.h>

typedef struct int_matrix { // Making a new data structure called int_matrix and typesetting it

    int nrows;
    int ncols;

    int** data; 
    /* pointer of a pointer
    The first pointer will point to nrow number of pointers that are each pointing to an array with size ncol.
    Therefore, the first pointer correspond to the rows
    and the second pointer correspond to the columns */

} int_matrix;
53

void initialise_matrix(int nrows, int ncols, int_matrix* m) //initialising empty matrix of specific size
{
    (*m).nrows = nrows;
    (*m).ncols = ncols;
    (*m).data = calloc(nrows, sizeof(int*));
    // We are assining rows first, so we need memory to store nrow pointers
    
    int i;
    for (i=0; i<nrows; ++i){
        (*m).data[i] = calloc(ncols, sizeof(int));
    }
    // Then for each row, we need memory to store 5 integers (number of column)
}

void dealloc_matrix(int_matrix* m) // A function that does the opposite as calloc to free the momery, which helps to prevent memory leak
{
    int i;
    for(i=0; i<(*m).nrows; ++i){
        free((*m).data[i]);
    }
    free((*m).data);
}

int_matrix* new_int_matrix(int nrows, int ncols)
{
    int_matrix* mtpr;

    mptr = calloc(1, sizeof(int_matrix));
    if (mptr != NULL){
        initialise_matrix(nrows, ncols, mptr);
    }

    return mptr;
}


void set_element(int data, int row, int col, int_matrix* m) // Assigning data to matrix
{
    if (row < (*m).nrows){ // These two lines
        if(col < (*m).ncols){ // guard from out of bounds error 
            (*m).data[row][col] = data;
        }
    }
}

// write a funtion get_element ot return data from desired matrix coordiante 
int get_element(int row, int col, int_matrix*)
{
     if (row < (*m).nrows){ // These two lines
        if(col < (*m).ncols){ // guard from out of bounds error 
            return (*m).data[row][col] = data;
        }
    }
    exit(EXIT_FAILURE); // If it was out of bount, do controlled exit instead of returning garbage data
}

// Try write a function that returns data from specified matrix coordinates

int main(void){

    int_matrix m;

    // Making a matrix with 8 rows and 5 columns:
    initialise_matrix(8,5,&m);
    /* Needs to pass m as an address because m is a struc variable, which is kind of treated as function
       So if you set "int_matrix x" as an input argument for initialise_matrix(),
       it will create a new stack and work in copy instead of altering the original m made in main() so nothing will actually happen to the m in main() */

    dealloc_matrix(&m); // Clearing the memory once the matrix is not needed 

    return 0;

}