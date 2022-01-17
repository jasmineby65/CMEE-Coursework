# This function calculates heights of trees given distance of each tree
# from its base and along to its top, using the trignometric formula

# height = distance * tan(radians)

# ARGUMENTS
# degrees: the angle of elevation of tree
# distance: the distance from base of tree (e.g. meters)

# OUTPUT
# The height of the tree, same units as "distance"

TreeHeight <- function(degrees,distance){
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    #print(paste("Tree height is:", height))
    return(height)
}

TreeData <- read.csv("../data/trees.csv", header=T)
head(TreeData)

data <- TreeHeight(TreeData$Angle.degrees, TreeData$Distance.m)
TreeData$Tree.Height.m = data #Addting height as new column 
head(TreeData)

write.csv(TreeData,"../results/TreeHts.csv") 
print("TreeHts.csv saved in results directory")