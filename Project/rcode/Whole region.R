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
#### Variable comparison ####
#############################

data <- as.data.frame(read.csv("../csv/Whole_final.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Export", ]
head(data)

# Pearson #
# 
# data["Abs"] = abs(data$Kendall)
# head(data)
# 
# data %>% 
#   group_by(Variable) %>%
#   get_summary_stats(Abs, type = "common")
# 
# data %>% 
#   group_by(Variable) %>%
#   get_summary_stats(Abs, type = "common")%>% 
#   write_csv("../output/Multimodel/Whole_variable_correlation.csv")
# 
# 
# ### Plotting ###
# 
# png(filename="../output/Multimodel/Whole.png", res=600, width=10000, height=4100)
# 
# Whole <- ggplot(data=data, aes(x=reorder(Variable, -Abs), y=Abs)) +
#   geom_boxplot(lwd=0.5, fill = "#FFCC33") +
#   # scale_fill_grey(start=0.5, end=0.8)+
#   theme_classic() +
#   labs(y = "Pearson's correlation coefficient",
#        title = "(A) Correlation of percentage change by 2100 with export") +
#   ylim(0,1) +
#   theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
#         plot.title.position = "plot",
#         axis.text = element_text(size = 15),
#         axis.title.y = element_text(size = 18, margin = margin(r = 10)),
#         axis.title.x = element_blank(),
#         panel.border = element_rect(size = 0.5, fill = NA),
#         axis.line = element_blank(),
#         plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"))
# Whole
# 
# dev.off()

# Pearson #

data["Kendall"] = abs(data$Kendall)
head(data)

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")%>% 
  write_csv("../output/Multimodel/Whole_variable_correlation_kendall.csv")


### Plotting ###

png(filename="../output/Multimodel/Whole_kendall.png", res=600, width=10000, height=4100)

Whole <- ggplot(data=data, aes(x=reorder(Variable, -Kendall), y=Kendall)) +
  geom_boxplot(lwd=0.5, fill = "#FFCC33") +
  # scale_fill_grey(start=0.5, end=0.8)+
  theme_classic() +
  labs(y = "Pearson's correlation coefficient",
       title = "(A) Correlation of percentage change by 2100 with export") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"))
Whole

dev.off()

#############################
##### Zonal correlation #####
#############################

data <- as.data.frame(read.csv("../csv/Zone_final.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Export", ]
head(data)

# data["Abs"] = abs(data$Kendall)
# head(data)

## Correlation ##
# data %>% 
#   group_by(Variable, Zone) %>%
#   get_summary_stats(Abs, type = "common")
# 
# res.kruskal_correlation <- data %>% 
#   group_by(Variable) %>%
#   kruskal_test(Abs ~ Zone)
# 
# res.kruskal_correlation
# 
# write_csv(res.kruskal_correlation, "../csv/Zonal_correlation_kruskal.csv")
# 
# ## Percentage ##
# data %>% 
#   group_by(Variable, Zone) %>%
#   get_summary_stats(Percentage, type = "common")
# 
# res.kruskal_per <- data %>% 
#   group_by(Variable) %>%
#   kruskal_test(Percentage ~ Zone)
# 
# res.kruskal_per
# write_csv(res.kruskal_per, "../csv/Zonal_percentage_kruskal.csv")


# ### Plotting ###
# data <- data %>% 
#   group_by(Variable, Zone) %>%
#   mutate(Mean_cor = mean(Abs))
# head(data)
# 
# data <- data %>%
#   mutate(Zone = factor(Zone, levels = c("Inc", "Dec"))) %>%
#   mutate(Variable = factor(Variable, levels = c("NPP", "Diatom", "PAR", "Iron", "Nitrate", "SST", "Sea ice cover", "MLD")))
# head(data)
# 
# data[data == "Diatom"] <- "Diatom***'''"
# data[data == "Export"] <- "Export***"
# data[data == "Iron"] <- "Iron"
# data[data == "MLD"] <- "MLD"
# data[data == "Nitrate"] <- "Nitrate'"
# data[data == "NPP"] <- "NPP***''"
# data[data == "PAR"] <- "PAR***''"
# data[data == "Sea ice fraction"] <- "Sea ice fraction"
# data[data == "SST"] <- "SST"
# 
# 
# png(filename="../output/Multimodel/Zonal.png", res=600, width=10000, height=4000)
# 
# Zone <- ggplot(data=data, aes(x = Zone, y=Percentage, fill = Mean_cor)) +
#   scale_fill_viridis_c(limits=c(0, 1), direction = -1) +
#   geom_boxplot(lwd=0.5) +
#   theme_classic() +
#   ggtitle("(B) Percentage change by 2100 in increasing and decreasing export zones") +
#   labs(fill='Correlation')  +
#   theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
#         plot.title.position = "plot",
#         strip.text.x = element_text(size = 15, hjust = 0.5, face = "bold", color = "#333333"), 
#         axis.title = element_blank(),
#         axis.text = element_text(size = 15),
#         panel.border = element_rect(size = 0.5, fill = NA),
#         axis.line = element_blank(),
#         strip.background = element_rect(colour="white", fill="white"),
#         legend.key.height = unit(0.06, units = "npc"),
#         legend.key.width = unit(0.03, units = "npc"),
#         legend.title = element_text(size=15),
#         legend.text = element_text(size=12),
#         legend.spacing.y = unit(0.02, units = 'npc'),
#         legend.box.margin=margin(0,10,0,0)) +
#   facet_wrap(. ~ Variable, scales="free", nrow = 1)
# Zone
# 
# dev.off()


#### Kendall #####
data["Kendall"] = abs(data$Kendall)
head(data)

## Correlation ##
data %>% 
  group_by(Variable, Zone) %>%
  get_summary_stats(Kendall, type = "common")

res.kruskal_correlation <- data %>% 
  group_by(Variable) %>%
  kruskal_test(Kendall ~ Zone)

res.kruskal_correlation

write_csv(res.kruskal_correlation, "../csv/Zonal_correlation_kruskal.csv")

## Percentage ##
data %>% 
  group_by(Variable, Zone) %>%
  get_summary_stats(Kendall, type = "common")

res.kruskal_per <- data %>% 
  group_by(Variable) %>%
  kruskal_test(Kendall ~ Zone)

res.kruskal_per
write_csv(res.kruskal_per, "../csv/Zonal_percentage_kruskal.csv")


### Plotting ###
data[data == "Diatom"] <- "Diatom***'''"
data[data == "Nitrate"] <- "Nitrate'"
data[data == "NPP"] <- "NPP***''"
data[data == "PAR"] <- "PAR***''"

data <- data %>% 
  group_by(Variable, Zone) %>%
  mutate(Mean_cor = mean(Kendall))
head(data)

data <- data %>%
  mutate(Zone = factor(Zone, levels = c("Inc", "Dec"))) %>%
  mutate(Variable = factor(Variable, levels = c("NPP***''", "Diatom***'''", "PAR***''", "Iron", "Nitrate'", "SST", "Sea ice cover", "MLD")))
head(data)
typeof(data)




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
png(filename="../output/Multimodel/Final.png", res=600, width=10000, height=9000)
grid.arrange(Whole, Zone, ncol = 1)
dev.off()

