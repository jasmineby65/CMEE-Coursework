#include <stdio.h>

int main(void)
{

    char c;
    char b;

    c = 'A';
    b = 'a';

    printf("The value of c: %c\n", c); //%c specify to print a character type
    printf("The value of c as an int: %i\n", c); // using %i gives a number instead of character 

    printf("The character a represented as an integer: %i\n", 'a'); // this also gives a number 

    return 0;
}