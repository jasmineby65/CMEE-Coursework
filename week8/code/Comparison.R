data <- read.csv("../data/Data.csv", stringsAsFactors = F) 

# Subset single experiments
subset <- subset(data, ID == "1")
subset["LogP"] <- log(subset$PopBio)
head(subset)

plot(subset$Time, subset$PopBio)
plot(subset$Time, subset$LogP)