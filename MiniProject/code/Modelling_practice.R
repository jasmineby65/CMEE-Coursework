data <- read.csv("../data/Data.csv", stringsAsFactors = F) 

# Subset single experiments
subset <- subset(data, ID == "1")
subset["LogP"] <- log(subset$PopBio)
head(subset)

plot(subset$Time, subset$PopBio)
plot(subset$Time, subset$LogP)

### Phenomenological model ###

# 1. Quadratic model #
quad_modelling <- function(subset){
  quad_model <- lm(subset$PopBio ~ poly(subset$Time, 2), data=subset)
  return(quad_model)
}
quad_modelling(subset)


time <- data.frame(subset$Time)
df1 <- data.frame(time, log(predict(quad_model, time)))
df1$model <- "Quadratic model"
names(df1) <- c("Time", "LogN", "model")
head(df1)

quad_model <- lm(subset$PopBio ~ poly(subset$Time, 2), data=subset)
quad <- summary(quad_model)

time <- data.frame(subset$Time)
log(predict(quad_model, time))

df3 <- data.frame(time, log(predict(quad_model, time)))
df3$model <- "Quadratic model"
names(df3) <- c("Time", "LogN", "model")
head(df3)
model_frame <- rbind(model_frame, df3)

# poly() by default makes a orthogonal polynomial, meaning it assumes each order of x is not correlated
# and shows the p-value for the significance of each term (i.e. needed in model or not)
# poly(raw=T) will make it non-orthogonal, so each orders of x are correlated
# so the p-value will now show how much each term are contributing within the model 
# But raw is not often used due to problem with collinearity 

# 2. Cubic model #
cube_modelling <- function(subset){
  cube_model <- lm(subset$PopBio ~ poly(subset$Time, 3), data=subset)
  return(cube_model)
}
cube_modelling(subset)

cube_model <- lm(subset$PopBio ~ poly(subset$Time, 3), data=subset)
summary(cube_model)

df2 <- data.frame(time, log(predict(cube_model, time)))
df2$model <- "Cubic model"
names(df2) <- c("Time", "LogN", "model")
head(df2)
model_frame <- rbind(model_frame, df4)

ggplot(subset, aes(x = Time, y = PopBio)) +
  geom_point(size = 3) +
  stat_smooth(method="lm", formula = y~poly(x, 2), size = 1, se=F) +
  stat_smooth(method="lm", formula = y~poly(x, 3), size = 1, col="red", se=F)+
  theme(aspect.ratio=1)


# Estimating initial parameters from data
N_0_start <- min(subset$PopBio) # lowest population size
K_start <- max(subset$PopBio) # highest population size
r_max_start <- rolling$coefs[a,"Time"] # use our estimate from the OLS fitting from above

fit_logistic <- nlsLM(PopBio ~ logistic_model(t = Time, r_max, K, N_0), subset,
                      list(r_max=r_max_start, N_0 = N_0_start, K = K_start), lower = c(0, 0, 0))

sum <- summary(fit_logistic)
sum
sum$coefficients

# Modelling using OLS (ordinary least-squares) #
# Fitting a linear model through the linear part of the log-transformed data
estimate_r <- function(subset){
  require(rollRegres)
  rolling <- roll_regres(PopBio ~ Time, data = subset, width = as.integer(nrow(subset)*0.45)) 
  a <- which.max(rolling$coefs[,"Time"])
  r_estimate <- rolling$coefs[a,"Time"]
  return(r_estimate)
}

estimate_r(subset)

lm_growth <- lm(PopBio ~ Time, data = subset[subset$Time >= 0 & subset$Time <= 20,])
summary(lm_growth)
coef(summary(lm_growth))["Time","Estimate"]
max(subset$Time)
# Could iterate through different windows of points and compare which model gives the maximum growth rate
# An approach known as "rolling regression"
require(rollRegres)
rolling <- roll_regres(PopBio ~ Time, data = subset, width = 6) # width specifies the number of x variable to include in a window
rolling$coefs
nrow(rolling$coefs) # 14 equations made for 14 data points but the first 5 empty because it didn't have enough value to fill window

a <- which.max(rolling$coefs[,"Time"])
r_estimate <- rolling$coefs[a,"Time"]
r_estimate

# Modelling using NLLS #
require(minpack.lm) 
# Logistic model # 
logistic_model <- function(t, r_max, K, N_0){ # The classic logistic equation
  return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}

# Use try function and randomly select multiple starting point from specified distribution 
# grid search approach 
grid_search_logistic <- function(subset){
  r_estimate <- estimate_r(subset)
  
  r_max_start <- rnorm(100, r_estimate, r_estimate*2)
  N_0_start <- rnorm(100, min(subset$PopBio), min(subset$PopBio)*0.5) 
  K_start <- rnorm(100, max(subset$PopBio), min(subset$PopBio)*0.5) 
  
  combination <- data.frame(r_max_start, N_0_start, K_start)
  names(combination) <- c("r_max", "N_0", "K")
  head(combination)
  
  fit_logistic <- function(x){
    try(nlsLM(PopBio ~ logistic_model(t = Time, r_max, K, N_0), subset,
              list(r_max=x[1], N_0 = x[2], K = x[3]), lower = c(0, 0, 0)), silent = T)}
  
  Logistic_models <- apply(combination, 1, fit_logistic)
  
  return(Logistic_models)
}
Logistic_models <- grid_search_logistic(subset)


best_logistic <- function(subset){
  
  Logistic_models <- grid_search_logistic(subset)
  
  Logistic_models
  
  AIC_calculation <- function(x){
    try(AIC(x), silent = T)
  }
  
  Logistic_models$AIC <- lapply(Logistic_models, AIC_calculation)
  head(Logistic_models$AIC)
  best <- which.min(Logistic_models$AIC)
  return(Logistic_models[[best]])
}

best_logistic(subset)


combination$AIC = apply(combination, 1, find_AIC)
best <- which.min(combination$AIC)
return(combination$model[[best]])

r_max_start <- rnorm(100, r_estimate, r_estimate*2)
N_0_start <- rnorm(100, min(subset$PopBio), min(subset$PopBio)*0.5) 
K_start <- rnorm(100, max(subset$PopBio), min(subset$PopBio)*0.5) 

combination <- data.frame(r_max_start, N_0_start, K_start)
names(combination) <- c("r_max", "N_0", "K")
head(combination)


fit_logistic_AIC <- function(x){
  try(AIC(nlsLM(PopBio ~ logistic_model(t = Time, r_max, K, N_0), subset,
                list(r_max=x[1], N_0 = x[2], K = x[3]), lower = c(0, 0, 0))), silent = T)}

fit_logistic <- function(x){
  try(nlsLM(PopBio ~ logistic_model(t = Time, r_max, K, N_0), subset,
            list(r_max=x[1], N_0 = x[2], K = x[3]), lower = c(0, 0, 0)), silent = T)}


best_logistic <- function(combination){
  
}


combination$Summary = apply(combination, 1, fit_logistic_summary)
combination$AIC = apply(combination, 1, fit_logistic_AIC)
head(combination)

best <- which.min(combination$AIC)
best
combination$Summary[[65]]
combination$AIC
summary(combination$Summary[[best]])$coefficients["r_max.r_max","Estimate"]
summary(combination$Summary[[best]])$coefficients["N_0.N_0","Estimate"]
summary(combination$Summary[[best]])$coefficients["K.K","Estimate"]

# Plotting
timepoints <- seq(0, max(subset$Time), 1)

logistic_points <- logistic_model(t = timepoints, 
                                  r_max = summary(combination$Summary[[best]])$coefficients["r_max.r_max","Estimate"], 
                                  N_0 = summary(combination$Summary[[best]])$coefficients["N_0.N_0","Estimate"], 
                                  K = summary(combination$Summary[[best]])$coefficients["K.K","Estimate"])
df1 <- data.frame(timepoints, logistic_points)
df1$model <- "Logistic equation"
names(df1) <- c("Time", "N", "model")
head(df1)

ggplot(subset, aes(x = Time, y = PopBio)) +
  geom_point(size = 3) +
  geom_line(data = df1, aes(x = Time, y = N, col="pink"), size = 1) +
  stat_smooth(method="lm", formula = y~poly(x, 2), size = 1, se=F) +
  stat_smooth(method="lm", formula = y~poly(x, 3), size = 1, col="red", se=F)+
  theme(aspect.ratio=1) + 
  labs(x = "Time", y = "Cell number") +
  theme(legend.position = "none") 


# Gompertz model #
# Takes lag phase at the beginning of growth into account
# This model is designed specifically to be fitted to log-transformed data

gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   

min(subset$LogP)

150*0.2
r_max_start <- rnorm(100, r_estimate, r_estimate*2)
N_0_start <- rnorm(100, min(subset$LogP), abs(min(subset$LogP)*0.5)) 
K_start <- rnorm(100, max(subset$LogP), abs(min(subset$LogP)*0.5))
t_lag_start <- runif(100, 0, max(subset$Time)*0.2)
t_lag_start
combination1 <- data.frame(r_max_start, N_0_start, K_start, t_lag_start)
names(combination1) <- c("r_max", "N_0", "K", "t_lag")
head(combination1)

# find the time point with the highest difference between population size (end of lag phase)

fit_gompertz <- function(x){
  try(nlsLM(LogP ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), subset,
            list(t_lag=x[4], r_max=x[1], N_0 = x[2], K = x[3])), silent = T)}

fit_gompertz_AIC <- function(x){
  try(AIC(nlsLM(LogP ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), subset,
                list(t_lag=x[4], r_max=x[1], N_0 = x[2], K = x[3]))), silent = T)}

combination1$Summary = apply(combination1, 1, fit_gompertz)
combination1$AIC = apply(combination1, 1, fit_gompertz_AIC)
best2 <- which.min(combination1$AIC)
best2
summary(combination1$Summary[[best2]])

# Plotting the two models together
timepoints <- seq(0, 24, 0.1)


gompertz_points <- gompertz_model(t = timepoints, 
                                  r_max = summary(combination1$Summary[[best2]])$coefficients["r_max.r_max","Estimate"], 
                                  N_0 = summary(combination1$Summary[[best2]])$coefficients["N_0.N_0","Estimate"], 
                                  K = summary(combination1$Summary[[best2]])$coefficients["K.K","Estimate"],
                                  t_lag = summary(combination1$Summary[[best2]])$coefficients["t_lag.t_lag","Estimate"])

df1 <- data.frame(timepoints, log(logistic_points))
df1$model <- "Logistic model"
names(df1) <- c("Time", "LogN", "model")

df2 <- data.frame(timepoints, gompertz_points)
df2$model <- "Gompertz model"
names(df2) <- c("Time", "LogN", "model")
head(df2)
model_frame <- rbind(df1, df2)

df3 <- data.frame(timepoints, quad_points)
df3$model <- "Quadratic model"
names(df3) <- c("Time", "LogN", "model")
head(df3)
model_frame <- rbind(df1, df2)

require(wesanderson)
ggplot(subset, aes(x = Time, y = LogP)) +
  geom_point(size = 5) +
  geom_line(data = model_frame, aes(x = Time, y = LogN, col = model), size = 1.5) +
  labs(x = "Time", y = "log(Population)") +
  scale_color_brewer(palette="Set2") +
  theme_bw() +
  theme(legend.position = "none",
        panel.grid.minor = element_blank()) 
theme(aspect.ratio=1)

# Gompertz model fits much better

# Checking with AIC
logistic_fit <- AIC(fit_logistic)
gompertz_fit <- AIC(fit_gompertz)

logistic_fit - gompertz_fit
# logistic AIC higher than gompertz AIC by >2 so gompertz is better 