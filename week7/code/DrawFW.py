"""Creating a simple food web network"""

import networkx as nx # used for building network
import numpy as np
import matplotlib.pylab as p

def GenRdmAdjList(N=2, C=0.5):
    """ 
    Generating a symthetic food web consisting of a random adjacency list (a matrix with consumer in 1st column and 
    resource in the 2nd column and a seperate matrix of each species' properties e.g. biomass) of a N-species food web
    with connectance probability of C (the probability of having a link between any pair of species in the food web)
    """
    Ids = range(N)
    ALst = []
    for i in Ids:
        if np.random.uniform(0,1,1) < C: # A random no. bewteen 0 and 1
            Lnk = np.random.choice(Ids,2).tolist() 
            # generate a random sample from an given array (2 from Ids here) and assign it as a list
            if Lnk[0] != Lnk[1]: # avoiding assigning the same species for both position
                ALst.append(Lnk)
    return ALst


MaxN = 30
C = 0.75

# Generating adjacency list: 
# Pairs of consumer id and resource id that have interaction 
AdjL = np.array(GenRdmAdjList(MaxN,C))
AdjL

# Generating species data (nodes)
Sps = np.unique(AdjL) # Obtaining a list of species from the adjacency list
Sps

# Body size for the species
SizRan = ([-10,10]) # In log10 scale
Sizs = np.random.uniform(SizRan[0], SizRan[1], MaxN)
Sizs

p.hist(Sizs)
#p.show()

p.hist(10 ** Sizs) # In raw scale
#p.show()

p.close("all") # Closing all the open plot objects

# Plotting the network #
# Making a circular configuration for each species 
pos = nx.circular_layout(Sps)
pos

G = nx.Graph() # Making a networkx graph object
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL)) # Only takes a tuple object

# Generate node sizes proportional to the log body size
NodSizes = 400 * (Sizs - min(Sizs)/(max(Sizs) - min(Sizs)))
NodSizes 

# Plotting the nexwork 
fig = p.figure(figsize=(15,10))
nx.draw_networkx(G, pos = pos, node_size = NodSizes)
p.show()
fig.savefig("../results/FoodWed.pdf")