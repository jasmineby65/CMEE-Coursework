#include <stdio.h>
#include <string.h> // need it for strchr

int main(void)
{
    int a,b,c,d;
    
    a = 0;
    b = 9;
    !a; // is equivelant of a == 0;
    printf("The integer of !a is: %i\n", !a);
    printf("The ingeger of !b is: %i\n", !b);

    char message[] = "The quick brown fox\n";


    // strchr(const char *str, int c) - used to find character in a string
    char s = 'q';
    if (!strchr(message, s)){ // if it cannot find q in the message
        printf("Character %c in the message %s\n does not exist\n", s, message); //%s asks to print a string
    } else {
        printf("Character %c found in the message\n", s);
    }

    a = 0;
    b = 2;

    a && b; // a AND b so will give false since a = false/0
    a || b; // a OR b so will give true since b is still true

    return 0;
}