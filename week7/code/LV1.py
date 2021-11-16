""" Integrating the Lotka-Volterra model to calcuate the population density at different time points """

import numpy as np
import matplotlib.pylab as p
import scipy.integrate as integrate

## Lotka-Volterra model ##

# dR/dt = rR - aCR
# dC/dt = eaCR - zC

# R and C are the predator and prey popualtion abundances (number/area)
# r is the intrinsic growth rate of prey
# a is the per-capita "search rate" for the prey multiplied by its attack success probability
# i.e. the encounter and consumption rate of the consumer on the resource
# z is mortality rate of predator
# e is the predator's efficienty (fraction) in converting prey to biomass

# Need to integrate the equations by t to be able to add time as a variable 
# Defining a function that returns the growth rate of predaor and prey at any given time

def dCR_dt(pops, t=0):
    """ function that contains the Lotka-Volterra model """ 
    R = pops[0]
    C = pops[1]
    dRdt = r*R - a*R*C
    dCdt = e*a*R*C - z*C 

    return np.array([dRdt, dCdt])

type(dCR_dt)

# Defining parameters
r = 1.
a = 0.1
z = 1.5
e = 0.75

# Defining the time vector, integrating from time point 0 to 15, using 1000 sub-divisions of time
# linspace() returns evenly spaced numbers over a specified interval 
t = np.linspace(0, 15, 1000) # takes 1000 numbers between 0 and 15 at even interval

# Defining the initial populations 
R0 = 10
C0 = 5
RC0 = np.array([R0, C0])

# Integrating the equations in dCR_dt
# odeint() integrate a system of ordinary differential equations
# first parameter: a function that contains the equations
# 2nd parameter: an array that contains the initial condition of y
# 3rd parameter: sequence of time points for which to solve for y
# full_output=T produce a dictionary contianing additional info
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output = True)
pops
type(infodict)
infodict.keys()

# Plotting the results 1
f1 = p.figure() # assigning a object for the figure

# plot a line with t on x-axis, first column of pops on y-axis
p.plot(t,pops[:,0], 'g-', label="Resource density") # 'g-' gives green line
p.plot(t, pops[:,1], "b-", label="Consumer density")
p.grid() # adds grid
p.legend(loc="best") # add legend
p.xlabel("Time")
p.ylabel("Popualtion density")
p.title("Consumer-Resource popualtion dynamics")
#p.show()

# Saving the figure as pdf
f1.savefig("../results/LV_model.pdf")


# Plotting the result 2
f2 = p.figure()
p.plot(pops[:,0], pops[:,1], "r-")
p.grid()
p.xlabel("Resource density")
p.ylabel("Consumer density")
p.title("Consumer-Resource population dynamics")
#p.show()
f2.savefig("../results/LV_model2.pdf")