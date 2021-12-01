#### Non-linear least-square models 2 ###

## Allometric scaling of traits ##
# Models the allometric relationship between body length and body weight 

MyData <- read.csv("../data/GenomeSize.csv") 
head(MyData)
str(MyData)

Data2Fit <- subset(MyData, Suborder == "Anisoptera") # Subsetting the data 
Data2Fit <- Data2Fit[!is.na(Data2Fit$TotalLength),] # Removing NAs
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight, xlab="Body length", ylab="Body weight") 
# Shows exponential increase in weight with length

# Fitting the model
require("minpack.lm") 
nrow(Data2Fit)
PowFit <- nlsLM(BodyWeight ~ a*TotalLength^b, data=Data2Fit, start = list(a=.1, b=.1))
summary(PowFit)
confint(PowFit)

# Alternative way of fitting the model using nlsLM:
# Make a function of the power law model
powMod <- function(x,a,b){
  return(a*x^b)}
# Fit the model to the data using NLLS
PowFit <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b), data=Data2Fit, start=list(a=.1, b=.1))
summary(PowFit)

# Visualising the model fit #
# Creating vector of x-axis variable (body lengths) for plotting
Lengths <- seq(min(Data2Fit$TotalLength),max(Data2Fit$TotalLength),len=200)
parameter1 <- coef(PowFit)["a"] # first parameter
parameter2 <- coef(PowFit)["b"] # second parameter
Predict2PlotPow <- powMod(Lengths, parameter1, parameter2) # Making a model for plotting

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predict2PlotPow, col = "blue", lwd = 2.5)

# Examining the residuals 
hist(residuals(PowFit))
require(nlstools)
check <- nlsResiduals(PowFit)
plot(check)
test.nlsResiduals(check)
