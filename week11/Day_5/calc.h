float add_float(float a, float b);
float sub_float(float a, float b);
float mult_float(float a, float b);
float div_float(float a, float b);

// header files only contain the function prototypes not the actual definitions, which are written in calc.c
// When compiling program that has #include calc.h, the linker will go find these functions from the programs thats being compiled

// compiling with "gcc -shared -Wall -o calc.so -fPIC" will compile a shared library called calc.so
// it tells the compiler that this program is not linked to specific main
// -fPIC will remove the absolute position of this library so it can be used on someone else's machine too