#########################
####### CMCC-ESM2 #######
#########################


rm(list = ls())

require(lsmeans)
require(segmented)
require(interactions)
require(jtools)

#setwd("~/../../../media/jasmine/Album/Project/rcode")
getwd()

####################
#### Whole area ####
####################

data <- as.data.frame(read.csv("../csv/CMCC-ESM2_epc100_whole.csv", header = TRUE, stringsAsFactors = F))
head(data)


### Annual mean
mean1 <- lm(Annual ~ Year, data = data)
ab_mean <- (data$Annual[data$Year == 2100] - data$Annual[data$Year == 2015])
ab_mean
per_mean <- ((ab_mean/data$Annual[data$Year == 2015])*100)
per_mean
summary(mean1)

# Inflection 
davies.test(mean1, seg.Z=~Year)
mean2 <- segmented(mean1, seg.Z = ~Year)
summary(mean2)
slope(mean2)


### Summer mean
summer1 <- lm(Summer ~ Year, data = data)
summary(summer1)

davies.test(summer1, seg.Z=~Year)
summer2 <- segmented(summer1, seg.Z = ~Year)
summary(summer2)
slope(summer2)


### Winter mean
winter1 <- lm(Winter ~ Year, data = data)
summary(winter1)

davies.test(winter1, seg.Z=~Year)
winter2<- segmented(winter1, seg.Z = ~Year)
summary(winter2)
slope(winter2)


### Result summary 
sink("../output/CMCC-ESM2/epc100_whole.txt")

cat("epc100 CMCC-ESM2\nWhole region result:\n\n\n")

cat("Annual result:\n")
print(summary(mean1))
cat("\nDavies test:\n")
print(davies.test(mean1, seg.Z=~Year))
cat("\nInflection Summary\n")
print(summary(mean2))
print(slope(mean2))

cat("\n\nSummer result:\n")
print(summary(summer1))
cat("\n\nDavies test:\n")
print(davies.test(summer1, seg.Z=~Year))
cat("\nInflection Summary\n")
print(summary(summer2))
print(slope(summer2))

cat("\n\nWinter result:\n")
print(summary(winter1))
cat("\nDavies test:\n")
print(davies.test(winter1, seg.Z=~Year))
cat("\nInflection Summary\n")
print(summary(winter2))
print(slope(winter2))

sink()

print("Whole area output done!")

