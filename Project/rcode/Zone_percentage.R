###########################
#### Zonal percentage #####
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


data <- as.data.frame(read.csv("../csv/Zone_change.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Export", ]
#data <- data[order(data$Variable),]
head(data)

result <- matrix(nrow = length(unique(data$Variable)), ncol = 5)


for(i in 1:length(unique(data$Variable))){
  print(i)
  
  var <- unique(data$Variable)[i]
  print(var)
  
  result[i,1] <- var
  
  subset <- data[data$Variable == var,]
  
  model <- lme(data = subset, Absolute.change ~ Zone, random =  ~1|Model)
  
  output <- anova(model)
  result[i,2] <- format(output$numDF[2], digits = 4, scientific=FALSE)
  result[i,3] <- format(output$denDF[2], digits = 4, scientific=FALSE)
  result[i,4] <- format(output$`F-value`[2], digits = 4, scientific=FALSE)
  result[i,5] <- format(output$`p-value`[2], digits = 4, scientific=FALSE)
  
}

result
result <- as.data.frame(result)
colnames(result) <- c("Variable", "numDF", "denDF", "F-value", "p-value")
write_csv(result, "../csv/Zone_percentage_lmer.csv")
result

### Plotting ###

data[data == "Diatom"] <- "Diatom*"
data[data == "Export"] <- "Export***"
data[data == "Iron"] <- "Iron"
data[data == "MLD"] <- "MLD"
data[data == "Nitrate"] <- "Nitrate"
data[data == "NPP"] <- "NPP*"
data[data == "PAR"] <- "PAR**"
data[data == "Sea ice fraction"] <- "Sea ice fraction*"
data[data == "SST"] <- "SST"

data <- data %>%
  mutate(Zone = factor(Zone, levels = c("Inc", "Dec"))) %>%
  mutate(Variable = factor(Variable, levels = c("Diatom*", 
                                                "NPP*", 
                                                "PAR**",
                                                "Sea ice fraction*", 
                                                "Iron",
                                                "Nitrate",
                                                "SST",  
                                                "MLD")))
head(data)

data["Sign"] = as.character(sign(data$Percentage.change))
data

png(filename="../output/Multimodel/Zonal_percentage.png", res=600, width=10000, height=4000)

Zone <- ggplot(data=data, aes(x = Zone, y=Percentage.change, fill = Variable)) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  ggtitle("Zonal differences in the projected percentage change") +
  labs(y = "Percentage change by 2100")  +
  scale_fill_brewer(palette="Set3") +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        legend.position = "none") +
  facet_wrap(. ~ Variable, scales="free", nrow = 1)
Zone

dev.off()


