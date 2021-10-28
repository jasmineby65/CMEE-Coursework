#!/usr/bin/env python3

""" Takes DNA sequences from two fasta files 
and save the best alignment and the corresponding score 
in a single text file """

__appname__ = 'align_seqs_fasta'
__author__ = 'Jasmine'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import sys
import csv 

## A function that import DNA sequences from a fasta file and save it as a string 
def import_fasta(x):
    """ Import DNA sequences from a fasta file and save it as a string variable"""
    with open(x,'r') as a:
        lines = a.readlines()
        strip = ""
        for l in lines[1:]:
            strip += str(l.strip()) 
        return strip

## A function that assgin inputs from two fasta files to variables depending on sequence length  
def prepare_sequence(x="../data/407228326.fasta",y="../data/407228412.fasta"):
    """assgin inputs from two fasta files to specific variables depending on sequence length """
    seq1 = import_fasta(x)
    seq2 = import_fasta(y)

    l1 = len(seq1)
    l2 = len(seq2)
 
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 
    
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
   
    best_result = {"my_best_score":-1, "my_best_align": [], 
                    "my_best_alignment" : []}
    # making a dictionary to store multiple results
 
    for i in range(l1):
        z = calculate_score(s1,s2,l1,l2,i)
        if z[0] == best_result["my_best_score"]:
        # appending same score result to dictionary 
            best_result["my_best_align"].append(str("." * i + s2))
            best_result["my_best_alignment"].append(z[1])

        if z[0] > best_result["my_best_score"]:
            best_result.clear()
            best_result = {"my_best_score":z[0], "my_best_align": [], 
                           "my_best_alignment" : []}
            best_result["my_best_align"].append(str("." * i + s2))
            best_result["my_best_alignment"].append(z[1])


    with open("../results/improved_alignment_result.txt","w+") as result:
        result.write("Best score: {0} ".format(best_result["my_best_score"]) 
                      + "({0} alignments found with this score)".format(\
                          len(best_result["my_best_align"])) + "\n\n")

        for i in range(len(best_result["my_best_align"])):
            result.write("Alignment {0}:".format(i+1) + "\n")
            result.write(best_result["my_best_alignment"][i] + "\n")
            result.write(best_result["my_best_align"][i] + "\n")
            result.write(s1 + "\n\n")
    
    print("Text file made!")
    return    
    

def main(argv): 
    """Makes sure the "main" function is called from command line"""  
    if len(argv) == 1:
        s1, s2, l1, l2 = prepare_sequence()
    else:
        s1, s2, l1, l2 = prepare_sequence(argv[1],argv[2])
    best_alignment(s1, s2, l1, l2)
    return  

if __name__ == "__main__": 
    status = main(sys.argv)
    sys.exit(status)