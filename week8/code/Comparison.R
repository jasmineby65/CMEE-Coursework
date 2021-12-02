data <- read.csv("../data/Data.csv", stringsAsFactors = F) 
data["LogP"] <- log(data$PopBio)
head(data)

# Subset single experiments
subset <- subset(data, ID == "1")
subset["LogP"] <- log(subset$PopBio)
head(subset)

plot(subset$Time, subset$PopBio)
plot(subset$Time, subset$LogP)

require(dplyr)
results <- data %>%
  group_by(ID) %>%
  do(Modelling(.))

results
Finals <- data.frame(results)
Finals

Finals <- data.frame(matrix(ncol = 5, nrow = 0))
x <- c("Models", "Type", "Category","AIC", "ID")
colnames(Finals) <- x
Finals


for(i in 1:max(data$ID)){
  subset <- subset(data, ID == i)
  Models <- try(Modelling(subset),silent = T)
  Models$ID = i
  Finals <- rbind(Finals, Models)
}
Finals
tail(Finals)
str(Finals)

subset <- subset(data, ID == 161)
estimate_r(subset)
plot(subset$Time, subset$PopBio)

rolling <- roll_regres(PopBio ~ Time, data = subset, width = as.integer(nrow(subset)*0.45)) 
rolling
a <- which.max(rolling$coefs[,"Time"])
r_estimate <- rolling$coefs[a,"Time"]
r_estiamte

Models <- Modelling(subset)
Models
Models$ID = 160
Finals <- rbind(Finals, Models)


for(i in 0:max(data$ID)){
  subset <- subset(data, ID == i)
  models <- subset(Finals, ID == i)
  plot <- plotting(subset, models)
  
  
  jpeg(paste0("../plots/Subset", i, ".jpg"), 800, 500)
  print(plot)
  dev.off()
  
  cat("Plot", i, "saved!")
}
