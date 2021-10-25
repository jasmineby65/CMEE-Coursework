#!/usr/bin/env python3

""" Examples of use of conditionals """

__author__= "Kind of by me (credits to Google and Frances and everyone else)"
__version__ = '0.0.1'

import sys 

def foo_1(x):
    """calculate square root of x"""
    return x ** 0.5

def foo_2(x,y):
    """print the larger value input"""
    if x>y:
        return x
    return y

def foo_3(x,y,z):
    """sorting the number from small to large"""
    if x>y:
        tmp=y
        y=x
        x=tmp
    if y>z:
        tmp =z
        z=y
        y=tmp
    if x>y:
        tmp=y
        y=x
        x=tmp
    return[x,y,z]


def foo_4(x):
    """factorial of x"""
    result = 1
    for i in range(1, x+1):
        result = result * i
    return result

def foo_5(x): 
    """a recursive function that calculates the factorial of x"""
    if x==1:
        return 1
    return x*foo_5(x-1)

def foo_6(x): 
    """calculate the factorial of x in a differnt way"""
    facto =1
    while x >= 1:
        facto = facto * x
        x = x-1
    return facto 
    
def main(argv): 
    """running all the functions with specified input"""
    print(foo_1(9))
    print(foo_2(5,10))
    print(foo_3(1,2,3))
    print(foo_4(6)) 
    print(foo_5(6))
    print(foo_6(6))

    return 0 

if __name__ == "__main__": 
    status = main(sys.argv)
    sys.exit(status)