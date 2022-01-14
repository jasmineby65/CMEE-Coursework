#include <stdio.h>

float divide(float num, float denom) // defining the function output and input arguments need a declaration 
{
    float res; // This is an automatic local variable - will make a storage for the result and then delete data from this storage once the copy of the result output is made 
    
    res = num/denom;

    return res;
}

void print_character(char c);  // could also just include this line to declare the function and then define the whole function after main

int main(void) // the main function without needing any input arguments
{
    int x,y;
    float f;

    x = 7;
    y = 3;

    f = x/y; // This makes the result an integer since its calcualting with integer variables
    printf("The result of division: %f\n", f);

    f = divide (x,y); 
    printf("The result of division using a function: %f\n", f);

    print_character('A');

    return 0;
}

void print_character(char c) // Could make a function that returns nothing (void)
{
    printf("%c", c);
    return; // empty return is only used in real life to terminate the function at a specific point in the function before reaching its natural end e.g. used in if()
}
