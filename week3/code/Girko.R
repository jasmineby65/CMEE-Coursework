## Plotting two dataframes ##
# Plotting Girko's circular law: 
# The eigenvalues (distance to anypoint of matrix) of a matrix of size NxN
# are approximately contained in a circle with radius sqrt(N)
require(ggplot2)
rm(list=ls())


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

pdf("../results/Girko.pdf")
p
dev.off()