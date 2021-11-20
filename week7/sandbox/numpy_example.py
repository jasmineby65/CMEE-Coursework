""" Example uses of numpy package """

# Importing package 
import numpy as np

# making a numpy array
# the data associated with a numpy array are all stored in a particualr address 
# in the system's RAM instead of being scarred across the system memory
# Making it more efficient when performing large calculations 

a = np.array(range(5))
a

print(type(a))
print(type(a[0]))

a = np.array(range(5), float)
a.dtype

# Makes a 1-D array
x = np.arange(5)
x

x = np.arange(5.)
x
x.shape # gives the dimention of array

# Convert from and to lists
b = np.array([i for i in range(10) if i % 2 == 1])
b

c = b.tolist() # convert to list
c

mat = np.array([[0,1], [2,3]])
mat
mat.shape

# Context of numpy array can be accessed in the same way as lists
mat[1]
mat[:,1] # accessing whole second column
mat[0,0]
mat[1,0]
mat[0, -1] # negative number indicate count from back 

mat[0,0] = -1 # replace a single element
mat[:,0] = [12,12] # replace whole column 

# Appending row/column to array
# This only does the operation, to save the appended array, need to assign it to a object
np.append(mat, [[12,12]], axis=0) # axis = 0 is to append row
# this is adding a row, so a single list
np.append(mat, [[12],[12]], axis=1) # axis = 1 is to append column 
# this is adding to column (across multiple lists) so need to be individual lists

newRow = [[12,12]]
mat = np.append(mat, newRow, axis=0)
mat

np.delete(mat, 2, 0) # deleting 3rd row

# Concatinating arrays
# This also just does the operation, but doens't save the array without assigning object
mat = np.array([[0,1], [2,3]])
mat0 = np.array([[0,10],[-1,3]])
np.concatenate((mat,mat0), axis = 0) # concatinate by row
np.concatenate((mat,mat0), axis = 1) # concatinate by column

# Flattening arrays (change from array to vector)
mat.ravel() # row-priority i.e. start arranging from rows 

# Reshaping arrays
mat.reshape((4,1)) # 4 rows, 1 column
mat.reshape((1,4)) # 1 row, 4 columns

# Pre-allocation 
# make arrays filled with float 1
np.ones((4,2))
# make arrays filled with float 0
np.zeros((4,2))
# makes an identity matrix
m = np.identity(4) # 4x4 matrix
m
# fill the matrix with specific value
m.fill(16)
m



## Matrix data structure ##
# A subclass specialised in matrix, useful for matrix multiplication 
# But will probabily be removed soon so don't need to bother remembering this

mm = np.arange(16)
mm = mm.reshape(4,4)
mm

mm.transpose() # transpose matrix

mm + mm.transpose() # apply the calculation to elements in matrix at the same position

mm - mm.transpose()

mm * mm.transpose() # multiply each element by elements from the same position

mm // mm.transpose()

mm // (mm + 1).transpose()

mm.dot(mm) # actual mathmatical way of multiplying matrix i.e. column x row 

# Converting to the matrix class
mm = np.matrix(mm) 
mm
print(type(mm))

mm * mm # Multiplication of matrix class is the equivelant of .dot()