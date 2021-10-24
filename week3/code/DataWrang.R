################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE, stringsAsFactors=F))
# header = false because the raw data don't have real headers
# Make sure header= is within the read.csv()! Not the matrix()

MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")
# header = true because we do have metadata headers

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)
fix(MyData) #you can also do this
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)
fix(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) 
#stringsAsFactors = F is important!
#[-1,] REMOVES the first row (column names) from the newly converted data.frame 
# This is needed because the column names at this point is still recognised as 
# normal data point rather than headers
head(TempData)
colnames(TempData) <- MyData[1,] # assign column names from original data
head(TempData)

############# Convert from wide to long format  ###############
require(reshape2) # load the reshape2 package
# require() does the same thing as library() but is designed to be used in functions
# if package is not found, will output a warning but continues the function
# library() will just return an error and terminate the function  

?melt 
# Stacks set of columns (measured variables) in wide data format 
# using specified ID variables  

MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")
# Stacks all individual species columns as two columns named `"species" and "count"
# stacking based on "Cultivation", "Block", "Plot", and "Quadrat"
head(MyWrangledData)

# Converting variable type of each columns 
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData) # now there is only 6 columns 

############# Exploring the data (extend the script below)  ###############
