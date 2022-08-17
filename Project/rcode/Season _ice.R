##################
##### Season #####
##################

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

setwd("~/../../../media/jasmine/Album/Project/rcode")
getwd()


#############################
#### Variable comparison ####
#############################

data <- as.data.frame(read.csv("../csv/Season_final.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Sea ice fraction", ]
head(data)

data["Kendall"] = abs(data$Correlation_ice_k)
head(data)

## Correlation ##
data %>% 
  group_by(Variable, Season) %>%
  get_summary_stats(Kendall, type = "common")

res.kruskal_correlation <- data %>% 
  group_by(Variable) %>%
  kruskal_test(Kendall ~ Season)

res.kruskal_correlation

write_csv(res.kruskal_correlation, "../csv/Season_correlation_ice.csv")


### Plotting ###

data[data == "MLD"] <- "MLD*'"
data[data == "NPP"] <- "NPP'"
data[data == "PAR"] <- "PAR*'"
data[data == "SST"] <- "SST*"

data <- data %>% 
  group_by(Variable, Season) %>%
  mutate(Mean_cor = mean(Abs, na.rm = TRUE))
print(data, n = 74)

data <- data %>%
  mutate(Season = factor(Season, levels = c("Summer", "Winter"))) %>%
  mutate(Variable = factor(Variable, levels = c("NPP'", "Diatom", "PAR*'", "Iron", "Nitrate", "SST*", "Sea ice cover", "MLD*'")))
head(data)


png(filename="../output/Multimodel/Season.png", res=600, width=10000, height=4000)

Season <- ggplot(data=data, aes(x = Season, y=Percentage, fill = Mean_cor)) +
  scale_fill_viridis_c(limits=c(0, 1), direction = -1) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  ggtitle("Seasonal percentage change by 2100") +
  labs(fill='Correlation')  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 15, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title = element_blank(),
        axis.text.y = element_text(size = 15),
        axis.text.x = element_text(size = 12),
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
Season

dev.off()

