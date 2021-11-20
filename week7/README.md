# DrawFW.py  
Creates and plot a simple food web network with node sized corresponding to each species's biomass.  
Language: python3  

### Usage
```python
# Required packages: networkx, sumpy, matplotlib.pylab
%run DrawFW.py
```

&nbsp;

# LV1.py
Integrating the Lotka-Volterra model to calcuate the population density at different time points and produce two pdf plots from example data.  
Language: python3

### Usage
```python
# Required packages: numpy, matplotlib.pylab, scipy.integrate 
%run LV1.py

# Functions:
import LV1
dCR_dt(pops, t=0) # Function that contains the Lotka-Volterra model
``` 

&nbsp;

# oaks_debugme.py
Runs through species name in a csv file and saves the oak species (Quercus) in a new csv (JustOaksData.csv).   
Language: python3

### Usage
```python
# Required packages: csv, sys
%run oaks_debugme.py

# Functions:
import oaks_debugme.py
is_an_oak(name) # Returns True if name is starts with 'Quercus'
```

&nbsp;

# profileme.py
Example functions to be tested for code running time.  
Language: python3 

### Usage
```python
import profileme

# Function that produce a list of squared number series
my_squares(iters)

# Function that joins "string" iters times, seperated by ","
my_join(iters, string)

# Runs function my_squares and my_join 
run_my_funcs(x,y)
```

&nbsp;

# profileme2.py
Improved example functions to be tested for code running time.  
Language: python3

### Usage 
```python
#Required packages: numpy
import profileme2

# Function that produce a list of squared number series 
my_squares(iters)

# Function that joins "string" iters times, seperated by ","
my_join(iters, string)

# Runs function my_squares and my_join
run_my_funcs(x,y)
```

&nbsp;

# regexs.py
Examples of using regex for seaching in Python.  
Language: python3

### Usage
```python
# Required packages: re, urllib3
%run regex.py
```

&nbsp;

# TestR.py
Running R from python using subprocess.  
Language: python3 & R

### Usage
```python
# Required packages: subprocess
%run TestR.py
```

&nbsp;

# TestR.R
Print "Hello, this is R!".  
Language: R

### Usage
```R
source("TestR.R")
```

&nbsp;

# timeitme.py
Testing timeit for profiling.  
Language: python3

### Usage
```python
# Required packages: timeit, profileme.py, profileme2.py
%run timeitme.py

# Profiling functions from profileme.py and profileme2.py
%timeit my_squares_loops(iters)
%timeit my_squares_lc(iters)
%timeit (my_join_join(iters, mystring))
%timeit (my_join(iters, mystring))
```