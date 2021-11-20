#!/usr/bin/env python3

"""Print the name of the script, number of arguments, and the arguments."""

import sys
print("This is the name of the script:", sys.argv[0])
print("Number of argumetns:", len(sys.argv))
print("The arguments are:", str(sys.argv))

# sys.argv is a list that contains the command-line arguments passed to the script 
# command-line arguments are input parameters passed to the script when executing them 
# the first one on the list is always the name of the script 
# e.g. `run sysargv.py var1 var2` gives 3 arguments:['sysargv.py', 'var1', 'var2']