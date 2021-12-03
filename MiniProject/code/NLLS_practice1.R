#### Non-linear least-square models 1 ###

## Biochemical Kinetics - the Michaelis-Menten model ##
# Models the change in enzyme reaction rate depending on substrate concentration 

# Making the data #
# Generating sequence of substrate concentration 
S_data <- seq(1,50,5) # sequence of 1-50 but skipping 5 -> 10 no.
S_data

# Making the model reacion velocity response for each concentration
V_data <- ((12.5*S_data)/(7.1+S_data))
plot(S_data, V_data)

# Adding normally distributed fluctuations to the data as error
set.seed(1456)
V_data <- V_data + rnorm(10,0,1)
plot(S_data, V_data)

# Fitting the model using NLLS #
# V_max and K_M is the parameters in this model 
MM_model <- nls(V_data ~ V_max * S_data/(K_M + S_data))
# Didn't specify starting values of the parameter so default of 1 is used

graphics.off()
plot(S_data, V_data, xlab = "Substrate Concentration", ylab = "Reaction Rate")
lines(S_data, predict(MM_model), lty = 1, col = "blue", lwd =2) # predict() plots the predicted value from model

summary(MM_model)
anova(MM_model) # anova can't be performed on NLLS models 

# Calculating confidence interval of the parameters 
confint(MM_model)

# Trying different starting values #
MM_model2 <- nls(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = 12, K_M = 7))

# Comparing coefficients
coef(MM_model)
coef(MM_model2) # Exactly the same as model1

MM_model3 <- nls(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = .01, K_M = 20))
coef(MM_model)
coef(MM_model2) 
coef(MM_model3) # Completely different results from the above

plot(S_data,V_data)  
lines(S_data,predict(MM_model),lty=1,col="blue",lwd=2)
lines(S_data,predict(MM_model3),lty=1,col="red",lwd=2) # Parameter completely wrong!

nls(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = 0, K_M = 0.1))
# Gives error because the starting value was so far off the parameter searching failed in the first step
nls(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = -0.1, K_M = 100))
# Also fails but after few steps

MM_model4 <- nls(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = 12.96, K_M = 10.61))
coef(MM_model)
coef(MM_model4) # Starting from values simialr to optimal gave slightly different parameter ut the difference is small enough to ignore

# The Levenberg-Marquardt algorith can be used instead of the default Gauss-Newton algorithm
# It uses a combination of two methods: gradietn descent method when far from optimal and Gauss_Newton when close
require("minpack.lm") 

# Same starting value as model 2
MM_model5 <- nlsLM(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = 2, K_M = 2))
coef(MM_model2)
coef(MM_model5) # very similar

# Trying starting values that failed before
MM_model6 <- nlsLM(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = .01, K_M = 20))
MM_model7 <- nlsLM(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = 0, K_M = 0.1))
MM_model8 <- nlsLM(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = -0.1, K_M = 100))
coef(MM_model6)
coef(MM_model7)
coef(MM_model8) # All have similar results!

nlsLM(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = -10, K_M = -100))
# It will also fail though if the starting value is too far out

# Bounding the parameter values #
# Parameters can be set to be within certain values

# without bounding
nlsLM(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = 0.1, K_M = 0.1))
# with bounding
nlsLM(V_data ~ V_max * S_data / (K_M + S_data), start = list(V_max = 0.1, K_M = 0.1), lower=c(0.4,0.4), upper=c(100,100))
# Bounding reduced the number of iterations needed since it had less numbers to explore 

nlsLM(V_data ~ V_max * S_data / (K_M + S_data), start =  list(V_max = 0.5, K_M = 0.5), lower=c(0.4,0.4), upper=c(20,20))
# Setting the boundary too narrow will lead to poor results since there is insufficient parameter combination exploration 


# nlstools packages #
require("nlstools")

# Allows a preview of the plot using specified starting values to help choose the starting values
equation <- V_data ~ V_max * S_data / (K_M + S_data)
data <- data.frame(S_data, V_data) # Use the first variable as the independent variable 
data
preview(formula=equation, data=data,  start = list(V_max = 12, K_M = 7)) # Black is observed data, red is fitted model

# Extensive version of summary()
overview(MM_model) 

# Assumption diagnostics
diagnose <- nlsResiduals(MM_model)
plot(diagnose) # gives the same diagnose plots as linear model
test.nlsResiduals(diagnose) # Does the Shapiro-Wilk test for nomality and run test for independence of data points

