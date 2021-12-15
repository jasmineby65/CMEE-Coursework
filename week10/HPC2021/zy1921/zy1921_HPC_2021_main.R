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
               "This is due to communities reaching the dynamic equilibrium, where the rate of extinction equals balances the rate of speciation so the total diversity of the community remain constant.",
               "At high initial diversity, extinction through replacement of individuals by birth and death event quickly reduced the diversity.",
               "However, species richness never fell below the equilibrium due to the introduction of new species through speciation, which balances out the extinction events.",
               "At low initial diversity (mono-species), speciation event introduced new species to the community and rapidly increased the richness,",
               "but further increase above the equilibrium was suppressed by extinction through replacement of individuals."))
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
  
  max <- ceiling(log(max(abundance_vector), base = 2))
  for(i in 2:max){
    octave <- c(octave, sum(count[(2^(i-1)):((2^i)-1)], na.rm = T))
  }
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
  total1 <- sum_vect(result1[[1]], result1[[1]])
  total2 <- sum_vect(result2[[1]], result2[[2]])
  
  for(i in 3:(length(result1)-1)){
    total1 <- sum_vect(total1, result1[[i]])
  }
  for(i in 3:(length(result2)-1)){
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
               "This is because both communities had the same speciation and extinction (death/birth event) rate so will eventually converge to the same dynamic equilibrium for reasons mentioned above.",
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
    
    return()
}


# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  combined_results <- list() #create your list output here to return
  
  # save results to an .rda file
  
}

plot_cluster_results <- function()  {
    # clear any existing graphs and plot your graph within the R window
    # load combined_results from your rda file
    # plot the graphs
    
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
  for(i in 1:8000){
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
  return("The plot shows a fractal with repeating patterns of triangular shape, which has the same proprotion as the tringle made by the 3 initial coordinates (A, B, and C).")
}


# Question 24
turtle <- function(start_position, direction, length)  {
    
  return() # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  
}

# Question 26
spiral <- function(start_position, direction, length)  {
  
  return("type your written answer here")
}

# Question 27
draw_spiral <- function()  {
  # clear any existing graphs and plot your graph within the R window
  
}

# Question 28
tree <- function(start_position, direction, length)  {
  
}

draw_tree <- function()  {
  # clear any existing graphs and plot your graph within the R window

}

# Question 29
fern <- function(start_position, direction, length)  {
  
}

draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window

}

# Question 30
fern2 <- function(start_position, direction, length, dir)  {
  
}
draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window

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
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


