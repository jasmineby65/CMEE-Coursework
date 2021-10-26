
# MyExampleScript.py

A function that calculates the power of x (x=2 tested)   
Language: python3

### Usage 
```python
%run MyExampleScript.py
```

&nbsp;

# align_seqs.py

Functions that import two DNA base sequnces from csv file and find best alignment   
Language: python3

### Usage
```python
# Import the program 
import align_seqs

# Import DNA sequences from a csv file and extract the sequnce (s1, s2) and sequnce length (l1, l2)
import_sequence("csv file")

# computes a alignment score by returning the number of matches starting from arbitrary startpoint (chosen by user)
calculate_score(s1, s2, l1, l2, startpoint)

# finds the best alighment for two sequnces imported from a csv file and saves the best alignment and the corresponding score in a single text file
best_alignment("csv file")
```

&nbsp;

# basic_csv.py
Produce a csv file named "bodymass.csv" that contains data of species names and body mass extracted from testcsv.csv  
Language: python3

### Usage
```python
%run basic_csv.py
```

&nbsp;

# basic_io1.py
Print the content of "test.txt" twice, once as it is and once with empty lines removed  
Language: python3

### Usage
```python
%run basic_io1.py
```

&nbsp;

# basic_io2.py
Produce a text file named "testout.txt" that contains the number 0 to 99, each written on a new line  
Language: python3

### Usage
```python
%run basic_io2.py
```

&nbsp;

# basic_io3.py
Print and save a file named "test.p" that contains the dictionary:  
{'a key': 10, 'another key':11} 

### Usage
```python
%run basic_io3.py
```

&nbsp;

# boilerplate.py 
A function that print "This is a boilerplate"  
Language: python3

### Usage
```python
%run boilerplate.py
```

&nbsp;

# cfexercises1.py
Example functions of the use of conditionals in Python  
Language: python3

### Usage 
```python
# Import the program
import cfexercises1 

## calculate square root of x
foo_1(x)

## print the larger value input of x and y 
foo_2(x,y)

## sorting the number from small to large
foo_3(x,y,z)

## factorial of x
foo_4(x)

# a recursive function that calculates the factorial of x
foo_5(x)

# calculate the factorial of x in a differnt way
foo_6(x)

# testing all the functions with default input  
%run cfexercises1.py
# Tested value:
    foo_1(9)
    foo_2(5,10)
    foo_3(1,2,3)
    foo_4(6) 
    foo_5(6)
    foo_6(6)
```
&nbsp;

# cfexercises2.py
Print many "hello"  
Language: python3

### Usage
```python
%run cfexercises2.py
```

&nbsp;

# control_flow.py
Some functions exemplifying the use of control statements  
Language: python3

### Usage 
```python
# Import program 
import control_flow

# Find whether a number x is even or odd
even_or_odd(x)

# Find which is the largest divisor of x among 2,3,4,5
largest_divisor_five(x)

# Find whether x is prime
is_prime(x)
    
# Find all the primes up to x 
find_all_primes(x)

# Running all the functions with specified input to check it is working 
%run cfexercises2.py
# Values tested: 
    even_or_odd(22)
    even_or_odd(33)
    largest_divisor_five(120)
    largest_divisor_five(121)
    is_prime(60)
    is_prime(59)
```

&nbsp;

# debugme.py
Example of debugging using the control flow tools: "try" and "except" 

### Usage 
```python
%run debugme.py
```

&nbsp;

# dictionary.py 
Produce a dictionary called "taxa_dic", which maps order names to sets of taxa derived from "taxa"  
Language: python3

### Usage
```python
%run dictionary.py
```

&nbsp;

# lc1.py 
Print three lists containing the latin names, common names and mean body masses for each species in birds  
Language: python3

### Usage
```python
%run lc1.py
```

&nbsp;

# lc2.py
Print a list of month,rainfall tuples where the amount of rain was greater than 100 mm and a list of just month names where the amount of rain was less than 50 mm  
Language: python3

### Usage
```python
%run lc2.py
```

&nbsp;

# loops.py
Examples of "for loop" use in Python  
Language: python3

### Usage
```python
%run loops.py
```

&nbsp;

# oaks.py
A function that finds oak trees from a list of species  
Language: python3 

### Usage
```python 
# Importing program
import oaks

# Checks if a species is oak or not
is_an_oak(species)

# Lists oak species from a given list
%run oaks.py
```

&nbsp;

# scope.py
Examples of how global and local variables work  
Language: python3

### Usage
```python
%run scope.py
```

&nbsp;

# sysargv.py
Print the name of the script, number of arguments, and the arguments.  
Language: python3

### Usage
```python
%run sysargv.py
```

&nbsp;

# test_control_flow.py
Test whether the function "even_or_odd(x)" works using doctest  
Language: python3 (Does NOT work from bash terminal)

### Usage
```python
%run test_control_flow.py -v
```

&nbsp;

# tuple.py
Print the latin name, common name, and mass of each birds in blocks by species  
Language: python3

### Usage
```python
%run tuple.py
```

&nbsp;

# using_name.py
Print the name of module ("__main__" in this script)  
Language: python3

### Usage
```python
%run using_name.py
```

