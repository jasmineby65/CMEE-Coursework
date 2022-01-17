#include <stdio.h>

// declarations: all variables in c needs to have a declarations (e.g. int) in order to assign a set amount of storage for that variable 

int main(void)
{
    int x; // c needs a definition for the type of the variable and a name of the variable before a variable could actually be made - this reserves a memory for the variable

    x = 0; // 0 is a constant literal 
    // could do it as one line: int x=0
    
    float y = 1.2; 
    
    // Two types of data in C: integral type and floating point type

    // Integral type of variable counts as 0000 => 0, 0001 => 1, 0010 => 2, this includes:
    // calculation in this type is much faster than floating point
    char c; // 1-byte, which is typically 8 bites (bytes are read from left to right but bits are read from right to left)
    int i; // normally 32-bits on modern laptop but will change depending on the capacity of the computer used
    long int li;
    long long int lli; // large enough to hold long int and more 

    // Floating point types of varibles include:
    float f; // contains decimals but can never represent the real value due to the limit in how much the decimal can extend
    double d; // twice as precise as float (float uses 32bits but double uses 64, allowing it to extend longer beyond the decimal point than float)
    long double ld; 

    // Basic arithmatic operators in C:
    // +, -, *, /, %, (^ this is NOT a power operator!)

    printf("The value of x is: %i\n", x); // will substitute %i with whatever arguments following the sentense
    // without defining x, it will return the value that was last saved on the memory to which the variable is currently assigned 

    return x;
}