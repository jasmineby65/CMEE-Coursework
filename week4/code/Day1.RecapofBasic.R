### Introduction to Stats in R 

## Recap of basics 

# Counting number of data point 
d <- read.table("../data/SparrowSize.txt", header=T)
str(d)
head(d)
summary(d)

table(d$Year) # Shows the number data input of each year 
table(d$BirdID)
table(table(d$BirdID)) # table() shows the number of each data point 

# Alternative method using dplyr
library(dplyr)
BirdIDCount <- count(d,BirdID, sort=T, name="No_of_times_caught")
# count() counts the unique values of one or more variables in a data frame
# sort=T will display result from the largest group 
# this code counts how many times each individual is caught 
BirdIDCount
count(BirdIDCount,No_of_times_caught)
# this counts how many times No_of_times_caught occurs 


## Exercises
# 1. How many repeats are there per bird per year?
CountPerBirdPerYear <- count(d, BirdID, Year, name="No_of_Repeat_per_Year")
CountPerBirdPerYear

# 2. How many individuals did we capture per year for each	sex? 
SexPerYear <- count(d, Year, Sex.1, name="No_of_each_sex_caught_per_year")
SexPerYear

# 3. Make a table and plot for (1) and (2)
