data <- read.csv("../data/Data.csv", stringsAsFactors = F) 
data["LogP"] <- log(data$PopBio)
head(data)

# Subset single experiments
subset <- subset(data, ID == "1")
subset["LogP"] <- log(subset$PopBio)
head(subset)

plot(subset$Time, subset$PopBio)
plot(subset$Time, subset$LogP)

## Modelling each subset of data ##
require(dplyr)
set.seed(1234)
results <- data %>%
  group_by(ID) %>%
  do(Modelling(.))

Finals <- data.frame(results)
Finals

## Making jpeg plots of each subset ##
for(i in 0:max(data$ID)){
  subset <- subset(data, ID == i)
  models <- subset(Finals, ID == i)
  plot <- plotting(subset, models)
  
  
  jpeg(paste0("../plots/Subset", i, ".jpg"), 600, 500)
  print(plot)
  dev.off()
  
  cat("Plot", i, "saved!")
}

## Comparing AIC ##
Finals$AIC <- unlist(Finals$AIC)
Finals <- Finals %>% 
  group_by(ID) %>%
  mutate(rank = dense_rank(AIC)) 

Finals <- data.frame(Finals)
Finals$AIC <- unlist(Finals$AIC)
head(Finals)

compare <- function(models){
  if(models$AIC[models$rank==2] - models$AIC[models$rank==1] < 2){
  models$rank[models$rank==2] <- 1
  if(models$AIC[models$rank==3] - min(models$AIC[models$rank==1]) < 2){
    models$rank[models$rank==3] <- 1
    if(models$AIC[models$rank==4] - min(models$AIC[models$rank==1]) < 2){
      models$rank[models$rank==4] <- 1}}} else
        if(models$AIC[models$rank==3] - models$AIC[models$rank==2] < 2){
          models$rank[models$rank==3] <- 2
          if(models$AIC[models$rank==4] - min(models$AIC[models$rank==2]) < 2){
            models$rank[models$rank==4] <- 2}} else 
              if(models$AIC[models$rank==4] - models$AIC[models$rank==3] < 2){
                models$rank[models$rank==4] <- 3} }


for(i in 0:length(unique(Finals$ID))){
  print(i)
  models <- subset(Finals, ID == i)
  models
  try(compare(models), silent = T)
  cat("Rearranging subset", i, "done!\n")
}
Finals

Type_rank <- Finals %>%
  group_by(rank, Type) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n))

Finals$AIC <- unlist(Finals$AIC)
Type_rank <- Type_rank %>% 
  group_by(rank) %>%
  mutate(rank_within = dense_rank(desc(freq)))

Type_rank <- data.frame(Type_rank)
head(Type_rank)


Category_rank <- Finals %>%
  group_by(rank, Category) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n))

Category_rank <- Category_rank %>% 
  group_by(rank) %>%
  mutate(rank_within = dense_rank(desc(freq)))

Category_rank <- data.frame(Category_rank)
Category_rank

require(ggplot2)

cbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

plot_type <- ggplot(Type_rank, aes(fill=Type, y=freq, x=rank)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values=cbPalette) +
  xlab("Rank") + ylab("Frequency") +
  theme_bw() + 
  theme(panel.grid.minor = element_blank()) +
  theme(aspect.ratio=0.8) +
  ggtitle("(a) Model type")
plot_type


pdf("../plots/Model_type.pdf", 10, 7)
plot_type
dev.off()

plot_category <- ggplot(Category_rank, aes(fill=Category, y=freq, x=rank)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values=cbPalette) +
  xlab("Rank") + ylab("Frequency") +
  theme_bw() + 
  theme(panel.grid.minor = element_blank()) +
  theme(aspect.ratio=0.8) +
  ggtitle("(b) Model category")
plot_category

pdf("../plots/Model_category.pdf", 10, 7)
plot_category
dev.off()
