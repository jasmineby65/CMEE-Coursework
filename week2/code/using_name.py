#!/usr/bin/env python3

"""
Print the name of module ("__main__" in this script)  
"""

# Filename: using_name.py

if __name__ == '__main__':
    print("This program is being run by itself")
else:
    # when this is not the main program i.e. its imported 
    print("I am being imported from another module")

print("This module's name is:" + __name__)
