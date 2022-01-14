#include <stdio.h>

// ++i and i++ both does the same thing 
// but ++i will add i when it is assigned to a variable 
// where as i++ will add i after its been assigned 
// i.e. don't add i on the first round it was assigned  
// but does it from second iteration onward
// e.g.  
// int a = a;
// a++; (a = 2 now)
// ++a; (a = 3 now)
// b = a++ (b = 3 but a = 4 now, so assign original a to b first and then carry out a++)
// b = ++a (both b and a equals 5)

int main(void)
{
    int i;

    int numbers[] = {1,2,3,4,5};
    
    // Increment operator
    i++; 

    // Deincrement operator
    i--;

    // Print elements forward:
    for (i = 0; i < 5; ++i){ // in a loop like this, it doesn@t matter if we use ++i or i++
        printf("%i", numbers[i]);
    }
    printf("\n");

    // Print elements in reverse
    for (i = 4; i >= 0; --i){
        printf("%i", numbers[i]);
    }
    printf("\n");

    // Could also do it with just the operator without the limit:
    for (i = 5; i--;){ 
        // i=5 is executed right at the beginning and i-- is run EVERY loop including the first one 
        // Have to use i-- in this case NOT --i, which will print 5432
        // This is because --i is now acting as both limit and loop operation 
        // So it will reach 0 first before evaluating the limit, which will stop the loop (0 is counted as false so stops loop)
        // i++ will evalutate the condition first as 1 and then do the operation to make is 0 so will still loop at position 0
        // Just don't bother using it this way
        printf("%i", numbers[i]);
        
    }
    printf("\n");

    return 0;

}