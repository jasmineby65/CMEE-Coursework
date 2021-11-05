rm(list=ls())
require(ggplot2)
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF$Prey.mass[which(MyDF$Prey.mass.unit == "mg")] <- MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")]/1000

## Scatter plots ## 
p <- ggplot(MyDF, aes(x = log(Predator.mass),
                      y = log(Prey.mass),
                      colour = Type.of.feeding.interaction))
p # plot empty because no geometry was specified 

p + geom_point()

q <- p + 
  geom_point(size=I(2), shape=I(10)) +
  theme_bw() + # make the background white
  theme(aspect.ratio=1) # make the plot square
q
q + theme(legend.position = "none") # removing legend


## Density plot ##
p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass), 
                      fill = Type.of.feeding.interaction )) + 
  geom_density(alpha=0.5)
p

p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass), 
                      fill = Type.of.feeding.interaction )) +  
  geom_density() + 
  facet_wrap( .~ Type.of.feeding.interaction)
p # All the faces have the same axis at the moment

p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass), 
                      fill = Type.of.feeding.interaction )) +  
  geom_density() + 
  facet_wrap( .~ Type.of.feeding.interaction, scales="free") +
  theme(legend.position = "none")
p # scales= allows each subplots to have optimum axis length  
# "free_x" will just free the x axis 

p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass))) +  
  geom_density() + facet_wrap( .~ Location, scales = "free")
p

p <- ggplot(MyDF, aes(x = log(Prey.mass), 
                      y=log(Predator.mass))) +  
  geom_point() + facet_wrap( .~ Location, scales = "free")
p

p <- ggplot(MyDF, aes(x = log(Prey.mass), 
                      y=log(Predator.mass))) +  
  geom_point() + facet_wrap( .~ Location + Type.of.feeding.interaction, 
                             scales = "free")
p # Facets can be seperated by  multiple variables 
# The order to be arranged is dependant on the order of argument entered 
# In this case, Location is prioritised

p <- ggplot(MyDF, aes(x = log(Prey.mass), 
                      y=log(Predator.mass))) +  
  geom_point() + facet_wrap( .~ Type.of.feeding.interaction + Location , 
                             scales = "free")
p


## Plotting matrix ##
# ggplot2 only accept dataframe as the input 
# need to use reshape2 to melt a matrix to a dataframe

require(reshape2)
Generatematrix <- function(N){
  M <- matrix(runif(N*N), N, N) # generate N*N random number
  return(M)
} 

M <- Generatematrix(10)
Melt <- melt(M) # melt() converts the matrix to a longformat dataframe
# where var1 is the row, var2 is the column, and value are the values of matrix
class(Melt)

p <- ggplot(Melt, aes(Var1, Var2, fill = value)) + 
  geom_tile() + theme(aspect.ratio = 1)
p
p + geom_tile(colour = "black") # add black lines 
p + geom_tile(colour = "black") + theme(legend.position = "none")

# Removing every labels
p + theme(legend.position = "none",
          panel.background = element_blank(),
          axis.ticks = element_blank(), # the teeth of axis 
          panel.grid.major = element_blank(), # The main grid within plot (not visible on tile anyway)
          panel.grid.minor = element_blank(), # The minor grid within plot (not visible on tile anyway)
          axis.text.x = element_blank(), # The x-axis unit labels
          axis.title.x = element_blank(), # The x-axis name
          axis.text.y = element_blank(), 
          axis.title.y = element_blank()) 

# Exploring colours
p + scale_fill_continuous(low="yellow", high="darkgreen")
# scale_fill_continuous() is the default 

require(scales)
p + scale_fill_gradient2() 
# scale_fill_gradient() create a two colour gradient (low-high)
# scale_fill_gradient2() create a diverging gradient (low-mid-high)
p + scale_fill_gradientn(colours=grey.colors(10))
# Scale_fill_gradientn() create a n-colour gradient 
p + scale_fill_gradientn(colours=rainbow(10))
p + scale_fill_gradientn(colours=c("red","white","blue"))
           

## Plotting two dataframes ##
# Plotting Girko's circular law: 
# The eigenvalues (distance to anypoint of matrix) of a matrix of size NxN
# are approximately contained in a circle with radius sqrt(N)

# function that returns an ellipse
build_ellipse <- function(hradius, vradius){ 
  npoints = 250
  a <- seq(0, 2 * pi, length = npoints + 1) # seq of 251 of value 0 to 2*pi
  x <- hradius * cos(a)
  y <- vradius * sin(a)  
  return(data.frame(x = x, y = y))
}

N <- 250 
M <- matrix(rnorm(N*N), N, N)
eigvals <- eigen(M)$values # find eigenvalues
eigDF <- data.frame("Real"=Re(eigvals), "Imaginary"=Im(eigvals))
head(eigDF)
# Building a dataframe of real and imaginary values of eiganvalues

my_radius <- sqrt(N) 
ellDF <- build_ellipse(my_radius, my_radius) # dataframe of ellipse
names(ellDF) <- c("Real", "Imaginary")
head(ellDF)

# Plotting #
# Scatter plots of eigenvalues 
p <- ggplot(eigDF, aes(x = Real, y = Imaginary))
p <- p +
  geom_point(shape = I(3)) +
  theme(legend.position = "none")
p

# adding the vertical and horizontal line
p <- p + geom_hline(aes(yintercept = 0))
p <- p + geom_vline(aes(xintercept = 0))

# finally, add the ellipse
p <- p + geom_polygon(data = ellDF, aes(x = Real, 
                                        y = Imaginary, 
                                        alpha = 1/20, fill = "red"))
# geom_polygon makes a filled shape defined by the outline path
# just giving x and y in aes gives a ellipse
p


## Annotating plots ##
a <- read.table("../data/Results.txt", header=T)
head(a)
str(a)

a$ymin <- rep(0, dim(a)[1]) # append a column of zeros

# Print the first linerange
dev.off()
p <- ggplot(a)
p <- p + geom_linerange(data = a, aes( # plots a specified length of bar (size=0.5 makes it a bar instead of line)
  x = x,
  ymin = ymin,
  ymax = y1,
  size = (0.5)
),
colour = "#E69F00",
alpha = 1/2, show.legend = FALSE)
p

# Print the second linerange
p <- p + geom_linerange(data = a, aes(
  x = x,
  ymin = ymin,
  ymax = y2,
  size = (0.5)
),
colour = "#56B4E9",
alpha = 1/2, show.legend = FALSE)

# Print the third linerange:
p <- p + geom_linerange(data = a, aes(
  x = x,
  ymin = ymin,
  ymax = y3,
  size = (0.5)
),
colour = "#D55E00",
alpha = 1/2, show.legend = FALSE)


# Annotate the plot with labels:
p <- p + geom_text(data = a, 
                   aes(x = x, y = -500, label = Label))
# labels the 6 bars with "Label"
p

# now set the axis labels, remove the legend, 
# and prepare for bw printing
p <- p + scale_x_continuous("My x axis",
                            breaks = seq(3, 5, by = 0.05)) + 
  scale_y_continuous("My y axis") + 
  theme_bw() + 
  theme(legend.position = "none") 
p


## Mathematical display ##
x <- seq(0, 100, by = 0.1)
y <- -4. + 0.25 * x +
  rnorm(length(x), mean = 0., sd = 2.5)

# and put them in a dataframe
my_data <- data.frame(x = x, y = y)

# perform a linear regression
my_lm <- summary(lm(y ~ x, data = my_data))
my_lm

# plot the data
dev.off()
p <-  ggplot(my_data, aes(x = x, y = y,
                          colour = abs(my_lm$residual))
) +
  geom_point() +
  scale_colour_gradient(low = "black", high = "red") +
  theme(legend.position = "none") +
  scale_x_continuous(
    expression(alpha^2 * pi / beta * sqrt(Theta)))
# scale_x_continuous() edits the x axis
# expression() is used for formatting text and print what's inside as symbols 

# add the regression line
p <- p + geom_abline( #abline makes a diagnol line, hline makes horizontal, vline makes vertical 
  intercept = my_lm$coefficients[1][1],
  slope = my_lm$coefficients[2][1],
  colour = "red")

# throw some math on the plot
p <- p + geom_text(aes(x = 60, y = 0,
                       label = "sqrt(alpha) * 2* pi"), 
                   parse = T, size = 6, 
                   colour = "blue")
# parse will format the text inside labels as symbols  
p


## ggthemes ##
library(ggthemes) # this provides aditional geoms, scales, and themes

dev.off()
p <- ggplot(MyDF, aes(x = log(Predator.mass), y = log(Prey.mass),
                      colour = Type.of.feeding.interaction )) +
  geom_point(size=I(2), shape=I(10)) + theme_bw()
p

dev.off()
p + geom_rangeframe() + # now fine tune the geom to Tufte's range frame (i.e. extends the axis to the max and min values of the data point)
  theme_tufte() # and theme to Tufte's minimal ink theme    

