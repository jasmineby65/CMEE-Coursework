###### Functions #######

## A function to take a sample of size n from a population "popn" and return its mean
myexperiment <- function(popn, n){
    pop_sample <- sample(popn, n, replace = F) 
    # replace in sampling means the sampled object is returned to the population 
    # so each time a sample is taken, it is from the whole population
    # replace = F means that the sampled object is removed from the population
    # so the probability of being sampled will increase proportionally with the size of remaining popu. 
    return(mean(pop_sample))
}

## Calculate means using a FOR loop on a vector without preallocation
loopy_sample1 <- function(popn, n, num){ # num is the no of repeat sampling
    result1 <- vector() #initialise empty vector of size 1
    for(i in 1:num){
        result1 <- c(result1, myexperiment(popn, n))
    }
    return(result1)
}

## To run "num" iterations of the experiment using a FOR loop on a vector with preallocation
loopy_sample2 <- function(popn, n, num){
    result2 <- vector(,num) #Preallocate expected size
    for (i in 1:num){
        result2[i] <- myexperiment(popn,n)
    }
    return(result2)
}

## To run "num" iteractions of the experimetn using a FOR loop on a list with preallocations:
loopy_sample3 <- function(popn, n, num){
    result3 <- vector("list", num) #Preallocate expected size
    for (i in 1:num){
        result3[[i]] <- myexperiment(popn,n)
    }
    return(result3)
}

## To run "num" iterations of the experiment using vectorization using lapply:
lapply_sample <- function(popn, n, num){
    result4 <- lapply(1:num, function(i) myexperiment(popn, n)) #lapply returns list
    return(result4)
}

## To run "num" iterations of the experiment using vectorization using sapply:
sapply_sample <- function(popn, n, num){
    result5 <- sapply(1:num, function(i) myexperiment(popn, n)) #sapply returns vector
    return(result5)
}


## Making sampling population 
set.seed(12345)
popn <- rnorm(10000)
hist(popn)

## Running the different methods:
n <- 100 # sample size taken for each experiment
num <- 10000 # number of repeat experiment

print("Using loops without preallocation on a vector took:")
print(system.time(loopy_sample1(popn,n,num)))
# 0.741

print("Using loops with preallocation on a vector took:")
print(system.time(loopy_sample2(popn,n,num)))
# 0.261

print("Using loops with preallocation on a list took:")
print(system.time(loopy_sample3(popn,n,num)))
# 0.264

print("Using the vectorized lapply function on a list took:")
print(system.time(lapply_sample(popn,n,num)))
# 0.261

print("Using the vectorized sapply function on a list tool:")
print(system.time(sapply_sample(popn,n,num)))
# 0.323

