#!/usr/bin/env python3

""" Takes two DNA sequences from a csv file 
and saves the best alignment and the corresponding score 
in a single text file """

__appname__ = 'align_seqs'
__author__ = 'Jasmine'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import sys
import csv 

## A function that import two sequences from csv.file 
def import_sequence(x):
    """Import DNA sequences from a csv file and extract the sequnce and sequnce length"""
    sequence = []
    with open(x,'r') as r:
        lines = r.readlines()
        # readlines() makes a list from the csv file
        # csv.reader() makes a csv.reader file which has to be converted to other format
        # but converting to list will make each row a list 
        # so when that's converted to string, each element will have the [] bracket 

        for l in lines:
            sequence.append(str(l.strip()))
        seq1 = sequence[0]
        seq2 = sequence[1]
    
    # Importing as dictionary: should use this if there is more than two sequences being compared
    # sequence = {}
    # with open(x,'r') as r:
        # lines = r.readlines()
        # for i, line in enumerate(lines): 
        # enumerate() gives the row number 
            #sequence["seq{0}".format(i+1)] = str(line.strip())

    l1 = len(seq1)
    l2 = len(seq2)
    # Assign the longer sequence s1, and the shorter to s2
    # l1 is length of the longest, l2 that of the shortest
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths
    return s1, s2, l1, l2


## A function that computes a score by returning the number of matches starting 
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    """computes a score by returning the number of matches starting from arbitrary startpoint (chosen by user)"""
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
        # making sure the two sequence overlap 
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"
    alignment = ("." * startpoint + matched)
    output = [score, alignment]
    return output



## A function that finds the best match (highest score) for the two sequences
def best_alignment(s1, s2, l1, l2):
    """ finds the best alighment for two sequnces imported from a csv file"""
    my_best_align = None
    my_best_score = -1
    my_best_alignment = ""

    with open("../results/alignment_result.txt","w+") as result:
      
    # If the best alignment is no alighment, then 0 is the highest score
    # If this was already 0, it won't recognise no alignment as best alignment 
        for i in range(l1):
        # Note that you just take the last alignment with the highest score
        # Length of s1 is used instead of s2 to try every alignment 
            z = calculate_score(s1,s2,l1,l2,i)
            if z[0] > my_best_score:
                my_best_align = "." * i + s2
                # making a line that shows the best alignment position 
                my_best_score = z[0] 
                my_best_alignment = z[1]

        result.write(my_best_alignment)
        result.write("\n")
        result.write(my_best_align)
        result.write("\n")
        result.write(s1)
        result.write("\n")
        result.write("Best score: {0}".format(my_best_score))
        
        return 


def main(argv): 
    """Makes sure the "main" function is called from command line"""  
    s1, s2, l1, l2 = import_sequence("../data/sequence2.csv")
    best_alignment(s1, s2, l1, l2)
    return 0 

if __name__ == "__main__": 
    status = main(sys.argv)
    sys.exit(status)