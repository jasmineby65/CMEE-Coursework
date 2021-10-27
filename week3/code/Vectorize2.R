# Runs the stochastic Ricker equation with gaussian (normal) fluctuations
# stochamistic model have a component that fluctuate randomly with time 

rm(list = ls())

set.seed(1234)
stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
  N <- matrix(data=NA, nrow=numyears, ncol=length(p0))  #initialize empty matrix

  N[1, ] <- p0

  for (pop in 1:length(p0)) { #loop through the populations

    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma)) 
      # add one fluctuation from normal distribution with mean 0 and SD of sigma (0.2)
      # this adds the stochastic part of the equation 
    
     }
  
  }
 #write.csv(N, file="../results/no_vectorisation.csv", row.names=FALSE, col.names=FALSE)
 return(N)

}

stochrick()

# Now write another function called stochrickvect that vectorizes the above to
# the extent possible, with improved performance: 

set.seed(1234)
stochrickvect <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
  N1 <- matrix(data=NA, nrow=numyears, ncol=length(p0))  #initialize empty matrix
  
  N1[1, ] <- p0
  
  for (i in 2:numyears) {
  N1[i,] <- N1[i-1,] * exp(r * (1 - N1[i - 1] / K) + rnorm(1, 0, sigma)) 
  }
  # Each row (i) is considered as a vector in the for loop
  # R can apply the same calculation to each elements within a vector by "vector + calculation"
  # This is much faster than the first method tried below 
  
  
  # Alternative methods using apply but this is SLOW because its still going through all the columns individually 
  # ricker <- function(v) {
  #  for (yr in 2:numyears){ 
  #    v[yr] <- v[yr-1] * exp(r * (1 - v[yr - 1] / K) + rnorm(1, 0, sigma))}
  #  return(v) }
  # N1 <- apply(N1, 2, ricker)

  return(N1)
}

stochrickvect()

print("Non-vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrick()))
print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))
