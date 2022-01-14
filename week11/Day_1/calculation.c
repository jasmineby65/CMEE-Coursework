#include <stdio.h>

int main(void)
{
    int a;
    int b;
    int c;

    a = 1+2;
    b = 7;
    c = a + b;

    printf("The result of a + b using c: %i\n", c);
    printf("The result of a + b: %i\n", a+b);

    c = b/a;
    printf("The result of b/a: %i\n", c); // because c is defined as integer, it will be converted to 2 (float to integer will just get rid of decimal points rather than rounding)
    
    float d;
    d = b/a;
    printf("The result of b/a: %f\n", d); // %f asks for flaot to be printed 
    // But this still produce 2.0000 becaue "b/a" is a integer arithmatic so the assigned "b/a" is an integer 
    
    // Option 1:
    float e;
    e = b;
    d = e/a; // this makes d a float arithmatic 
    printf("The result of b/a: %f\n", d); 

    // Option 2:
    d = (float)b/a; // specify b/a to be float arithmatic 
    printf("The result of b/a: %f\n", d); 
    // Could specify float with d = 7f 

    return 0;
}