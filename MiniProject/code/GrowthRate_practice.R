#### Population growth rates ####

# A population grows exponentially while its abundance is low and resources are not limiting (the Malthusian principle). 
# This growth then slows and eventually stops as resources become limiting. 
# There may also be a time lag before the population growth really takes off at the start. 

# We will focus on microbial (specifically, bacterial) growth rates. 
# Bacterial growth in batch culture follows a distinct set of phases; lag phase, exponential phase and stationary phase. 
# During the lag phase a suite of transcriptional machinery is activated, including genes involved in nutrient uptake and 
# metabolic changes, as bacteria prepare for growth. During the exponential growth phase, bacteria divide at a constant rate, 
# the population doubling with each generation. When the carrying capacity of the media is reached, growth slows and the number 
# of cells in the culture stabilizes, beginning the stationary phase.

# Traditionally, microbial growth rates were measured by plotting cell numbers or culture density against time on a semi-log graph 
# and fitting a straight line through the exponential growth phase – the slope of the line gives the maximum growth rate (r_max)
# Models have since been developed which we can use to describe the whole sigmoidal bacterial growth curve 


# Making data
t <- seq(0, 22, 2)
N <- c(32500, 33000, 38000, 105000, 445000, 1430000, 3020000, 4720000, 5670000, 5870000, 5930000, 5940000)
set.seed(1234) 
data <- data.frame(t, N * (1 + rnorm(length(t), sd = 0.1))) # add some random error
names(data) <- c("Time", "N")
head(data)

require(ggplot2)
ggplot(data, aes(x = Time, y = N)) + 
  geom_point(size = 3) +
  labs(x = "Time (Hours)", y = "Population size (cells)")


# Modelling basic growth rate (the rate at the exponential phase) #
data$LogN <- log(data$N)

ggplot(data, aes(x = t, y = LogN)) + 
  geom_point(size = 3) +
  labs(x = "Time (Hours)", y = "log(cell number)")

# Seems linear between hour 5-10 so calculate growth rate there 
(data[data$Time == 10,]$LogN - data[data$Time == 6,]$LogN)/(10-6) # Using 6 because there's no hour 5 data point

# Or can pick the maximum observed gradient of the curve
diff(data$LogN) # gives the difference between each time point
max(diff(data$LogN)/2) # Finding the highest rate among all time point

# However, to account to the error in measurement, 
# should be fitting a model through the points rather than using the data points directly


# Modelling using OLS (ordinary least-squares) #
# Fitting a linear model through the linear part of the log-transformed data
lm_growth <- lm(LogN ~ Time, data = data[data$Time > 2 & data$Time < 12,])
summary(lm_growth)

# Could iterate through different windows of points and compare which model gives teh maximum growth rate
# An approach known as "rolling regression"


# Modelling using NLLS #
require("minpack.lm") 
# Logistic model # 
logistic_model <- function(t, r_max, K, N_0){ # The classic logistic equation
  return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}

# Estimating initial parameters from data
N_0_start <- min(data$N) # lowest population size
K_start <- max(data$N) # highest population size
r_max_start <- 0.62 # use our estimate from the OLS fitting from above

fit_logistic <- nlsLM(N ~ logistic_model(t = Time, r_max, K, N_0), data,
                      list(r_max=r_max_start, N_0 = N_0_start, K = K_start))

summary(fit_logistic)

# Plotting
timepoints <- seq(0, 22, 0.1)

logistic_points <- logistic_model(t = timepoints, 
                                  r_max = coef(fit_logistic)["r_max"], 
                                  K = coef(fit_logistic)["K"], 
                                  N_0 = coef(fit_logistic)["N_0"])
df1 <- data.frame(timepoints, logistic_points)
df1$model <- "Logistic equation"
names(df1) <- c("Time", "N", "model")
head(df1)

ggplot(data, aes(x = Time, y = N)) +
  geom_point(size = 3) +
  geom_line(data = df1, aes(x = Time, y = N, col = model), size = 1) +
  theme(aspect.ratio=1)+ # make the plot square 
  labs(x = "Time", y = "Cell number")

# Plotting with log-transformed axis
ggplot(data, aes(x = Time, y = LogN)) +
  geom_point(size = 3) +
  geom_line(data = df1, aes(x = Time, y = log(N), col = model), size = 1) +
  theme(aspect.ratio=1)+ 
  labs(x = "Time", y = "log(Cell number)") # This reveals the model actually diverge from data at the lower end! Why?

# Examining the data
ggplot(data, aes(x = N, y = LogN)) +
  geom_point(size = 3) +
  theme(aspect.ratio = 1)+ 
  labs(x = "N", y = "log(N)") 
# This shows that log will transform disproportionately, with larger transformation to value close to zero
# So any deviation of the model at the lower end will be shown to be very large when log-transformed

# Gompertz model #
# Takes lag phase at the beginning of growth into account
# This model is designed specifically to be fitterd to log-transformed data

gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   

N_0_start <- min(data$LogN) # lowest population size, note log scale
K_start <- max(data$LogN) # highest population size, note log scale
r_max_start <- 0.62 # use our previous estimate from the OLS fitting from above
t_lag_start <- data$Time[which.max(diff(diff(data$LogN)))] 
# find the time point with the highest difference between population size (end of lag phase)

fit_gompertz <- nlsLM(LogN ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), data,
                      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start))
summary(fit_gompertz)

# Plotting the two models together
timepoints <- seq(0, 24, 0.1)

logistic_points <- log(logistic_model(t = timepoints, 
                                      r_max = coef(fit_logistic)["r_max"], 
                                      K = coef(fit_logistic)["K"], 
                                      N_0 = coef(fit_logistic)["N_0"]))

gompertz_points <- gompertz_model(t = timepoints, 
                                  r_max = coef(fit_gompertz)["r_max"], 
                                  K = coef(fit_gompertz)["K"], 
                                  N_0 = coef(fit_gompertz)["N_0"], 
                                  t_lag = coef(fit_gompertz)["t_lag"])

df1 <- data.frame(timepoints, logistic_points)
df1$model <- "Logistic model"
names(df1) <- c("Time", "LogN", "model")

df2 <- data.frame(timepoints, gompertz_points)
df2$model <- "Gompertz model"
names(df2) <- c("Time", "LogN", "model")

model_frame <- rbind(df1, df2)

ggplot(data, aes(x = Time, y = LogN)) +
  geom_point(size = 3) +
  geom_line(data = model_frame, aes(x = Time, y = LogN, col = model), size = 1) +
  theme_bw() + # make the background white
  theme(aspect.ratio=1)+ # make the plot square 
  labs(x = "Time", y = "log(Abundance)") 

# Gompertz model fits much better

# Checking with AIC
logistic_fit <- AIC(fit_logistic)
gompertz_fit <- AIC(fit_gompertz)

logistic_fit - gompertz_fit
# logistic AIC higher than gompertz AIC by >2 so gompertz is better 