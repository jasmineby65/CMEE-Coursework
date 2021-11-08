# DataWrang.R
Wrangling the Pound Hill Dataset.  
Language: R

### Usage
```R
source("DataWrang.R")
```

&nbsp;

# DataWrangTidy.R
Wrangling the Pound Hill Dataset using the tidyverse package.  
Language: R  

### Usage
```R
install.packages("tidyverse")
source("DataWrangTidy.R")
```

&nbsp;

# Florida_warming.R
Perform a permutation analysis on the annual temperature dataset from Key West in Florida to examine whether Florida is warming. 
Produces two PDF images (Florida1.pdf, Florida2.pdf). Results are summarised in Florida_result.tex (LaTeX).  
Language: R

### Usage
```R
install.pacakages("ggplot2")
source("Florida_warming.R)
```

&nbsp;

# GPDD_Data.R
Produces a world map that shows the location of species for which popualtion time series are available in the Global Population 
Dynamics Database (GPDD).  
Language: R

### Usage
```R
install.packages("maps")
source("GPDD_Data.R)
```

&nbsp;

# Girko.R
Plots a PDF (Girko.pdf) illustrating the Girko's circualr law.  
Language: R

### Usage
```R
install.packages("ggplot2")
source("Girko.R")
```

&nbsp;

# MyBars.R
Plots a bar charts (MyBars.pdf) from the Results.txt.   
Language: R

### Usage
```R
install.packages("ggplot2")
source("MyBars.R")
```

&nbsp;

# PP_Dists.R
Produces PDF figures of predator mass distribution (Pred_Subplots.pdf), prey mass distribution (Prey_Subplots.pdf), 
prey/predator mass ratio distribution (SizeRatio.pdf) by feeding interaction types from the Consumer-Resource body mass
ratios dataset by Barnes *et al.* Also produce a csv file (PP_Results.csv) containing the mean and median values summarising these plots.  
Language: R

### Usage
```R
install.packages("tidyverse")
source("PP_Dists.R")
```

&nbsp;

# PP_Regress.R
Produces a PDF figure (PP_Regress.pdf) illustrating the relationship of predator mass and prey mass distribution at different predator lifestages and feeding interation types from the Consumer-Resource body mass ratios dataset by Barnes *et al.* 
Also produce a csv file (PP_Regress_Results.csv) containing the slope, intercept, r-squared, F-statistic, and p-value of linear models fitted to each combination.   
Language: R

### Usage
```R
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("plyr")
source("PP_Regress.R")
```

&nbsp;

# Ricker.R
Runs a simulation of the Ricker model.  
Language: R

### Usage
```R
source("Ricker.R")
```

&nbsp;

# SQLinR.R
Create and modify a database named "Test.sqlite".  
Language: R

### Usage
```R
install.packages("sqldf")
source(SQLinR.R)
```

&nbsp;

# TreeHeight.R
Calculates heights of trees given distance of each tree from its base and along to its top, using the trignometric formula.  
Language: R

### Usage
```R
source(TreeHeight.R)
```

&nbsp;

# Vectorize1.R
Example demonstrating the use of vectorised function (sum()).  
Language: R

### Usage
```R
source(Vectorize1.R)
```

&nbsp;

# Vectorize2.R
Runs two versions of the stochastic Ricker equation with gaussian (normal) fluctuations. One unvectorized, one vectorized.  
Language: R

### Usage
```R
source("Vectorize2.R")
```

&nbsp;

# apply1.R
Example use of the `apply()` function.  
Language: R

### Usage
```R
source("apply1.R")
```

&nbsp;

# apply2.R
Example use of the `apply()` function.  
Language: R

### Usage
```R
source("apply2.R")
```

&nbsp;

# basic_io.R
Example uses of `write.csv()` and `write.table()` functions to export data.  
Language: R

### Usage
```R
source("basic_io.R")
```

&nbsp;

# boilerplate.R
Prints the first two arguments entered in a function ("Riki" and "Tiki" by default).  
Language: R

### Usage
```R
source(boilerplate.R)
```

&nbsp;

# break.R
Example use of the control flow statement `break` to break a for loop.  
Language: R

### Usage
```R
source("break.R")
```

&nbsp;

# browse.R
Example use of the `browser()` function, which inserts a breakpoint in the script and step through the code one line at a time, allowing debugging.  
Language: R

### Usage
```R
source(browse.R) # Only works when run from the R terminal 
```

&nbsp;

# control_flow.R
Example uses of the control flow statements `if`, `else`, `for`, and `while`.  
Language: R

### Usage
```R
source("control_flow.R")
```

&nbsp;

# next.R
Example use of the control flow statement `next`, which skips to the next iteration of loop.  
Language: R

### Usage
```R
source("next.R")
```

&nbsp;

# plotLin.R
Plots a annoated PDF (MyLinReg.pdf) of linear regression data.   
Language: R

### Usage
```R
install.packages("ggplot2")
source("plotLin.R")
```

&nbsp;

# preallocate.R"
Compares the speed of function excution with and without pre-allocating memory for vector.  
Language: R

### Usage
```R
source("preallocate.R")
```

&nbsp;

# sample.R
Compares the speed of function excution with and without pre-allocating memory for vector and the use of `sapply()` and `lapply()` functions.   
Language: R

### Usage
```R
source("sample.R")
```

&nbsp;

# try.R
Example use of the `try` keyword, which keeps the code running even when error occurs, combined with the `else` control flow statement to print a specific error message.  
Language: R

### Usage
```R
souce("try.R")
```

