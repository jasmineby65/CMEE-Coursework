""" Comparison of loop and vectorized method using numpy """

import numpy as np

def loop_product(a,b):
    """ Calcualte the entrywise produce of arrays a and b using for loops """
    N = len(a)
    c = np.zeros(N)
    for i in range(N):
        c[i] = a[i] * b[i]
    return c

def vect_product(a,b):
    """ Calcualte the entrywise produce of arrays a and b using vectorisation with numpy """
    return np.multiply(a,b)

import timeit

array_lengths = [1, 100, 1000, 1000000, 100000000]
t_loop = []
t_vect = []

for N in array_lengths:
    print("\nSet N=%d" %N)
    # randomly generate our 1D arrays of legnth N
    a = np.random.rand(N)
    b = np.random.rand(N)

    # run loop_product 3 times save the mean execution time
    timer = timeit.repeat('loop_product(a,b)', globals=globals().copy(), number=3)
    # globals().copy() copies the global variables (those outside this function)
    t_loop.append(1000*np.mean(timer))
    print("Loop method took %d ms on average" %t_loop[-1])

    # run vect_product 3 times and save the mean excution time
    timer = timeit.repeat('vect_product(a,b)', globals=globals().copy(), number=3)
    t_vect.append(1000*np.mean(timer))
    print("Vectorised method took %d ms on average." %t_vect[-1])


import matplotlib.pylab as p
p.figure()
p.plot(array_lengths, t_loop, label="loop method")
p.plot(array_lengths, t_vect, label="vect method")
p.xlabel("Array length")
p.ylabel("Execusion time (ms)")
p.legend()
p.show() 

## Vectorisation saves time but takes up a lot of memory space! 
## If memory space run out, you will get a memory error 





