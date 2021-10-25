#!/usr/bin/env python3

""" Takes two DNA sequences from a csv file 
and saves the best alignment and the corresponding score 
in a single text file """

__appname__ = 'align_seqs'
__author__ = 'Jasmine'
__version__ = '0.0.1'
__license__ = "License for this code/program"



import sys

## A function that import two sequences from csv.file 
def import_sequence(x):
    """Import DNA sequences from a csv file and extract the sequnce and sequnce length"""
    sequence = {}
    with open(x,'r') as r:
        lines = r.readlines()
        for i, line in enumerate(lines): 
        # enumerate() gives the row number 
            sequence["seq{0}".format(i+1)] = str(line.strip())

    l1 = len(sequence["seq1"])
    l2 = len(sequence["seq2"])
    # Assign the longer sequence s1, and the shorter to s2
    # l1 is length of the longest, l2 that of the shortest
    if l1 >= l2:
        s1 = sequence["seq1"]
        s2 = sequence["seq2"]
    else:
        s1 = sequence["seq2"]
        s2 = sequence["seq1"]
        l1, l2 = l2, l1 # swap the two lengths
    input = {"s1":s1, "s2":s2, "l1":l1, "l2":l2}
    return input 



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
    result = [score, alignment]
    return result



## A function that finds the best match (highest score) for the two sequences
def best_alignment(x):
    """ finds the best alighment for two sequnces imported from a csv file"""
    my_best_align = None
    my_best_score = -1
    my_best_alignment = ""
    # If the best alignment is no alighment, then 0 is the highest score
    # If this was already 0, it won't recognise no alignment as best alignment 
    with open("../results/alignment_result.txt","w+") as result:
        for i in range(import_sequence(x)["l1"]):
        # Note that you just take the last alignment with the highest score
        # Length of s1 is used instead of s2 to try every alignment 
            z = calculate_score(import_sequence(x)["s1"],import_sequence(x)["s2"],\
                import_sequence(x)["l1"],import_sequence(x)["l2"], i)
            if z[0] > my_best_score:
                my_best_align = "." * i + import_sequence(x)["s2"] 
                # making a line that shows the best alignment position 
                my_best_score = z[0] 
                my_best_alignment = z[1]
        result.write(my_best_alignment)
        result.write("\n")
        result.write(my_best_align)
        result.write("\n")
        result.write(import_sequence(x)["s1"])
        result.write("\n")
        result.write("Best score: {0}".format(my_best_score))
        return 


def main(argv): 
    """Makes sure the "main" function is called from command line"""  
    best_alignment("../data/sequence.csv")
    return 0 

if __name__ == "__main__": 
    status = main(sys.argv)
    sys.exit(status)