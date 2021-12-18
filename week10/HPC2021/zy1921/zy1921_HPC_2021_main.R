# CMEE 2021 HPC excercises R code main pro forma

name <- "Zhengxin Yang"
preferred_name <- "Jasmine"
email <- "zy1921@imperial.ac.uk"
username <- "zy1921"


# Question 1
species_richness <- function(community){
  return(length(unique(community)))
}


# Question 2
init_community_max <- function(size){
  return(seq(1:size))
}


# Question 3
init_community_min <- function(size){
  return(rep(1,size))
}


# Question 4
choose_two <- function(max_value){
  return(sample(1:max_value, 2, replace = F))
}


# Question 5
neutral_step <- function(community){
  choice <- choose_two(length(community))
  community[choice[1]] <- community[choice[2]]
  return(community)
}
# This is simulating a "birth/death event" 
# One individual of a community die and is replaced by another reproducing 


# Question 6
neutral_generation <- function(community){
  gen <- length(community)/2
  up_down <- sample(1:2, 1)
  if(up_down == 1) { gen <- ceiling(gen)} else { gen <- floor(gen) }
  
  og_community <- community
  for(i in 1:gen){
    og_community <- neutral_step(og_community)
  }
  return(og_community)
}
# In this model that has constant population size over time, an individual can only reproduce on average once in their life
# Generation time is the time between birth and reproduction, so the generation time for an individual is halfway through its life
# This means that there will likely be an overlap between two generations at one time 
# Because there are overlaps between parents and child, some individuals may be reproducing (child) while some are dying (parents)
# Therefore, any individual in a population has 1/2 chance of reproducing or dying at a given time
# So the generation time for the whole community is community/2, which is the equivalent of half of population having reproduced and died 


# Question 7
neutral_time_series <- function(community,duration)  {
  richness <- c(species_richness(community))
  
  og_community <- community
  for(i in 1:duration){
    og_community <- neutral_generation(og_community)
    richness <- c(richness, species_richness(og_community))
  }
  return(richness)
}


# Question 8
question_8 <- function(community = init_community_max(100), duration = 200) {
  results <- neutral_time_series(community, duration)
  
  data <- data.frame(0:duration, results)
  colnames(data) <- c("duration", "results")
  
  while (!is.null(dev.list()))  dev.off()
  require(ggplot2)
  plot <- ggplot(data=data, aes(x=duration, y=results)) + 
    geom_line(colour="red") + 
    xlab("Generations") + ylab("Species richness") +
    theme_bw() + theme(panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(),
                       panel.border = element_blank(),
                       axis.line = element_line(size = 0.3, colour = "black"))
  print(plot)
  return(paste("The species richness will always converge to 1.",
         "This is because there is no speciation or migration event in this model.",
         "The random replacement of individuals through birth and death events removes species from the community,",
         "eventually leading to the community being dominated by a single species."))
}


# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  if(runif(1, min = 0, max = 1) <= speciation_rate) {
    choice <- choose_two(length(community))
    community[choice[1]] <- max(community) + 1
  }
  else {community <- neutral_step(community)}
  
  return(community)
}


# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  gen <- length(community)/2
  up_down <- sample(1:2, 1)
  if(up_down == 1) { gen <- ceiling(gen)} else { gen <- floor(gen) }
  
  og_community <- community
  for(i in 1:gen){
    og_community <- neutral_step_speciation(og_community, speciation_rate)
  }
  return(og_community)
}


# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  richness <- c(species_richness(community))
  
  og_community <- community
  for(i in 1:duration){
    og_community <- neutral_generation_speciation(og_community, speciation_rate)
    richness <- c(richness, species_richness(og_community))
  }
  return(richness)
}


# Question 12
question_12 <- function(size = 100, duration = 200, speciation_rate = 0.1)  {
  result1 <- neutral_time_series_speciation(init_community_max(size), speciation_rate, duration)
  result2 <- neutral_time_series_speciation(init_community_min(size), speciation_rate, duration)
  results <- c(result1, result2)
  type <- c(rep("Maximum", length(result1)), rep("Minimum", length(result1)))
  time <- c(rep(0:duration, 2))

  data <- data.frame(time, results, type)
  colnames(data) <- c("duration", "results", "Initial_diversity")
  
  while (!is.null(dev.list()))  dev.off()
  require(ggplot2)
  plot <- ggplot(data=data, aes(x=duration, y=results, col=Initial_diversity)) + 
    geom_line() + 
    xlab("Generations") + ylab("Species richness") +
    theme_bw() + theme(panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(),
                       legend.position = c(.95, .95),
                       legend.justification = c("right", "top"),
                       panel.border = element_blank(),
                       axis.line = element_line(size = 0.3, colour = "black")) +
    labs(colour  = "Initial diversity")
  print(plot)
  
  return(paste("The communities' species richness converged around 25 regardless of their initial diveristy.",
               "This is due to communities reaching the dynamic equilibrium, where the rate of extinction balances the rate of speciation so the total diversity of the community remain constant.",
               "At high initial diversity, extinction through replacement of individuals by birth and death event quickly reduced the diversity.",
               "However, species richness never fell below the equilibrium due to the introduction of new species through speciation, which balances out the extinction events.",
               "At low initial diversity (mono-species), speciation event introduced new species to the community and rapidly increased the richness.",
               "However, further increases above the equilibrium was suppressed by extinction through replacement of individuals."))
}


# Question 13
species_abundance <- function(community)  {
  species <- sort(table(community), decreasing = T)
  species <- data.frame(species)
  
  if(nrow(species) == 1){return(species$species)} else {return(species$Freq)}
}


# Question 14
octaves <- function(abundance_vector) {
  count <- tabulate(abundance_vector)
  octave <- c(count[1])
  
  max <- log(max(abundance_vector), base = 2)
  
  if(max %% 1 == 0){
    limit <- max+1
  } else {limit <- ceiling(max)}
  
  if(limit <= 2){
    octave <- c(octave, sum(count[(2^(2-1)):((2^2)-1)], na.rm = T))
  } else {
  for(i in 2:limit){
    octave <- c(octave, sum(count[(2^(i-1)):((2^i)-1)], na.rm = T))
  }}
  
  return(octave)
}


# Question 15
sum_vect <- function(x, y) {
  if(length(x) > length(y)){
    extra <- length(x)-length(y)
    y <- c(y, rep(0, extra))
    sum <- x + y 
  } else if(length(y) > length(x)){
    extra <- length(y)-length(x)
    x <- c(x, rep(0, extra))
    sum <- x + y 
  } else {sum <- x + y}
  return(sum)
}


# Question 16 
question_16 <- function(size = 100, burn_in = 200, duration = 2000, interval = 20, speciation_rate = 0.1)  {
  # First 200 simulation
  max_div <- init_community_max(size)
  min_div <- init_community_min(size)
  
  for(i in 1:burn_in){
  max_div <- neutral_generation_speciation(max_div, speciation_rate)
  min_div <- neutral_generation_speciation(min_div, speciation_rate)
  }
  
  octaves1 <- octaves(species_abundance(max_div))
  octaves2 <- octaves(species_abundance(min_div))

  result1 <- list(octaves1)
  result2 <- list(octaves2)

  # 2000 simulations
  for(i in 1:(duration/interval)){
    for(j in 1:interval){
      max_div <- neutral_generation_speciation(max_div, speciation_rate)
      min_div <- neutral_generation_speciation(min_div, speciation_rate)
    }
    octaves1 <- octaves(species_abundance(max_div))
    octaves2 <- octaves(species_abundance(min_div))
    
    result1 <- append(result1, list(octaves1))
    result2 <- append(result2, list(octaves2))
  }
  
  # Mean of octaves
  total1 <- sum_vect(result1[[1]], result1[[2]])
  total2 <- sum_vect(result2[[1]], result2[[2]])
  
  for(i in 3:(length(result1))){
    total1 <- sum_vect(total1, result1[[i]])
  }
  for(i in 3:(length(result2))){
    total2 <- sum_vect(total2, result2[[i]])
  }

  final1 <- total1/(length(result1))
  final2 <- total2/(length(result2))
  
  # Making dataframe for plotting
  max_bin <- max(c(length(final1), length(final2)))
  bin <- c("1")
  
  for(i in 2:max_bin){
    bin <- c(bin, paste0(2^(i-1), "-", (2^i)-1))
  }
  
  result <- c(final1, final2)
  type <- c(rep("Maximum", length(final1)), rep("Minimum", length(final2)))
  data <- data.frame(result, type, bin)
  colnames(data) <- c("Frequency", "Initial_diversity", "Abundances")

  while (!is.null(dev.list()))  dev.off()
  require(ggplot2)
  plot <- ggplot(data=data, aes(x=Abundances, y=Frequency, fill=Initial_diversity)) +
    geom_bar(stat="identity", position = "dodge") +
    xlab("Number of individuals per species") + ylab("Frequency") +
    theme_bw() + theme(panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(),
                       legend.position = c(.95, .95),
                       legend.justification = c("right", "top"),
                       panel.border = element_blank(),
                       axis.line = element_line(size = 0.3, colour = "black")) + 
    scale_x_discrete(limits=bin) +
    labs(fill  = "Initial diversity")
  print(plot)
  
  return(paste("The final frequencies of the number of individuals per species were very simialr between communities with maximum- and minimum-initial diverisities.",
               "This is because both communities had the same speciation and extinction (death/birth event) rate so will eventually converge to the same dynamic equilibrium for reasons mentioned in question_12().",
               "At long enough generations, the number of individuals per species will also reach an equilibrium."))
}


# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
    start_time <- proc.time()[[3]]
    community <- init_community_min(size)
    richness <- c()
    abundance <- list()
    
    i <- 1
    tm <- proc.time()[[3]]
    while (proc.time()[[3]] - tm < (wall_time*60)) {
      community <- neutral_generation_speciation(community, speciation_rate)
      stop <- i 
      
      if((i %% interval_rich == 0) & (i <= burn_in_generations)) {
        richness <- c(richness, species_richness(community))
      }
      
      if(i %% interval_oct == 0){
        abundance <- append(abundance, list(octaves(species_abundance(community))))
      }
      
      i <- i + 1
    }
    
    state <- if(stop > burn_in_generations){paste("")} else {paste("not ")}
    final_state <- paste0("The community has ", state, "reached dynamic equilibrium.")
    parameters <- c(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations)
    final_time <- (proc.time()[[3]] - start_time)
    
    save(richness, abundance, final_state, final_time, parameters, file = output_file_name)
    
    return("Output file made!")
}


# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 

process_cluster_results <- function()  {
  no_500 <- 0
  no_1000 <- 0
  no_2500 <- 0
  no_5000 <- 0
  
  total_500 <- c()
  total_1000 <- c()
  total_2500 <- c()
  total_5000 <- c()
  
  for(i in 1:100){
    load(file = paste0("Test_result", i, ".rda"))
    
    if(i <= 25){popu_size = 500} else if
    (i <= 50){popu_size = 1000} else if
    (i <= 75){popu_size = 2500} else if
    (i <= 100){popu_size = 5000}

    burn_in = (8*popu_size)/(popu_size/10)

    total <- c()
    for(j in burn_in:length(abundance)){
      total <- sum_vect(total, abundance[[j]])
    }
    
    assign(paste0("no_", popu_size), (get(paste0("no_", popu_size)) + (length(abundance) - burn_in + 1)))
    assign(paste0("total_", popu_size), sum_vect(get(paste0("total_", popu_size)), total))
  }
  
  mean_500 <- total_500/no_500
  mean_1000 <- total_1000/no_1000
  mean_2500 <- total_2500/no_2500
  mean_5000 <- total_5000/no_5000
  combined_results <- list(mean_500, mean_1000, mean_2500, mean_5000) #create your list output here to return
  
  save(combined_results, file = "Combined_results.rda")
  # save results to an .rda file
  return("Finished!")
}


plot_cluster_results <- function()  {
  load(file = "Combined_results.rda")  # load combined_results from your rda file
  
  max_bin <- max(length(combined_results[[1]]), length(combined_results[[2]]), length(combined_results[[3]]), length(combined_results[[4]]))
  bin <- c("1")
  for(i in 2:max_bin){
    bin <- c(bin, paste0(2^(i-1), "-", (2^i)-1))
  }
  
  Frequency <- c(combined_results[[1]], rep(0, max_bin-length(combined_results[[1]])), combined_results[[2]], rep(0, max_bin-length(combined_results[[2]])),
            combined_results[[3]], rep(0, max_bin-length(combined_results[[3]])), combined_results[[4]], rep(0, max_bin-length(combined_results[[4]])))
  size <- c(rep("Population size = 500", max_bin), rep("Population size = 1000", max_bin), rep("Population size = 2500", max_bin), rep("Population size = 5000", max_bin))
  
  Data <- data.frame(Frequency, size, bin)
  Data$size_f <- factor(Data$size, levels = c("Population size = 500", "Population size = 1000", "Population size = 2500", "Population size = 5000"))
  while (!is.null(dev.list()))  dev.off()  # clear any existing graphs and plot your graph within the R window
  require(ggplot2) # plot the graphs
  
  plot <- ggplot(data=Data, aes(x=bin, y=Frequency, fill=size)) +
    geom_bar(stat = "identity") + 
    facet_wrap( ~ size_f, ncol=2) +
    xlab("Number of individuals per species") + ylab("Frequency") +
    theme_bw() + theme(panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(),
                       panel.border = element_blank(),
                       axis.line = element_line(size = 0.3, colour = "black"),
                       legend.position = "none") + 
    scale_x_discrete(limits=bin)
    print(plot)

  return(combined_results)
}


# Question 21
question_21 <- function(object = 21) {
  dimension <- log10(8)/log10(3)
  answer <- c(paste("The width of the object triples with a 8-fold increase in its size.",
  "This gives an fractal dimension of x where 3^x = 8.", 
  "Therefore, x = log(8)/log(3)."))
  
  answer_21 <- list(dimension, answer)
  return(answer_21)
}


# Question 22
question_22 <- function(object = 22)  {
  dimension <- log10(20)/log10(3)
  answer <- c(paste("The width of the object triples with a 20-fold increase in its size.",
                    "This gives an fractal dimension of x where 3^x = 20.", 
                    "Therefore, x = log(20)/log(3)."))
  
  answer_22 <- list(dimension, answer)
  return(answer_22)
}


# Question 23
chaos_game <- function(object = "CHAOS!")  {
  A <- c(0,0)
  B <- c(3,4)
  C <- c(4,1)
  direction <- list(A,B,C)
  
  point <- c(0,0)
  X <- list(point)

  choose_list <- c()
  for(i in 1:5000){
    choose <- sample(1:3, 1)
    choose_list <- c(choose_list, choose)
    new_x <- point[1] - ((point[1] - direction[[choose]][1])/2)
    new_y <- point[2] - ((point[2] - direction[[choose]][2])/2)
    point <- c(new_x, new_y)
    X <- append(X, list(point))
  }

  x_value <- sapply(X, function(y) y[1])
  y_value <- sapply(X, function(y) y[2])
  data <- data.frame(x_value, y_value)
  
  while (!is.null(dev.list()))  dev.off()
  require(ggplot2)
  plot <- ggplot(data=data, aes(x=x_value, y=y_value)) + 
    geom_point(size = 0.1) + ylab("y") + xlab("x") + theme_bw() +
    theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank()) 

  print(plot)  
  return(paste("The plot shows a triangular fractal with its 3 nodes corresponding to coordinates specified by A, B and C.",  
               "The repeated patterns of triangular shape within the fractal has the same proportion as the whole fractal"))
  }


# Question 24
turtle <- function(start_position, direction, length)  {
   x <- start_position[1] + length*cos(direction)
   y <- start_position[2] + length*sin(direction)
   segments(x0 = start_position[1], y0 = start_position[2], x1 = x, y1 = y)
   endpoint <- c(x,y)
  return(endpoint) # you should return your endpoint here.
}


# Question 25
elbow <- function(start_position, direction, length)  {
  first <- turtle(start_position, direction, length)
  turtle(first, direction - pi/4, length*0.95)
}


# Question 26
spiral <- function(start_position, direction, length)  {
  if(length >= 0.01){
  first <- turtle(start_position, direction, length)
  spiral(first, direction - pi/4, length*0.95)}
  else { answer <- paste("The function plots a spiral but returns an error message: C stack usage 7970756 is too close to the limit.",
                        "This is because spiral() is a recursive function, which iterate the function continuously by repeatedly calling itself.",
                        "This will eventually overload the memory, producing the observed error.")
  return(answer)}
}


# Question 27
draw_spiral <- function()  {
  while (!is.null(dev.list()))  dev.off()  # clear any existing graphs and plot your graph within the R window
  plot(1, type="n", xlab="", ylab="", xlim=c(-2, 5), ylim=c(-2,5), asp=1)
  answer <- spiral(c(0,0), pi/2, 2)
  return(answer)
}


# Question 28
tree <- function(start_position, direction, length)  {
  if(length >= 0.5){
    first <- turtle(start_position, direction, length)
    tree(first, direction - pi/4, length*0.65)
    tree(first, direction + pi/4, length*0.65)}
  else {return()}
}

draw_tree <- function(start_position = c(0,0), direction = pi/2, length = 20)  {
  while (!is.null(dev.list()))  dev.off()  # clear any existing graphs and plot your graph within the R window
  plot(1, type="n", xlab="", ylab="", xlim=c(-30, 30), ylim=c(0,60), main = "A Beautiful Tree", asp=1)
  tree(start_position, direction, length)
  return("A flat tree made!")
}


# Question 29
fern <- function(start_position, direction, length)  {
  if(length >= 0.1){
    first <- turtle(start_position, direction, length)
    fern(first, direction + pi/4, length*0.38)
    fern(first, direction, length*0.87)}
  else {return()}
}

draw_fern <- function(start_position = c(0,0), direction = pi/2, length = 10)  {
  while (!is.null(dev.list()))  dev.off()  # clear any existing graphs and plot your graph within the R window
  plot(1, type="n", xlab="", ylab="", xlim=c(-25, 5), ylim=c(0,80), main = "A Beautiful Fern", asp=1)
  fern(start_position, direction, length)
  return("A fern made!")
}


# Question 30
fern2 <- function(start_position, direction, length, dir)  {
  if(length >= 0.1){
    first <- turtle(start_position, direction, length)
    fern2(first, direction + (dir*pi/4), length*0.38, dir - 2*dir)
    fern2(first, direction, length*0.87, dir - 2*dir)}
  else {return()}
}

draw_fern2 <- function(start_position = c(0,0), direction = pi/2, length = 10, dir = 1)  {
  while (!is.null(dev.list()))  dev.off()  # clear any existing graphs and plot your graph within the R window
  plot(1, type="n", xlab="", ylab="", xlim=c(-20, 20), ylim=c(0,80), main = "A Even More Beautiful Fern", asp = 1)
  fern2(start_position, direction, length, dir)
  return("A fern made!")
}


# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Upper_confidence <- function(data){
  m <- mean(data)
  n <- length(data)
  SE <- sd(data)/sqrt(n)
  
  interval <- 1 - (((100 - 97.2)/2)*0.01)
  error <- qt(interval, df = n-1)*SE
  
  return(m+error)
}

Lower_confidence <- function(data){
  m <- mean(data)
  n <- length(data)
  SE <- sd(data)/sqrt(n)
  
  interval <- 1 - (((100 - 97.2)/2)*0.01)
  error <- qt(interval, df = n-1)*SE
  
  return(m-error)
}

Challenge_A <- function(size = 100, duration = 200, speciation_rate = 0.1) {
 
  ########################################################################### 
    ### Making rda file containing richness from 100 simulations ###
  ###########################################################################
  
  # simulation_max <- list()
  # simulation_min <- list()
  # 
  # for(i in 1:100){
  #   max_div <- init_community_max(size)
  #   min_div <- init_community_min(size)
  # 
  #   richness1 <- species_richness(max_div)
  #   richness2 <- species_richness(min_div)
  # 
  #   # 2000 simulations
  #   for(i in 1:duration){
  #     max_div <- neutral_generation_speciation(max_div, speciation_rate)
  #     min_div <- neutral_generation_speciation(min_div, speciation_rate)
  # 
  #     richness1 <- c(richness1, species_richness(max_div))
  #     richness2 <- c(richness2, species_richness(min_div))
  #   }
  # 
  #   simulation_max <- append(simulation_max, list(richness1))
  #   simulation_min <- append(simulation_min, list(richness2))
  # }
  # 
  # save(simulation_max, file = "Challenge_A_max.rda")
  # save(simulation_min, file = "Challenge_A_min.rda")

  load(file = "Challenge_A_max.rda")
  load(file = "Challenge_A_min.rda")

  for(i in 1:length(simulation_max[[1]])){
    assign(paste0("time_", i, "_max"), c())
    assign(paste0("time_", i, "_min"), c())
  }

  for(i in 1:length(simulation_max)){
    for(j in 1:length(simulation_max[[1]])){
      assign(paste0("time_", j, "_max"), c(get(paste0("time_", j, "_max")), simulation_max[[i]][j]))
      assign(paste0("time_", j, "_min"), c(get(paste0("time_", j, "_min")), simulation_min[[i]][j]))
    }
  }


  mean_max <- c(mean(time_1_max), mean(time_2_max))
  CI_up_max <- c(Upper_confidence(time_1_max), Upper_confidence(time_2_max))
  CI_low_max <- c(Lower_confidence(time_1_max), Lower_confidence(time_2_max))

  mean_min <- c(mean(time_1_min), mean(time_2_min))
  CI_up_min <- c(Upper_confidence(time_1_min), Upper_confidence(time_2_min))
  CI_low_min <- c(Lower_confidence(time_1_min), Lower_confidence(time_2_min))

  for(i in 3:length(simulation_max[[1]])){
    mean_max <- c(mean_max, mean(get(paste0("time_", i, "_max"))))
    CI_up_max <- c(CI_up_max, Upper_confidence(get(paste0("time_", i, "_max"))))
    CI_low_max <- c(CI_low_max, Lower_confidence(get(paste0("time_", i, "_max"))))

    mean_min <- c(mean_min, mean(get(paste0("time_", i, "_min"))))
    CI_up_min <- c(CI_up_min, Upper_confidence(get(paste0("time_", i, "_min"))))
    CI_low_min <- c(CI_low_min, Lower_confidence(get(paste0("time_", i, "_min"))))
    }

  Generation <- rep(0:200,2)
  Popu <- c(rep("Maximum", length(mean_max)), rep("Minimum", length(mean_min)))
  length(Popu)
  Mean <- c(mean_max, mean_min)
  CI_upper <- c(CI_up_max, CI_up_min)
  CI_lower <- c(CI_low_max, CI_low_min)
  CI_lower
  Data <- data.frame(Popu, Mean, CI_upper, CI_lower, Generation)  
  
  while (!is.null(dev.list()))  dev.off()   # clear any existing graphs and plot your graph within the R window
  require(ggplot2)
  plot <- ggplot(data = Data, aes(x=Generation, y=Mean, colour = Popu, fill = Popu)) +
    geom_line() +
    geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper), alpha = 0.3, colour= NA) +
    labs(colour  = "Initial diversity", fill = "Initial diversity") +
    theme_bw() + theme(panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(),
                     legend.position = c(.95, .95),
                     legend.justification = c("right", "top"),
                     panel.border = element_blank(),
                     axis.line = element_line(size = 0.3, colour = "black")) +
    ylab("Species richness") + ggtitle("Mean \u00B1 97.2% CI of species richness from 100 simulations") +
    geom_vline(aes(xintercept = 40), colour = "red") +
    annotate("text", x = 110, y = 70, label = "Dynamic equilibrium reached in roughly 40 generations")
  print(plot)
  
  return("Plot made!")
}


# Challenge question B
Challenge_B <- function(max_diversity = 100, interval = 10, speciation_rate = 0.1, gen = 100, simulation = 100) {
  
  diversity <- c(seq(from=0, to = max_diversity, by= interval))

  ########################################################################################################## 
       ### Making rda file containing richness from 100 simulations of different initial diversity ###
  ##########################################################################################################
  
  # for(i in diversity){
  #   if (i == 0){
  #     community <- rep(1, max_diversity)
  #   } else {
  #   replace <- sample(2:(max_diversity), i-1, replace = F)
  #   community <-  rep(1, max_diversity)
  #   }
  #   
  #   for(j in replace){
  #     community[j] <- j
  #   }
  #   assign(paste0("initial_",i), community)
  # }
  # 
  # for(i in diversity){
  #   result <- list()
  # 
  #   for(j in 1:simulation){
  #     community <- get((paste0("initial_", i)))
  #     richness <- species_richness(community)
  # 
  #     for(k in 1:gen){
  #       community <- neutral_generation_speciation(community, speciation_rate)
  #       richness <- c(richness, species_richness(community))
  #     }
  # 
  #     result <- append(result, list(richness))
  #   }
  #   save(result, file = paste0("Challenge_B_", i, ".rda"))
  # }
  
  for(i in diversity){
    load(file=paste0("Challenge_B_", i, ".rda"))
    
    for(j in 1:length(result[[1]])){
      assign(paste0("time_", j), c())
    }
    
    for(k in 1:length(result)){
      for(l in 1:length(result[[1]])){
        assign(paste0("time_", l), c(get(paste0("time_", l)), result[[k]][l]))
      }
    }
    
    mean <- c(mean(time_1), mean(time_2))
    for(m in 3:length(result[[1]])){
      mean <- c(mean, mean(get(paste0("time_", m))))
    }
    
    assign(paste0("series_", i), mean)
  }
  
  Diversity <- c()
  mean <- c()
  for(i in diversity){
    a <- get(paste0("series_", i))
    Diversity <- c(Diversity, rep(a[1], length(a)))
    mean <- c(mean, a)
  }
  Generation <- 0:gen
  Data <- data.frame(Diversity, mean, Generation)

  while (!is.null(dev.list()))  dev.off()   # clear any existing graphs and plot your graph within the R window
  require(ggplot2)
  plot <- ggplot(data = Data, aes(x=Generation, y=mean, colour = factor(Diversity))) +
    geom_line() +
    labs(colour  = "Initial diversity") +
    theme_bw() + theme(panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank(),
                       legend.position = c(.95, .95),
                       legend.justification = c("right", "top"),
                       panel.border = element_blank(),
                       axis.line = element_line(size = 0.3, colour = "black")) +
    ylab("Species richness") + ggtitle("Mean of species richness from 100 simulations") 
  print(plot)
  
  return("Plot made!")
}


# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question E
chaos <- function(A, B, C, initial, number, change){
  direction <- list(A,B,C)
  
  point <- initial
  X <- list(point)
  
  choose_list <- c()
  for(i in 1:change){
    choose <- sample(1:3, 1)
    choose_list <- c(choose_list, choose)
    new_x <- point[1] - ((point[1] - direction[[choose]][1])/2)
    new_y <- point[2] - ((point[2] - direction[[choose]][2])/2)
    point <- c(new_x, new_y)
    X <- append(X, list(point))
  }
  
  x_value <- sapply(X, function(y) y[1])
  y_value <- sapply(X, function(y) y[2])
  data1 <- data.frame(x_value, y_value)
  
  X <- list(point)
  for(i in 1:(number -change)){
    choose <- sample(1:3, 1)
    choose_list <- c(choose_list, choose)
    new_x <- point[1] - ((point[1] - direction[[choose]][1])/2)
    new_y <- point[2] - ((point[2] - direction[[choose]][2])/2)
    point <- c(new_x, new_y)
    X <- append(X, list(point))
  }
  
  x_value <- sapply(X, function(y) y[1])
  y_value <- sapply(X, function(y) y[2])
  data2 <- data.frame(x_value, y_value)
  
  plot <- ggplot() + 
    geom_point(data=data1, aes(x=x_value, y=y_value), size = 1, colour = "red") + 
    geom_point(data=data2, aes(x=x_value, y=y_value), size = 0.1, colour = "black") + 
    ylab("y") + xlab("x") + theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) + coord_fixed(ratio = 1)
  
  print(plot) 
  return("Plot made!")
}

Challenge_E <- function() {
  while (!is.null(dev.list()))  dev.off()
  require(ggplot2)
  
  A <- c(0,0)
  B <- c(3,4)
  C <- c(4,1)

  initial <- c(0,0)
  chaos(A,B,C, initial, 3000, 200)
  
  initial <- c(40,4)
  chaos(A,B,C, initial, 3000, 200)
  
  initial <- c(13,11)
  chaos(A,B,C, initial, 3000, 200)
  
  initial <- c(20,31)
  chaos(A,B,C, initial, 3000, 200)
  
  return(paste("The final shape and size of the fractal produced remained constant regardless of the starting position.",
        "Since the distance moved by point X in each iteraction is half of the distance between itself and A, B, or C, the further the point X is from these three points,", 
        "the further it will move in a single iteraction.", 
         "Because the direction of movement by point X is towards one of the three points, point X is rapidly brought back to the vicinity of the three points, producing fractals of the same shape and same size."))
}


# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


