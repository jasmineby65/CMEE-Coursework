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



# 2. Cubic model #

cube_modelling <- function(subset){
  cube_model <- lm(subset$PopBio ~ poly(subset$Time, 3), data=subset)
  return(cube_model)
}

cube_modelling(subset)



### Mechanistic model ### 

# Estimating r_max

estimate_r <- function(subset){
  require(rollRegres)
  rolling <- roll_regres(PopBio ~ Time, data = subset, width = as.integer(nrow(subset)*0.45)) 
  a <- which.max(rolling$coefs[,"Time"])
  r_estimate <- rolling$coefs[a,"Time"]
  return(r_estimate)
}

estimate_r(subset)


# 3. Logistic model # 

# The classic logistic equation
logistic_model <- function(t, r_max, K, N_0){ 
  return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}


grid_search_logistic <- function(subset){
  r_estimate <- estimate_r(subset)
  
  r_max_start <- rnorm(100, r_estimate, r_estimate*2)
  N_0_start <- rnorm(100, min(subset$PopBio), min(subset$PopBio)*0.5) 
  K_start <- rnorm(100, max(subset$PopBio), min(subset$PopBio)*0.5) 
  
  combination <- data.frame(r_max_start, N_0_start, K_start)
  names(combination) <- c("r_max", "N_0", "K")
  head(combination)
  
  require(minpack.lm) 
  fit_logistic <- function(x){
    try(nlsLM(PopBio ~ logistic_model(t = Time, r_max, K, N_0), subset,
              list(r_max=x[1], N_0 = x[2], K = x[3]), lower = c(0, 0, 0)), silent = T)}
  
  Logistic_models <- apply(combination, 1, fit_logistic)
  
  return(Logistic_models)
}

Logistic_models <- grid_search_logistic(subset)

AIC_calculation <- function(x){
  require(wiqid)
  try(AICc(x), silent = T)
}


best_logistic <- function(subset){
  
  Logistic_models <- grid_search_logistic(subset)
  
  Logistic_models$AIC <- lapply(Logistic_models, AIC_calculation)
  best <- which.min(Logistic_models$AIC)
  
  return(Logistic_models[[best]])
}

best_log <- best_logistic(subset)


# 4. Gompertz model #
# Takes lag phase at the beginning of growth into account
# This model is designed specifically to be fitted to log-transformed data

gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   

grid_search_gompertz <- function(subset){
  r_estimate <- estimate_r(subset)
  
  r_max_start <- rnorm(100, r_estimate, r_estimate*2)
  N_0_start <- rnorm(100, min(subset$LogP), abs(min(subset$LogP)*0.5)) 
  K_start <- rnorm(100, max(subset$LogP), abs(min(subset$LogP)*0.5))
  t_lag_start <- runif(100, 0, max(subset$Time)*0.1)
  
  combination <- data.frame(r_max_start, N_0_start, K_start, t_lag_start)
  names(combination) <- c("r_max", "N_0", "K", "t_lag")
  head(combination)
  
  require(minpack.lm) 
  fit_gompertz <- function(x){
    try(nlsLM(LogP ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), subset,
              list(t_lag=x[4], r_max=x[1], N_0 = x[2], K = x[3])), silent = T)}
  
  Gompertz_models <- apply(combination, 1, fit_gompertz)
  
  return(Gompertz_models)
}

best_gompertz <- function(subset){
  
  Gompertz_models <- grid_search_gompertz(subset)
  
  Gompertz_models$AIC <- lapply(Gompertz_models, AIC_calculation)
  best <- which.min(Gompertz_models$AIC)
  
  return(Gompertz_models[[best]])
}

AICc(best_gompertz(subset))

best_gom <- best_gompertz(subset)


# Modelling all four types #
Modelling <- function(subset){
  Models <- list(quad_modelling(subset), cube_modelling(subset), best_logistic(subset), best_gompertz(subset))
  Type <- c("Quadratic", "Cubic", "Logistic", "Gompertz")
  Category <- c("Phenomenological","Phenomenological","Mechanistic", "Mechanistic")
  
  df <- data.frame(I(Models), Type, Category)
  df$AIC <- lapply(Models, AIC_calculation)
  return(df)
  }

df <- Modelling(subset)

# Plotting #

plotting <- function(subset, df){
  
  time <- data.frame(subset$Time)
  
  df1 <- data.frame(time, log(predict(df$Models[[1]], time)))
  df1$model <- "Quadratic model"
  names(df1) <- c("Time", "LogN", "model")
  head(df1)
  
  df2 <- data.frame(time, log(predict(df$Models[[2]], time)))
  df2$model <- "Cubic model"
  names(df2) <- c("Time", "LogN", "model")
  head(df2)
  
  timepoints <- seq(0, max(subset$Time), 1)
  
  logistic_points <- logistic_model(t = timepoints, 
                                    r_max = summary(df$Models[[3]])$coefficients["r_max.r_max","Estimate"], 
                                    N_0 = summary(df$Models[[3]])$coefficients["N_0.N_0","Estimate"], 
                                    K = summary(df$Models[[3]])$coefficients["K.K","Estimate"])
  df3 <- data.frame(timepoints, log(logistic_points))
  df3$model <- "Logistic equation"
  names(df3) <- c("Time", "LogN", "model")
  head(df3)
  
  gompertz_points <- gompertz_model(t = timepoints, 
                                    r_max = summary(df$Models[[4]])$coefficients["r_max.r_max","Estimate"], 
                                    N_0 = summary(df$Models[[4]])$coefficients["N_0.N_0","Estimate"], 
                                    K = summary(df$Models[[4]])$coefficients["K.K","Estimate"],
                                    t_lag = summary(df$Models[[4]])$coefficients["t_lag.t_lag","Estimate"])
  
  df4 <- data.frame(timepoints, gompertz_points)
  df4$model <- "Gompertz model"
  names(df4) <- c("Time", "LogN", "model")
  head(df4)
  
  model_frame <- rbind(df1, df2, df3, df4)
  
  require(ggplot2)
  model_plot <- ggplot(subset, aes(x = Time, y = LogP)) +
    geom_point(size = 5) +
    geom_line(data = model_frame, aes(x = Time, y = LogN, col = model), size = 1.5) +
    labs(x = "Time", y = "log(Population)") +
    scale_color_brewer(palette="Set2") +
    theme_bw() 
  theme(legend.position = "none",
        panel.grid.minor = element_blank()) 
  theme(aspect.ratio=1)
  
  return(model_plot)
}

plotting(subset, df)


