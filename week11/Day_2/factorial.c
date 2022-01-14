#include <stdio.h>

// stacking in C:
// Everytime a function with internal function is executed e.g. main(){factorial()}
// A new stack is made to execute factorial()
// What was being defined in main() is not accessable to factorial()
// When factorial() finish executing, this stack will be deleted and only what was defined in return will be passed to the lower stack i.e. main()


int factorial(int n)
{
    if (n == 0){ // without conditional to stop a recursive function, it could lead to stack overflow - too many stacks made and overload the CPU
        return 1;
    }

    return n*factorial(n-1);
}

int main(void)
{
    int i;
    int r;

    i = 2;

    r = factorial(i);

    printf("%i factorial is %i\n", i, r);

    return 0;

}