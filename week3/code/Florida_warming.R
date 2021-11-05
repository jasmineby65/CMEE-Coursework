# Is Florida getting warmer?
# Needs to calculate the correlation coefficients between temperature and time 
# However, the data point are not independent (measure of the same thing over time)
# So cannot use the standard p-value test for correlation 

# Instead need to use permutation analysis: 
# This analysis re-samples multiple times from the data set to build a sampling distribution 
# The data is shuffled during the re-sampling 
# i.e. data point in observation y can be under observation x in the re-sampling
# If the null hypothesis is correct, 
# then it shouldn't matter which data points end up in which variables in the sample
# so the multiple resampling is essentially producing a sampling distribution for if null hypothesis is TRUE
# p-value = no of times the permutation test statistics (e.g. mean) > the test statistics of observed / no of resampling 
# p-value for permutation test is the probability of getting the observed test statistics 
# or more extreme if the hypothesis is true 


## Loading data
rm(list=ls())
load("../data/KeyWestAnnualMeanTemperature.RData")
# Reload datasets written with the function save
ls()
View(ats)
class(ats)
head(ats)
plot(ats)

# 1. calculate the correlation coefficient between years and temperature and store it
observed_cor <- cor(x=ats$Year, y=ats$Temp, method="pearson")
# cor calculates the correlation coefficient between x and y
# can specify the calculation formula using method= argument
# cor.test() will give a p-value but can't be used on data due to non-independent data point


# 2. repeat this calculation sufficient no of times (10,000 is roughly the standard)
# each time randomly reshuffle the temperatures (randomly re-assign temperature to years) using sample()
set.seed(1234)
n <- length(ats$Year) # no. observations to sample
P <- 10000 # no. of repeat 
permutation <- matrix(0, nrow=n, ncol=P) # pre-allocating a matrix to hold resampling outcome

for (i in 1:P){ # resampling 10000 times from Temp 
  permutation[,i] <- sample(x=ats$Temp, size=n, replace=F)
  } 
permutation[1:10,1:10]

permutation <- cbind(permutation, ats$Year) # adding a column of years
str(permutation)
permutation[1:10, 9995:10001]

perm_stat <- rep(0, P) # pre-allocating a vector to hold resampling correlation coefficient 
for (i in 1:P){ # calculating correlation coefficient for each permutation 
  perm_stat[i] <- cor(y=permutation[,i], x=permutation[,P+1],method="pearson")
}
perm_stat[1:20]

# 3. calculate what fraction of the random correlation coefficients were greater than the observed one 
# i.e. the approximate, asymptotic p-value 
greater_perm <- sum((perm_stat[1:P] >= observed_cor), na.rm =T)
greater_perm

p_value <- greater_perm/P
p_value
# can also use mean() which use T=1, F=0 to calculate the mean value of all elements in vector
# p_value <- mean(perm_stat[1:P] >= observed_cor)

## Making plot ##
require(ggplot2)
plot <- as.data.frame(perm_stat)
head(plot)
p <- ggplot(plot, aes(x=perm_stat),  xlab="Permutated correlation coefficient") + 
  geom_histogram() + geom_vline(aes(xintercept = observed_cor, col=I("red")))
p

jpeg("../results/Florida.jpeg")
p
dev.off()

# 4. present the results and interpretation in a pdf documents 
# include the source code of this pdf in the submission 