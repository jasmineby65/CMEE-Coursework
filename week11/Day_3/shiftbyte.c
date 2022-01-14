#include <stdio.h>
#include <stdlib.h>

void printbitz(int x) // printing the bits (but backward)
{
    int c =0;
    unsigned mask =1;
    while (mask){
        if (mask & x){
            printf("1");
        } else {
            printf("0");
        }
        if (c == 8){
            printf(" ");
            c = 0;
        }
        mask = mask << 1;
        ++c;
    }
    printf("\n");
}


int main(void)
{
    int x;
    x = 249857293;

    char* p; // assining pointer as character variable will give warnings but will run
    p = &x; // can silence the warning by using p = (char*) &x by converting the address to character

    printbitz(x);
    p[2] = p[2] << 3; // this will shift only bits in the 3rd bytes of x 
    printbitz(x);
    printf("Value of x is now %i\n", x);

    return 0;
}
