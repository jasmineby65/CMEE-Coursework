import csv

with open('407228412.fasta','r') as a:
    lines1 = a.readlines()
    strip1 = ""
    for line in lines1[1:]:
        strip1 += str(line.strip()) 
        # += iterate over an iterable object appending each element to itself 
  
#print(strip1)
    
with open('407228326.fasta','r') as b:
    lines2 = b.readlines()
    strip2 = ""
    for line in lines2[1:]:
        strip2 += str(line.strip()) 
        # += iterate over an iterable object appending each element to itself 
  
#print(strip2)

with open("sequence.csv","w") as c:
    write = csv.writer(c)
    write.writerow([strip1]) 
    # need to add [] to make it recognise as one string
    # else it will put each character in individaul cells 
    write.writerow([strip2])
