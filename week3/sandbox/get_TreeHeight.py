#!/usr/bin/env python3

""" 
This program calculates heights of trees given distance of each tree 
from its base and along to its top, using the trignometric formula: 
height = distance * tan(radians)

ARGUMENTS:
degrees: the angle of elevation of tree
distance: the distance from base of tree (e.g. meters)

OUTPUT:
The height of the tree, same units as "distance"

"""

import sys
import csv
import math
import os

def TreeHeight(degrees, distance):
    """Calculates heights of trees given distance of each tree from its base and along to its top"""
    radians = float(degrees) * (math.pi/180)
    height = float(distance) * (math.tan(radians))
    return height

def output_name(path):
    """Remove path and file extension from a file path"""
    base = os.path.basename(path) # Removing path
    name = os.path.splitext(base)[0] # Removing file extension 

    path = ("../results/", name, "_treeheights.csv")
    final = "".join(path)
    return final

def main(argv):
    output_file = output_name(sys.argv[1])

    with open(sys.argv[1],'r') as f:
        with open(output_file, 'w') as g:

            csvread = csv.reader(f)
            csvwrite = csv.writer(g)

            # Making header
            header = []
            header = next(csvread)
            header.append("Tree.Height.m")
            csvwrite.writerow(header)

            for row in csvread:
                height = TreeHeight(row[2], row[1])
                row.append(height)
                csvwrite.writerow(row)

            return print("csv file made in results directory")


if __name__ == "__main__": 
    status = main(sys.argv)
    sys.exit(status)