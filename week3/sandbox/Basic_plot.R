rm(list=ls())

## Loading data ##
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(MyDF)
str(MyDF)
head(MyDF)

require(tidyverse)
dplyr::glimpse(MyDF)

# setting some columns to factor to use as grouping variables
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)
str(MyDF)


## Scatter Plots ##
plot(MyDF$Predator.mass, MyDF$Prey.mass) #plot(x,y)
# A right skewed data (e.g. most animals are in a range of small size but there are few species that are very large)
# Can be log-transformed, if this results in a normal-distribution shape,
# Then the original data is said to have a log-normal distribution 

# Taking logs to inspect the body size in a meaningful scale 
plot(log(MyDF$Predator.mass), log(MyDF$Prey.mass))
plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass)) 
# Using log10 is useful because makes it easier to understand the actual values in the original scale
# i.e. all the points are now 10 to the power of the shown value  

plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass), pch=20) 
# Change the plot symbol (Plot CHaracter)
plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass), 
     pch=20, ylab="Prey Mass (g)", xlab="Predator Mass (g)") 


## Histograms ## 
hist(MyDF$Predator.mass) # Shows data distribution (log-normal in this case)

hist(log10(MyDF$Predator.mass), 
     xlab="log10(Predator Mass (g))", ylab="Count")

hist(log10(MyDF$Predator.mass), 
     xlab="log10(Predator Mass (g))", ylab="Count",
     col="lightblue", border="pink")

hist(log10(MyDF$Prey.mass), 
     xlab="log10(Prey Mass (g))", ylab="Count",
     col="pink", border="lightblue")

dev.off() # Close current plotting window
# Could keep plotting on top of the previous graph if not closed 

## Subplots ##
# Plotting two graphs together as sub-plots for easier comparison

par(mfcol=c(2,1)) # initialise multi-panelled layout
# par() is graphic PARameter
# mfcol stands for multi-frame column-wise layout (2 rows, 1 column)

par(mfg=c(1,1)) # specify which sub-plot to add a plot

hist(log10(MyDF$Predator.mass), 
     xlab="log10(Predator Mass (g))", ylab="Count",
     col="lightblue", border="pink", main="Predator")

par(mfg=c(2,1)) # second sub-plot
hist(log10(MyDF$Prey.mass), 
     xlab="log10(Prey Mass (g))", ylab="Count",
     col="pink", border="lightblue", main="Prey")

dev.off()


## Overlaying plots ##
# plots can also be overlapped for comparison

hist(log10(MyDF$Predator.mass), breaks=10, # specify the no. of bins
     xlab="log10(Body Mass (g))", ylab="Count",
     xlim=c(-12, 6),
     col=rgb(1,0,0,0.5), # specify the value of red, green, blue, alpha (transparency)
     main="Predator-prey size Overlap")
hist(log10(MyDF$Prey.mass), breaks=10,
     col=rgb(0,0,1,0.5), add=T) # add=T plots the second in the same window

legend("topleft", c("Predators", "Prey"),
       fill=c(rgb(1,0,0,0.5), rgb(0,0,1,0.5))) # Adds legend

dev.off()


## Boxplots ##
# Useful for summarising the distribution of data

boxplot(log10(MyDF$Predator.mass), 
        xlab="Location", ylab="Log10(Predator Mass)",
        main="Predator mass")

boxplot(log(MyDF$Predator.mass) ~ MyDF$Location, # y~x
        xlab="Location", ylab ="Predator Mass",
        main = "Predator mass by location")

boxplot(log(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction,
        xlab="Location", ylab = "Predator Mass",
        main = "Predator mass by feeding interaction type")

dev.off()

## Combining plot types ##
# Different plot types can be shown in one figure 

par(fig=c(0,0.8,0,0.8))
# fig=c(x1,x2,y1,y2) specify the coordinates of the figure region in the displayed figure
# starting and end point of x axis and starting and end point of y axis
# basically specify the figure size as proportions

plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass), 
     pch=20, ylab="Prey Mass (g)", xlab="Predator Mass (g)") 

par(fig=c(0,0.8,0.4,1), new=T)
# y-axis overlapped with the first plot
# new = T adds the plot to the existing figure

boxplot(log10(MyDF$Predator.mass), 
        horizontal = T, # Make the plot horizontal
        axes =F) # No axis shown for this plot

par(fig=c(0.55,1,0,0.8), new=T)
boxplot(log10(MyDF$Prey.mass), 
        horizontal = F, # Make the plot horizontal
        axes =F) 

mtext("Fancy Predator-prey scatterfplot", side=3, outer=T, line=-3)
# Writes text to the margins of a plot 
# side= specify which side of plot: 1=bottom, 2=left, 3=top, 4=right
# outer=T uses outer margins if available 
# line = specify the distance from margin

dev.off()

## Saving graphics ##
pdf("../results/Pred_Prey_Overlay.pdf", #opens a blank pdf
    11.7, 8.3) # page dimensions in inches (x,y)

# plotting (this won't be shown in the plot panel)
hist(log10(MyDF$Predator.mass), breaks=10, # specify the no. of bins
     xlab="log10(Body Mass (g))", ylab="Count",
     xlim=c(-12, 6),
     col=rgb(1,0,0,0.5), # specify the value of red, green, blue, alpha (transparency)
     main="Predator-prey size Overlap")
hist(log10(MyDF$Prey.mass), breaks=10,
     col=rgb(0,0,1,0.5), add=T) # add=T plots the second in the same window
legend("topleft", c("Predators", "Prey"),
       fill=c(rgb(1,0,0,0.5), rgb(0,0,1,0.5))) # Adds legend

dev.off()

graphics.off() # same as dev.off()
