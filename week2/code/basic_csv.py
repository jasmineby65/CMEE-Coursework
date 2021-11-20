"""
Produce a csv file named "bodymass.csv" that contains data of species names and body mass extracted from testcsv.csv  
"""

import csv

# Read a file containing:
# 'Species', 'Infraorder', 'Family', 'Distribution', 'Body mass male (kg)'
with open('../data/testcsv.csv','r') as f:
    csvread=csv.reader(f)
    temp = []
    for row in csvread:
        temp.append(tuple(row))
        print(row)
        print('The species is',row[0])

# write a file containing only species name and Body mass
with open('../data/testcsv.csv','r') as f:
    with open('../data/bodymass.csv','w') as g:
        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            print(row[0],row[4])
            csvwrite.writerow([row[0],row[4]]) #always use  ([]) for the content
            