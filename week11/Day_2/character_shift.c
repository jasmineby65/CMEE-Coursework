#include <stdio.h>

int main(void)
{

    signed char schar;
    unsigned char uchar;

    schar = 1; // represented as 00000001 in binary form
    // Can't assign number larger than 254 (the max no represented by single byte)
    uchar = 254; // represented as 11111111

    printf("%i\n", schar); // if 1 assigned as character (schar = '1'), need to use %c
    printf("%u\n", uchar);

    char sres = schar << ((char)7); // shifting bits 8 to the left, making 10000000
    // Better to use char() incase it converts the original number to int 
    printf("%i\n", sres); 
    unsigned char ures = uchar << ((char)6); // makes 010000000
    printf("%u\n", ures);

    sres = schar >> ((char)7); // shifting bits 8 to the right, making 00000000
    printf("%i\n", sres); 
    ures = uchar >> ((char)7); // makes 00000001
    printf("%u\n", ures);

    return 0;
}