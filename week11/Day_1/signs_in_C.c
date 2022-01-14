#include <stdio.h>

int main(void)
{
    signed char sc; // this is the default if you just use char sc;
    unsigned char uc;
    // characters are just discrete values. 
    // Definition of character is that it uses a single byte, 
    // which are storage for numbers representing the character and these numbers can be negative, 
    // so it is a thing in programming to have negative characters due to the way its represented by numbers. 

    int si;
    unsigned int ui; // can just type unsighed ui;
    long int li; // can just type long li;
    unsigned long int uli; //can just type unsigned long uli;

    // definition of boolion is that it only uses single bit - either 0 or 1 so it cannot have signs 

    // range of unsigned is 0 to infinite while the range of signed include negative values 
    // this means signed value will take up more storage by including data on signs 
    // overflowing of signed value will flip the signs
    // overflowing of unsigned value is unpredictable 

    return 0;

}