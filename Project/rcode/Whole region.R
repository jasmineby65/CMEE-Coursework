####################################
##### Whole region correlation #####
####################################

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


############################
#### Pearson vs Kendall ####
############################

data <- as.data.frame(read.csv("../csv/Correlation.csv", header = TRUE, stringsAsFactors = F))
head(data)

correlation_test1 <- lmer(Correlation ~ Type + (1|Model/Variable), data = data)
summary(correlation_test1)

correlation_test2 <- lmer(Correlation ~ 1 + (1|Model/Variable), data = data)
summary(correlation_test2)

anova(correlation_test1, correlation_test2)



#############################
#### Variable comparison ####
#############################

data <- as.data.frame(read.csv("../csv/Whole_pearson.csv", header = TRUE, stringsAsFactors = F))
head(data)

data["Abs"] = abs(data$Correlation)
head(data)

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Abs, type = "common")

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Abs, type = "common")%>% 
  write_csv("../output/Multimodel/Whole_variable_correlation.csv")


### Plotting ###

png(filename="../output/Multimodel/Whole.png", res=600, width=10000, height=4100)

Whole <- ggplot(data=data, aes(x=reorder(Variable, -Abs), y=Abs)) +
  geom_boxplot(lwd=0.5, fill = "#FFCC33") +
  # scale_fill_grey(start=0.5, end=0.8)+
  theme_classic() +
  labs(y = "Pearson's correlation coefficient",
       title = "(A) Correlation of percentage change by 2100 with export") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 20, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 30, 40, 5.5), "pt"))
Whole

dev.off()



#############################
##### Zonal correlation #####
#############################

#############################
#### Variable comparison ####
#############################

data <- as.data.frame(read.csv("../csv/Zone.csv", header = TRUE, stringsAsFactors = F))
head(data)

data["Abs"] = abs(data$Correlation)
head(data)

## Correlation ##
data %>% 
  group_by(Variable, Zone) %>%
  get_summary_stats(Abs, type = "common")

res.kruskal_correlation <- data %>% 
  group_by(Variable) %>%
  kruskal_test(Abs ~ Zone)

res.kruskal_correlation

write_csv(res.kruskal_correlation, "../csv/Zonal_correlation_kruskal.csv")

## Percentage ##
data %>% 
  group_by(Variable, Zone) %>%
  get_summary_stats(Percentage, type = "common")

res.kruskal_per <- data %>% 
  group_by(Variable) %>%
  kruskal_test(Percentage ~ Zone)

res.kruskal_per
write_csv(res.kruskal_per, "../csv/Zonal_percentage_kruskal.csv")


### Plotting ###

data[data == "NPP"] <- "NPP*"
data[data == "Diatom"] <- "Diatom*"
data[data == "PAR"] <- "PAR*"

data <- data %>% 
  group_by(Variable) %>%
  mutate(Mean_cor = mean(Abs))
head(data)

data <- data %>%
  mutate(Zone = factor(Zone, levels = c("Inc", "Dec"))) %>%
  mutate(Variable = factor(Variable, levels = c("NPP*", "Diatom*", "PAR*", "Iron", "Nitrate", "SST", "Sea ice cover", "MLD")))
head(data)


png(filename="../output/Multimodel/Zonal.png", res=600, width=10000, height=4000)

Zone <- ggplot(data=data, aes(x = Zone, y=Percentage, fill = Mean_cor)) +
  scale_fill_viridis_c(limits=c(0, 1), direction = -1) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  ggtitle("(B) Percentage change by 2100 in increasing and decreasing export zones") +
  labs(fill='Correlation')  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 15, hjust = 0.5, face = "bold", color = "#333333"), 
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



###### Final plot #####
png(filename="../output/Multimodel/Final.png", res=600, width=10000, height=8100)
grid.arrange(Whole, Zone, ncol = 1)
dev.off()

