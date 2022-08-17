###################################
##### Correlation with export #####
###################################

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

setwd("~/../../../media/jasmine/Album/Project/rcode")
getwd()


#############################
##### Zonal correlation #####
#############################

data <- as.data.frame(read.csv("../csv/Season_final.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Export", ]
head(data)

data$Kendall <- abs(data$Kendall)

### Plotting ###

data[data == "Iron"] <- "Iron*"
data[data == "MLD"] <- "MLD***'"
data[data == "NPP"] <- "NPP*'"
data[data == "PAR"] <- "PAR***'''"
data[data == "Sea ice fraction"] <- "Sea ice fraction**"
data[data == "SST"] <- "SST***"


data <- data %>% 
  group_by(Variable, Season) %>%
  mutate(Mean_cor = mean(Kendall))
head(data)

data <- data %>%
  mutate(Season = factor(Season, levels = c("Summer", "Winter"))) %>%
  mutate(Variable = factor(Variable, levels = c("NPP*'", "Diatom", "PAR***'''", "Iron*", "Nitrate", "SST***", "Sea ice fraction**", "MLD***'")))
head(data)




png(filename="../output/Multimodel/Season.png", res=600, width=10000, height=4000)

Zone <- ggplot(data=data, aes(x = Season, y=Percentage, fill = Mean_cor)) +
  scale_fill_viridis_c(limits=c(0, 1), direction = -1) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  ggtitle("Percentage change by 2100 in summer and winter") +
  labs(fill='Correlation')  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        legend.key.height = unit(0.06, units = "npc"),
        legend.key.width = unit(0.03, units = "npc"),
        legend.title = element_text(size=15),
        legend.text = element_text(size=12),
        legend.spacing.y = unit(0.02, units = 'npc'),
        legend.box.margin=margin(0,10,0,0)) +
  facet_wrap(. ~ Variable, scales="free", nrow = 1)
Zone

dev.off()



