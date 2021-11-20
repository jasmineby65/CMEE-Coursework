#####################################
# STRONG OBJECTS
#####################################

""" Print and save a file named "test.p" that contains the dictionary:  
{'a key': 10, 'another key':11} """

# To save an object (even complex) for later use
my_dictionary = {'a key': 10, 'another key':11}

#pickle serialise objects 
#(i.e. convert data (e.g. binary) in RAM to text format on disk) 
#allowing data in the form of dictionaries (and others) to be saved as file
import pickle 

f = open('../sandbox/test.p','wb') ## b = accept binary files
pickle.dump(my_dictionary,f) ##pickling 
f.close()

## Load the data again
f = open('../sandbox/test.p','rb')
another_dictionary=pickle.load(f) ##unpickling 
f.close()

print(another_dictionary)
