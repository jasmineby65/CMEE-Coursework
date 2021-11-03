####################################################################
######## Wrangling the Pound Hill Dataset using Tidyverse ##########
####################################################################

rm(list=(ls()))
require(tidyverse)

############# Load the dataset ###############
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE, stringsAsFactors=F))
# header = false because the raw data don't have real headers
# Make sure header= is within the read.csv()! Not the matrix()

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)
fix(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0
head(MyData)

############# Convert raw matrix to data frame ###############
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) 
#stringsAsFactors = F is important!
#[-1,] REMOVES the first row (column names) from the newly converted data.frame 
# This is needed because the column names at this point is still recognised as 
# normal data point rather than headers
head(TempData)
colnames(TempData) <- MyData[1,] # assign column names from original data
head(TempData) 
dim(TempData)

############# Convert from wide to long format  ###############
require(tidyverse) 
TempData <- tibble::as_tibble(TempData) # Converting the dataframe to tbl
head(TempData)
tibble::glimpse(TempData)

MyWrangledData <- tidyr::pivot_longer(TempData, col=5:45, names_to="Species", values_to="Count")
# Transpose the name of column 5:45 to a column called "Species" and the values in column to "Count"  
head(MyWrangledData)
tibble::glimpse(MyWrangledData)
tibble::view(MyWrangledData)

# Converting variable type of each columns 
MyWrangledData <- MyWrangledData %>% # this is a pipe that runs all the piped functions on the dataframe
  dplyr::mutate(across(1:5, as.factor)) %>% 
  # mutate() applies a function to columns and returns a new column so needs to be applied to a specific dataframe 
  dplyr::mutate(across(6, as.integer)) # across() specify which column 

head(MyWrangledData)
  
