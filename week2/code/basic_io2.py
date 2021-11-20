#####################
# FILE OUTPUT
#####################

"""
Produce a text file named "testout.txt" that contains the number 0 to 99, each written on a new line  
"""

# Save the elements of a list to a file
list_to_save = range(100)

f = open('../sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i) + '\n') ## Add a new line at the end

f.close()
