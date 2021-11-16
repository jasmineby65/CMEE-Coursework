## timeit ##
# Loops at the time of specific function within the program instead of whole program
# Run "%timeit function(x)" (need to import timeit) in the terminal

""" Testing timeit for profiling """ 

#################################################
# loops vs list comprehensions: which is faster?
#################################################

iters = 10000000

import timeit

from profileme import my_squares as my_squares_loop
from profileme2 import my_squares as my_square_lc


#####################################################
# loops vs join method for strings: which is faster?
#####################################################
mystring = "my string"

from profileme import my_join as my_join_join
from profileme2 import my_join as my_join


