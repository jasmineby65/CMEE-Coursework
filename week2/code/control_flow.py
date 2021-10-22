#!/usr/bin/env python3

""" Some functions exemplifying the use of control statements """ 

__author__ = 'Samraat Pawar (s.pawar@imperial.ac.uk)'
__version__ = '0.0.1'

import sys 

def even_or_odd(x=0): # if not specified, x should take value 0
    """Find whether a number x is even or odd"""
    if x % 2 == 0: # == means equal, while = assign variables
        # % is modulo, so x % 2 == 0 means when x is divided by 2, the remainder is 0
        print("%d is Even!" % x)
        # "%" is also used for adding value/string to a string 
        # basically the same as .format() i.e. f string!
        # %d specifically add integer to the string (%s will add number)
        # the integer to add is specified after the string and can be a variable 
        # this becomes useful later when you want to add multiple variables to string  
    else: 
        print("%d is Odd!" % x)
    return 

def largest_divisor_five(x=120):
    """Find which is the largest divisor of x among 2,3,4,5"""
    largest = 0 
    if x % 5 == 0:
        largest = 5
    elif x % 4 == 0: # "else if"
        largest = 4
    elif x % 3 == 0: 
        largest = 3
    elif x % 2 == 0: 
        largest = 2
    else: # When all other (if, elif) conditions are not met 
        print("No divisor found for %d!" % x) 
        # Each function can return a value or a variable 
        return 
    print("The largest divisor of %d is %d" % (x, largest))
    return 

def is_prime(x=70):
    """Find whether an integer is prime"""
    for i in range(2, x): # "range" returns a sequence of i integers
        if x % i == 0:
            print("%d is not a prime: %d is a divisor" % (x, i))
            return False
    print("%d is a prime!" % x)
    return True

def find_all_primes(x=22):
    """Find all the primes up to x"""
    allprimes = []
    for i in range (2, x + 1):
        if is_prime(i):
            allprimes.append(i)
    print("There are %d primes bewteen 2 and %d" % (len(allprimes), x))
    return allprimes 

def main(argv): #running all the functions with specified input 
    even_or_odd(22)
    even_or_odd(33)
    largest_divisor_five(120)
    largest_divisor_five(121)
    is_prime(60)
    is_prime(59)
    print(find_all_primes(100))
    return 0 

if __name__ == "__main__": 
    status = main(sys.argv)
    sys.exit(status)
   


