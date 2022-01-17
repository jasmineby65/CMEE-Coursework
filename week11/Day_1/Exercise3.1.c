#include <stdio.h>

int main (void)
{
	int		a = 3;
	int		b = 2;
	int		c = 0;
	float	d = 0.0;
    char e = 'a';

	c = (float) a / b;
	d = (float) a / b;

	printf("The result of a / b stored in c: %i\n", c);
	printf("The result of a / b stored in d: %f\n", d);

    a = e;
    printf("The result of assinging char to int is %c\n", a); 
    // This will assign garbage number, but will return a if %i is used 
    // These probably still managed to cast because the data size are very small so can fit to the memory of other types
    // But could fail to convert if the data size become large 
    e = b;
    printf("The result of assinging int to char is %c\n", e); 
    // This returns a blank space, but will return 2 if %i if is used 
	return 0;
}