#include <stdio.h>
#include <stdlib.h>

#include "calc.h" // including custom made header file, which include functions written in calc.c


int do_operation(float a, float b, char operator)
{
    if (operator == '+'){
        printf("%f\n", add_float(a,b));
        return 0;
    }

    if (operator == '-'){
        printf("%f\n", sub_float(a,b));
        return 0;
    }

    if (operator == 'x'){ // * gets recognised as command in the terminal so cannot be used as arguments
        printf("%f\n", mult_float(a,b));
        return 0;
    }

    if (operator == '/')
    {
        printf("%f\n", div_float(a,b));
        return 0;
    }

    else {
        printf("Operator not recognised! For multiplication, please use 'x'\n");
        return 0;
    }
}


int main(int argc, char* argv[]) // argc is the number of arguments and argv is the actual arguments entered
{
    int ret = 1; // Returning 1 for a function signifies it has error 
    // This is here to show the function is still in its developemntal stage


    /* This program is a calculator that will take three inputs (arguments) from the user
       1. An operand
       2. An operator
       3. An operand */

    float op1, op2;
    char operator;

    // Should first add some control that make sure correct inputs were executed
    if (argc == 4) {
        op1 = atof(argv[1]);
        op2 = atof(argv[3]);
        operator = argv[2][0]; // 
    } else if (argc == 1) {
        printf("This is a calculator program written by: Martin Barzeau\n"); 
        printf("It takes three command line arguments.\n");
        printf("The usage is: ./program number operator operator \n");
    }

    do_operation(op1, op2, operator);
    return ret;
}

// Run it by compiling all the files with the neccessary function using gcc main.c calc.c -o calculator 
// Then run calculator with 3 arguments 