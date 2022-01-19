## Loading data
rm(list=ls())
load("../data/KeyWestAnnualMeanTemperature.RData")
# Reload datasets written with the function save
#View(ats)
head(ats)
par(mfrow = c(1,1))
plot(ats)

# 1. calculate the correlation coefficient between the temp of successive years and store it
n <- length(ats$Year)-1

current_temp <- c()
next_temp <- c()
for (i in 1:n){
  current_temp[i] <- ats$Temp[i]
  next_temp[i] <- ats$Temp[i+1] 
}
data <- data.frame(current_temp, next_temp)
head(data)

observed_cor <- cor(x = data$current_temp, y = data$next_temp)
observed_cor 


# 2. repeat this calculation sufficient no of times (10,000)
set.seed(1234)
P <- 10000 # no. of repeat 
permutation <- matrix(0, nrow=n+1, ncol=P) # pre-allocating a matrix to hold resampling outcome

for (i in 1:P){ # resampling 10000 times from Temp 
  permutation[,i] <- sample(x=ats$Temp, size=n+1, replace=F)
  } 
permutation[1:10,1:10]


perm_stat <- rep(0, P) # pre-allocating a vector to hold resampling correlation coefficient 
for (i in 1:P){ 
  current_temp <- c()
  next_temp <- c()
  for (j in 1:n){
    current_temp[j] <- permutation[j,i]
    next_temp[j] <- permutation[j+1,i] 
  }
  data <- data.frame(current_temp, next_temp)

  perm_stat[i] <- cor(x = data$current_temp, y = data$next_temp, method="pearson")
}
perm_stat[1:20]

# 3. calculate what fraction of the random correlation coefficients were greater than the observed one 
greater_perm <- sum((perm_stat[1:P] >= observed_cor), na.rm =T)
greater_perm

p_value <- greater_perm/P
p_value
# can also use mean() which use T=1, F=0 to calculate the mean value of all elements in vector
# p_value <- mean(perm_stat[1:P] >= observed_cor)


# 4. present the results and interpretation in a pdf documents 
# include the source code of this pdf in the submission 

## Making histogram plot ##
dev.off()
require(ggplot2)
plot <- as.data.frame(perm_stat)
head(plot)
p <- ggplot(plot, aes(x=perm_stat)) + 
  geom_histogram(bins = 50, fill="grey", colour="black") + 
  geom_vline(aes(xintercept = observed_cor, col=I("red"))) +
  geom_text(x=0.25, y=500, label ="Original", colour="red", size = 6) +  
  xlab("Correlation coefficient") + 
  theme_bw() + theme(aspect.ratio = 0.7) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p

pdf("../data/Florida_Auto.pdf", 10, 7)
p
dev.off()

# # Plot of the difference between current and next year
# Temp_difference <- data$next_temp - data$current_temp
# plot2 <- data.frame(Temp_difference)
# 
# q <- ggplot(plot2, aes(x = Temp_difference)) + 
#   geom_histogram() +
#   theme_bw() + theme(aspect.ratio = 0.7) +
#   theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
# q
