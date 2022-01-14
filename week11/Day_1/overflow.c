#include <stdio.h>
#include <unistd.h> // Needed for sleep()

// overflowing basically means unpreditable program behaviour 

int main(void)
{
    unsigned short int i = 1; 

    do {
        i *= 2; // equivelant to i = i*2
        printf("%u\n", i); // %u to print unsigned integer
        sleep(1); // will slow down the printing process and stops the screen being overlaoded with 0 from overflow and let you see the values before reaching overflow 
    } while (1); // adding controls such as while (i > 0) when using signed integer will stop the function when it flips to negative

    return 0;
}

    // range of unsigned is 0 to infinite while the range of signed include negative values 
    // this means signed value will take up more storage by including data on signs so will overflow at much smaller value than unsigned 
    // overflowing of signed value will flip the signs
    // overflowing of unsigned value is unpredictable so could flip signs, abort, or reach 0 

    // using long int will make the numbers reach higher value before overflowing 
