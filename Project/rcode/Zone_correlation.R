###########################
#### Zonal Correlation ####
###########################

rm(list = ls())

require(lsmeans)
require(segmented)
require(interactions)
require(jtools)
require(ggplot2)
library(tidyverse)
library(rstatix)
library(lme4)
require(gridExtra)
require(grid)
require(gridtext)
require(smatr)
require(png)

#setwd("~/../../../media/jasmine/Album/Project/rcode")
getwd()

###############
### Export ####
###############

data <- as.data.frame(read.csv("../csv/Zone_absolute_export.csv", header = TRUE, stringsAsFactors = F))
data <- data[order(data$Variable),]
data <- data[data$Variable !="Export", ]
data["Sign"] = sign(data$Correlation)
head(data)

data["Kendall"] = abs(data$Correlation)
head(data)


## Correlation ##

result <- matrix(nrow = length(unique(data$Variable)), ncol = 5)


for(i in 1:length(unique(data$Variable))){
  print(i)
  
  var <- unique(data$Variable)[i]
  print(var)
  
  result[i,1] <- var
  
  subset <- data[data$Variable == var,]
  
  model <- lme(data = subset, Kendall ~ Zone, random =  ~1|Model)
  
  output <- anova(model)
  result[i,2] <- format(output$numDF[2], digits = 4, scientific=FALSE)
  result[i,3] <- format(output$denDF[2], digits = 4, scientific=FALSE)
  result[i,4] <- format(output$`F-value`[2], digits = 4, scientific=FALSE)
  result[i,5] <- format(output$`p-value`[2], digits = 4, scientific=FALSE)
  
}

result
result <- as.data.frame(result)
colnames(result) <- c("Variable", "numDF", "denDF", "F-value", "p-value")
write_csv(result, "../csv/Zone_Kendall_lmer_export.csv")
result


### Plotting ###

data[data == "Diatom"] <- "Diatom"
data[data == "Export"] <- "Export"
data[data == "Iron"] <- "Iron"
data[data == "MLD"] <- "MLD"
data[data == "Nitrate"] <- "Nitrate"
data[data == "NPP"] <- "NPP"
data[data == "PAR"] <- "PAR*"
data[data == "Sea ice fraction"] <- "Sea ice fraction"
data[data == "SST"] <- "SST"

data <- data %>% 
  group_by(Variable, Zone) %>%
  mutate(Mean_cor = sum(Sign))
head(data)
data["Sign2"] = sign(data$Mean_cor)
data = as.data.frame(data)

data$Sign[data$Sign2 == 1] = "Positive"
head(data)
data$Sign[data$Sign2 == -1] = "Negative"
head(data)


png(filename="../output/Multimodel/Zonal_correlation_export.png", res=600, width=10000, height=4000)

Zone <- ggplot(data=data, aes(x = Zone, y=Kendall, fill = Sign)) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  ggtitle("(A) Export") +
  labs(y = "Pearson correlation coefficient")  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"),
        legend.title = element_blank(),
        legend.direction = "horizontal",
        legend.position = c(0.9, 1.15),
        legend.background = element_blank(),
        legend.key.size = unit(25, "pt"),
        legend.text=element_text(size=18)) +
  facet_wrap(. ~ Variable, nrow = 1) +
  coord_cartesian(ylim = c(0, 1))
Zone

dev.off()



###############
##### Ice #####
###############

data <- as.data.frame(read.csv("../csv/Zone_absolute_ice.csv", header = TRUE, stringsAsFactors = F))
data <- data[order(data$Variable),]
data <- data[data$Variable !="Sea ice fraction", ]
data <- data[data$Variable !="Export", ]
data <- data[data$Variable !="NPP", ]
data["Sign"] = sign(data$Correlation)
head(data)

data["Kendall"] = abs(data$Correlation_ice)
head(data)

## Correlation ##


result <- matrix(nrow = length(unique(data$Variable)), ncol = 5)


for(i in 1:length(unique(data$Variable))){
  print(i)
  
  var <- unique(data$Variable)[i]
  print(var)
  
  result[i,1] <- var
  
  subset <- data[data$Variable == var,]
  
  model <- lme(data = subset, Kendall ~ Zone, random =  ~1|Model)
  
  output <- anova(model)
  result[i,2] <- format(output$numDF[2], digits = 4, scientific=FALSE)
  result[i,3] <- format(output$denDF[2], digits = 4, scientific=FALSE)
  result[i,4] <- format(output$`F-value`[2], digits = 4, scientific=FALSE)
  result[i,5] <- format(output$`p-value`[2], digits = 4, scientific=FALSE)
  
}

result
result <- as.data.frame(result)
colnames(result) <- c("Variable", "numDF", "denDF", "F-value", "p-value")
write_csv(result, "../csv/Zone_Kendall_lmer_ice.csv")
result


### Plotting ###
data[data == "Diatom"] <- "Diatom"
data[data == "Export"] <- "Export"
data[data == "Iron"] <- "Iron"
data[data == "MLD"] <- "MLD"
data[data == "Nitrate"] <- "Nitrate"
data[data == "NPP"] <- "NPP"
data[data == "PAR"] <- "PAR"
data[data == "Sea ice fraction"] <- "Sea ice fraction"
data[data == "SST"] <- "SST"

data <- data %>% 
  group_by(Variable, Zone) %>%
  mutate(Mean_cor = sum(Sign))
head(data)
data["Sign2"] = sign(data$Mean_cor)
data = as.data.frame(data)

data$Sign[data$Sign2 == 1] = "Positive"
head(data)
data$Sign[data$Sign2 == -1] = "Negative"
head(data)


png(filename="../output/Multimodel/Zonal_correlation_ice.png", res=600, width=10000, height=4000)

Zone2 <- ggplot(data=data, aes(x = Zone, y=Kendall, fill = Sign)) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  ggtitle("(C) Sea ice fraction") +
  labs(y = "Pearson correlation coefficient")  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"),
        legend.position = "none") +
  facet_wrap(. ~ Variable, nrow = 1) +
  coord_cartesian(ylim = c(0, 1))
Zone2

dev.off()



#############
#### NPP ####
#############

data <- as.data.frame(read.csv("../csv/Zone_absolute_npp.csv", header = TRUE, stringsAsFactors = F))
data <- data[order(data$Variable),]
data <- data[data$Variable !="Export", ]
data <- data[data$Variable !="NPP", ]
data["Sign"] = sign(data$Correlation)
head(data)

data["Kendall"] = abs(data$Correlation_npp)
head(data)

## Correlation ##

result <- matrix(nrow = length(unique(data$Variable)), ncol = 5)


for(i in 1:length(unique(data$Variable))){
  print(i)
  
  var <- unique(data$Variable)[i]
  print(var)
  
  result[i,1] <- var
  
  subset <- data[data$Variable == var,]
  
  model <- lme(data = subset, Kendall ~ Zone, random =  ~1|Model)
  
  output <- anova(model)
  result[i,2] <- format(output$numDF[2], digits = 4, scientific=FALSE)
  result[i,3] <- format(output$denDF[2], digits = 4, scientific=FALSE)
  result[i,4] <- format(output$`F-value`[2], digits = 4, scientific=FALSE)
  result[i,5] <- format(output$`p-value`[2], digits = 4, scientific=FALSE)
  
}

result
result <- as.data.frame(result)
colnames(result) <- c("Variable", "numDF", "denDF", "F-value", "p-value")
write_csv(result, "../csv/Zone_Kendall_lmer_npp.csv")
result


### Plotting ###
data[data == "Diatom"] <- "Diatom"
data[data == "Export"] <- "Export**"
data[data == "Iron"] <- "Iron"
data[data == "MLD"] <- "MLD"
data[data == "Nitrate"] <- "Nitrate"
data[data == "NPP"] <- "NPP"
data[data == "PAR"] <- "PAR*"
data[data == "Sea ice fraction"] <- "Sea ice fraction"
data[data == "SST"] <- "SST"

data <- data %>% 
  group_by(Variable, Zone) %>%
  mutate(Mean_cor = sum(Sign))
head(data)
data["Sign2"] = sign(data$Mean_cor)
data = as.data.frame(data)

data$Sign[data$Sign2 == 1] = "Positive"
head(data)
data$Sign[data$Sign2 == -1] = "Negative"
head(data)

png(filename="../output/Multimodel/Zonal_correlation_npp.png", res=600, width=10000, height=4000)

Zone3 <- ggplot(data=data, aes(x = Zone, y=Kendall, fill = Sign)) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  ggtitle("(B) NPP") +
  labs(y = "Pearson correlation coefficient")  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"),
        legend.position = "none") +
  facet_wrap(. ~ Variable, nrow = 1) +
  coord_cartesian(ylim = c(0, 1))
Zone3

dev.off()


###### Final plot #####
png(filename="../output/Multimodel/Final_zone_correlatiom.png", res=600, width=8000, height=10000)
grid.arrange(Zone, Zone3, Zone2, ncol = 1)
dev.off()
