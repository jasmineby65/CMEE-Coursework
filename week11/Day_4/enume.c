#include <stdio.h>

enum my_error_t { // declaring error types
    // using "echo $?" in terminal after compiling the program
    // It will give a number which correspond to the error 
    MYPROG_SUCCESS, // 0
    UNEXPECTED_NULLPTR, // 1
    OUT_OF_BOUNDS, //2

    MY_ERROR_MAX // this line shows new error definitions are written above
};

int main(void)
{
    enum my_error_t err;

    const int arraymax =5;
    int values[arraymax];
    int userval = 5;
    
    if (userval<arraymax){
        printf("Value %i is %i\n", userval, values[userval]);
    } else {
        err = OUT_OF_BOUNDS; // specify error messages
    }

    return 0;
}