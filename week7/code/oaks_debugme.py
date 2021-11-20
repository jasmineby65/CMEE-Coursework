""" Runs through species name in a csv file and saves the oak species (Quercus) in a new csv (JustOaksData.csv) """

import csv
import sys

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'Quercus' 
    
    >>> is_an_oak("Quercus")
    True
    
    >>> is_an_oak("Genus")
    False

    >>> is_an_oak("Fraxinus")
    False

    >>> is_an_oak("Pinus")
    False

    >>> is_an_oak("Quercuss")
    False
    """
    return name == 'Quercus'

def main(argv): 
    """ Produce a csv file containing the name of oak species found in the input csv file """
    f = open('../data/TestOaksData.csv','r')
    g = open('../results/JustOaksData.csv','w')
    taxa = csv.reader(f)
    next(taxa, None) # Skips a row i.e. ignores header
    csvwrite = csv.writer(g)
    oaks = set()
    #import ipdb; ipdb.set_trace()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)