### Phenomenological model ###

# 1. Quadratic model #

quad_modelling <- function(subset){
  quad_model <- lm(subset$PopBio ~ poly(subset$Time, 2), data=subset)
  return(quad_model)
}


# 2. Cubic model #

cube_modelling <- function(subset){
  cube_model <- lm(subset$PopBio ~ poly(subset$Time, 3), data=subset)
  return(cube_model)
}



### Mechanistic model ### 

# Estimating r_max #

estimate_r <- function(subset){
  require(rollRegres)
  rolling <- try(roll_regres(PopBio ~ Time, data = subset, width = as.integer(nrow(subset)*0.45)), silent = T)
  
  if(class(rolling) == "try-error" | is.null(rolling)){
    
    lm_growth <- lm(PopBio ~ Time, data = subset)
    r_estimate <- coef(summary(lm_growth))["Time","Estimate"]

    return(r_estimate)  

      } else {
    
  a <- which.max(rolling$coefs[,"Time"])
  r_estimate <- rolling$coefs[a,"Time"]
  return(r_estimate)
  
}}



# 3. Logistic model # 

# The classic logistic equation
logistic_model <- function(t, r_max, K, N_0){ 
  return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}


grid_search_logistic <- function(subset){
  r_estimate <- estimate_r(subset)
  
  if(r_estimate > 1 | r_estimate < 0){
    r_max_start <- runif(100, 0, 0.0005)
  } else {r_max_start <- rnorm(100, r_estimate, r_estimate*2)}
  
  if(min(subset$PopBio)==0){N_0_start <- rep(0, 100)} else {
    N_0_start <- rep(min(subset$PopBio), 100) 
  }
  
  K_start <- rep(max(subset$PopBio), 100) 
  
  combination <- data.frame(r_max_start, N_0_start, K_start)
  names(combination) <- c("r_max", "N_0", "K")

  
  require(minpack.lm) 
  fit_logistic <- function(x){
    try(nlsLM(PopBio ~ logistic_model(t = Time, r_max, K, N_0), subset,
              list(r_max=x[1], N_0 = x[2], K = x[3]), lower = c(0, 0, 0)), silent = T)}
  
  Logistic_models <- apply(combination, 1, fit_logistic)
  
  return(Logistic_models)
}


AIC_calculation <- function(x){
  require(wiqid)
  if(class(x) == "lm" | class(x) == "nls"){
    return(AICc(x))
  } else {
    return(NA)
  }
}


best_logistic <- function(subset){
  
  Logistic_models <- grid_search_logistic(subset)

  Logistic_models$AIC <- lapply(Logistic_models, AIC_calculation)
 
  
  if(length(unique(Logistic_models$AIC))==1){
    best_log = NA
    return(best_log)
    
  } else {  
  best <- which.min(Logistic_models$AIC)
  best_log <- Logistic_models[[best]]

  return(best_log)
}}


  
# 4. Gompertz model #
# Takes lag phase at the beginning of growth into account
# This model is designed specifically to be fitted to log-transformed data

# Modified gompertz growth model (Zwietering 1990)
gompertz_model <- function(t, r_max, K, N_0, t_lag){ 
  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   

grid_search_gompertz <- function(subset){
  r_estimate <- estimate_r(subset)
  
  if(r_estimate > 1 | r_estimate < 0){
    r_max_start <- runif(100, 0, 0.0005)
  } else {r_max_start <- rnorm(100, r_estimate, r_estimate*2)}
  
  if(min(subset$PopBio)==0){N_0_start <- rep(-10, 100)} else {
    N_0_start <- rep(min(subset$LogP), 100) 
  }
  
  K_start <- rep(max(subset$LogP), 100)
  t_estimate <- subset$Time[which.max(diff(diff(subset$LogP)))]
  t_lag_start <- rnorm(100, t_estimate, t_estimate*2)
  
  combination <- data.frame(r_max_start, N_0_start, K_start, t_lag_start)
  names(combination) <- c("r_max", "N_0", "K", "t_lag")
  
  require(minpack.lm) 
  fit_gompertz <- function(x){
    try(nlsLM(LogP ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), subset,
              list(t_lag=x[4], r_max=x[1], N_0 = x[2], K = x[3]), lower = c(0,-Inf,-Inf,0)), silent = T)}
  
  Gompertz_models <- apply(combination, 1, fit_gompertz)
  
  return(Gompertz_models)
}


best_gompertz <- function(subset){
  
  Gompertz_models <- grid_search_gompertz(subset)

  Gompertz_models$AIC <- lapply(Gompertz_models, AIC_calculation)
  
  if(length(unique(Gompertz_models$AIC))==1){
    best_gomp = NA
    return(best_gomp)
  } else {  
    best <- which.min(Gompertz_models$AIC)

    best_gomp <- Gompertz_models[[best]]

    return(best_gomp)}}



# Modelling all four types #
Modelling <- function(subset){
  Models <- list(quad_modelling(subset), cube_modelling(subset), best_logistic(subset), best_gompertz(subset))
  Type <- c("Quadratic", "Cubic", "Logistic", "Gompertz")
  Category <- c("Phenomenological","Phenomenological","Mechanistic", "Mechanistic")
  ID <- rep(unique(subset$ID),4)
  
  df <- data.frame(I(Models), Type, Category, ID)
  
  df$AIC <- lapply(Models, AIC_calculation)
  return(df)
  }


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
  
  model_frame <- rbind(df1, df2)
  
  if(is.na(df$Models[[3]])==F){
    timepoints <- seq(0, max(subset$Time), 1)  
  
    logistic_points <- logistic_model(t = timepoints, 
                                    r_max = summary(df$Models[[3]])$coefficients["r_max.r_max","Estimate"], 
                                    N_0 = summary(df$Models[[3]])$coefficients["N_0.N_0","Estimate"], 
                                    K = summary(df$Models[[3]])$coefficients["K.K","Estimate"])
    df3 <- data.frame(timepoints, log(logistic_points))
    df3$model <- "Logistic equation"
    names(df3) <- c("Time", "LogN", "model")
    head(df3) 
    model_frame <- rbind(model_frame, df3)
    } 
  
  if(is.na(df$Models[[4]])==F){
    timepoints <- seq(0, max(subset$Time), 1)  
    
    gompertz_points <- gompertz_model(t = timepoints, 
                                    r_max = summary(df$Models[[4]])$coefficients["r_max.r_max","Estimate"], 
                                    N_0 = summary(df$Models[[4]])$coefficients["N_0.N_0","Estimate"], 
                                    K = summary(df$Models[[4]])$coefficients["K.K","Estimate"],
                                    t_lag = summary(df$Models[[4]])$coefficients["t_lag.t_lag","Estimate"])
  
    gompertz_points
    df4 <- data.frame(timepoints, gompertz_points)
    df4$model <- "Gompertz model"
    names(df4) <- c("Time", "LogN", "model")
    head(df4)
    model_frame <- rbind(model_frame, df4)}
  
  require(ggplot2)
  model_plot <- ggplot(subset, aes(x = Time, y = LogP)) +
    geom_point(size = 3) +
    geom_line(data = model_frame, aes(x = Time, y = LogN, col = model), size = 1.5) +
    labs(x = "Time", y = "log(Population)") +
    scale_color_brewer(palette="Set2") +
    theme_bw() +
  theme(panel.grid.minor = element_blank()) +
  theme(aspect.ratio=1) +
    ggtitle(paste0(subset$ID))
  
  return(model_plot)
  }
  