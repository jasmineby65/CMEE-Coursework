     // Commenting in C //
// will make single line comment
/* will make multiline commenting:  
      Can write anything here:)
*/

#include <stdio.h> // this is a type of statement called preprocessor directive, which gives instruction to the compiler
// This one tells the compiler to load the library (ending in ".h") "stdio.h", which ntains the funtion printf()

int main (void) // function decleration - asks to make a function that will return an integer 
{ // functions will contain statements (excutable line of code) which are defined with ; at the end 
// Every statement in C need ; except preprecessor directive and those bound in braces
    
    printf("Hello, CMEE!\n"); // \n will add new line  

    return 0;
}

// can also be written in single line with almost no space:
// int main(void){printf("Hello, CMEE!");return 0:}

/*
Use "gcc hello.c" to compile the text code to a machine instruction first.
This will generate an executable file called "a.out", which will contain different things depending on the operating system used
Then use ""./a.out" to run the file and see the outputs.

Everytime the code is changed, it needs to be re-compiled for the updates to the made!

Can use "gcc hello.c -o hello" to name the executable as "hello"
This will produce a file called "hello" in the directory, which can be run with "./hello" 

Can also use "gcc -Wall hello.c -o hello", which will display warnings encountered while compiling the code   

Can use "g++"" to compile code in c++ but this will give warnings
Need to change the file extension to hello.cpp to get rid of the warning 

*/

// "depricated" in computing means a thing is not supported anymore so it means there was something that accepted it before in older versions but not anymore 

