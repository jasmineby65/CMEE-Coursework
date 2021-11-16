""" Improved example functions to be tested for code running time """ 

## Improved speed ##
import numpy as np

# Comprehensions saves time compared to for loops
# Preallocating numpy arrays saves more time than allocating list
def my_squares(iters):
    """ function that produce a list of squared number series """
    out = np.array(i ** 2 for i in range(iters))
    return out

# join() is slower than "+" to concatinate variables 
def my_join(iters, string):
    """ function that joins "string" iters times, seperated by "," """
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """ Runs function my_squares and my_join """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0 

run_my_funcs(10000000, "My string")

# Arguments for profiling
# -s sorts the result by specified section e.g. "run -p -s cuttime xxx.py"
# -l filters the results by function name and reduce the number of lines displayed
# -T saves the report in a text file