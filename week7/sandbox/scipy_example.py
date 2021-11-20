""" Example uses of scipy package """ 

## scipy should be used for calculations using arrays whereas 
# numpy is enough if just manipulating the dataset #


## scipy.stats##
# Importing subpackages
import scipy.stats as stats
import numpy as np

# Generating 10 samples from normal distribution and form a matrix
stats.norm.rvs(size=10) # "rvs" - random variable of given types
np.random.seed(1234) # setting seed for random numbers
stats.norm.rvs(size=10)

stats.norm.rvs(size=5, random_state=1234) # setting seed for each operation

# Generate random samples from specific interval
stats.randint.rvs(0, 10, size=7) # pick 7 samples of integers between 0 and 10
stats.randint.rvs(0, 10, size = 7, random_state=1234)


## scipy.integrate ##
# Used for integration 
import scipy.integrate as integrate

## Calculating area under curve ##
y = np.array([5,20,18,19,18,7,4])

# Plotting y
import matplotlib.pylab as p
p.plot(y)
p.show() # display the plot 

# Composite trapezoidal rule - area estimated using area of trapezoid
# integrate along the given axis using the composite trapezoidal rule
area = integrate.trapz(y, dx=2) # dx specify the spaciong between points of the curve (x-axis value)
print("area with scaler 2 =", area)

area = integrate.trapz(y, dx=1) 
print("area with scaler 1 =", area)

area = integrate.trapz(y, dx=3) 
print("area with scaler 3 =", area)

# Simpson's rule - area estimated by fitting multiple quadratic plot simialr to shape of the original plot]
area = integrate.simps(y, dx=2) # also has scaler, the smaller the scale the closer to real area
print("area with scaler 2 =", area)

area = integrate.simps(y, dx=1) 
print("area with scaler 1 =", area)


