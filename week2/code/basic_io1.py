##########################
#FILE INPUT
##########################

"""Print the content of "test.txt" twice, once as it is and once with empty lines removed"""

# Open a file for reading ('r')
with open('../sandbox/test.txt','r') as f:
# use "implicit" for loop:
# if the object is a file, python will cycle over lines
    for line in f:
        print(line) 

# close the file no longer needed when 'with' is used
#f.close()

# Same example, skip blank lines
f = open('../sandbox/test.txt','r')
for line in f:
    if len(line.strip())>0:
        print(line)

f.close()
