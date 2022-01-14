#include <stdio.h>
#include <string.h> // needed to work with strings

// strings is a special type of array made of characters

int main(void)
{
    char chars[] = {'H', 'e', 'l', 'l', 'o', '\0'}; // without the \0, the array does not know it has terminated so will return arbitary length for the string length  
    // array in C has no idea about its own size, so the size needs to be specified 

    char hellomsg[] = "Hello"; // this is actually {'H', 'e', 'l', 'l', 'o', '\0'}. 
    // The \0 at the end is a null-byte, which determines the termination of a string and is not counted as a character

    printf("The length of chars is %i.\n", strlen(chars)); // strlen() counts the number of characters
    printf("The legnth of hellomsg is %i.\n", strlen(hellomsg)); 
    
    printf("The second letter in Hello is %c.\n", hellomsg[1]);

    return 0;
}