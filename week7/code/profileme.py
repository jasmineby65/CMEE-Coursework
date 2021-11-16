## Profiling ##
# Run the script in ipython with "run -p "
# Or "python3 -m cProfile xxx.py" from bash
# Allows identificaton of functions that are slowing the code down

""" Example functions to be tested for code running time """ 

def my_squares(iters):
    """ function that produce a list of squared number series """
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """ function that joins "string" iters times, seperated by "," """
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x,y):
    """ Runs function my_squares and my_join """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0 

run_my_funcs(10000000, "My string")

