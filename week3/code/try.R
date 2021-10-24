doit <- function(x){
    temp_x <- sample(x, replace = T)
    if(length(unique(temp_x))>30){  #'unique' display the vector with repeat removed
        print(paste("Mean of this sample was:", as.character(mean(temp_x))))
    }
   else {
       stop("Couldn't calulate mean: too few unique values!") 
       # gives an error with the specified message
   }
}

set.seed(1345)
popn <- rnorm(50)
hist(popn)

#lapply(1:15, function(i) doit(popn))

result <- lapply(1:15, function(i) try(doit(popn), F))
# try will keep the code running even if there is an error
# F will suppress any error messages
