#############################
##### Zonal correlation #####
#############################

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

data <- data %>% 
  group_by(Variable) %>%
        mutate(Mean_cor = mean(Abs))
head(data)

data <- data %>%
  mutate(Zone = factor(Zone, levels = c("Inc", "Dec"))) %>%
  mutate(Variable = factor(Variable, levels = c("NPP", "Diatom", "PAR", "Iron", "Nitrate", "SST", "Sea ice cover", "MLD")))
head(data)

png(filename="../output/Multimodel/Zonal.png", res=600, width=10000, height=4000)

ggplot(data=data, aes(x = Zone, y=Percentage, fill = Mean_cor)) +
  scale_fill_gradient2(limits=c(0, 1)) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  ggtitle("(B) Percentage change by 2100 in increasing and decreasing export zones") +
  labs(fill='Correlation')  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        strip.text.x = element_text(size = 15, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        legend.key.height = unit(0.12, units = "npc"),
        legend.key.width = unit(0.03, units = "npc"),
        legend.title = element_text(size=15),
        legend.text = element_text(size=12),
        legend.spacing.y = unit(0.05, units = 'npc'),
        legend.box.margin=margin(10,10,10,10)) +
  facet_wrap(. ~ Variable, scales="free", nrow = 1)

dev.off()
  
### Plotting points with mean+SE ###

# plot <- as.data.frame(read.csv("../output/Multimodel/Whole_variable_correlation.csv", header = TRUE, stringsAsFactors = F))
# 
# png(filename="../output/Multimodel/Whole_variable_correlation_se.png")
# ggplot() + 
#   geom_point(data = data, aes(x = Variable, y = Abs, col = Export)) +
#   geom_point(data = plot, aes(x = Variable, y = mean), color = "red") +
#   geom_errorbar(data = plot, aes(x = Variable, y = mean, ymin=mean-se, ymax=mean+se), width=.1, color = "red")
# dev.off()


# var_plot <- function(data = data, y) {
#   ggplot(data=data[data$Variable == y,], aes(x= Zone, y=Percentage, fill = Mean_cor)) +
#     scale_fill_gradient2(limits=c(0, 1)) +
#     geom_boxplot(lwd=0.5) +
#     theme_classic() +
#     ggtitle(paste0(y)) +  
#     theme(legend.position = "none") +
#     theme(aspect.ratio = 4,
#           plot.title = element_text(size = 15, hjust = 0.5, face = "bold"), 
#           axis.title = element_blank(),
#           panel.border = element_rect(size = 0.5, fill = NA),
#           axis.line = element_blank(), plot.margin = unit(rep(0.3, 4), "cm"),
#           axis.text = element_text(size = 16))
# }
# 
# for(var in unique(data$Variable)){
#   print(var)
#   assign(paste0("Plot_", var), var_plot(data = data, y = var))
# }
# 
# Plot_NPP <- ggplot(data=data[data$Variable == "NPP",], aes(x= Zone, y=Percentage, fill = Mean_cor)) +
#   scale_fill_gradient2(limits=c(0, 1)) +
#   geom_boxplot(lwd=0.5) +
#   theme_classic() +
#   ggtitle("NPP") +  
#   ylab("Pearson's correlation coefficient") +
#   theme(legend.position = "none") +
#   theme(aspect.ratio = 4,
#         plot.title = element_text(size = 15, hjust = 0.5, face = "bold"), 
#         axis.title.y = element_text(size = 18, margin = margin(r = 12)),
#         axis.title.x = element_blank(),
#         panel.border = element_rect(size = 0.5, fill = NA),
#         axis.line = element_blank(), plot.margin = unit(rep(0.3, 4), "cm"),
#         axis.text = element_text(size = 16))
# 
# Plot_NPP
# 
# Plot_MLD <- ggplot(data=data[data$Variable == "MLD",], aes(x= Zone, y=Percentage, fill = Mean_cor)) +
#   scale_fill_gradient2(limits=c(0, 1)) +
#   geom_boxplot(lwd=0.5) +
#   theme_classic() +
#   labs(fill='Correlation')  +
#   ggtitle("MLD") +
#   theme(aspect.ratio = 4,
#         plot.title = element_text(size = 15, hjust = 0.5, face = "bold"), 
#         axis.title = element_blank(),
#         panel.border = element_rect(size = 0.5, fill = NA),
#         axis.line = element_blank(), plot.margin = unit(rep(0.3, 4), "cm"),
#         axis.text = element_text(size = 16),
#         legend.key.height = unit(0.12, units = "npc"),
#         legend.key.width = unit(0.06, units = "npc"),
#         legend.title = element_text(size=15),
#         legend.text = element_text(size=12),
#         legend.spacing.y = unit(0.05, units = 'npc'),
#         legend.box.margin=margin(20,20,20,20))
# 
# Plot_MLD

