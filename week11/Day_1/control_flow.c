#include <stdio.h>
#include <stdbool.h> // needed to use "bool"

int main(void)
{
    bool x = false; // 0
    bool y = true; // 1

    if (x){
        printf("x is true\n");
    }

    int i = 0;
    y = (i == 0); // without this line, "i == 0" in if() will just become a variable, this line makes "i==0" true 
    if (i == 0) { 
        printf("i is false\n");
    } else {
        printf("i is true\n");
    }

    if (!i){
        printf("i is false\n");
    }


    return 0;
}