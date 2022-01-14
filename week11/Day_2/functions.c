#include <stdio.h>

// Scope: area of influence of variables

int y; // varibles can be defined outside the main function too 
// This variable has a scope for the whole script following this line 
int x = 1;

int main(void)
{
    int x = 4; // The new assignment inside main overwrites the previous definition 

    { // curly brackets can be used to define arbitary scopes
        int x = 5; // with just "x = 5", it will redifine the old x and overwrites it
        // but with "int x = 5", it will make a new storage and make a new x 
        // but this is within a lower scope so printf() will print x = 4 that was defined in higher scope instead 
    }
    
    printf("The value of x: %i\n", x);
    printf("The value of y: %i\n", y);


    return 0;
}