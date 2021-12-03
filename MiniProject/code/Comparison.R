data <- read.csv("../data/Data.csv", stringsAsFactors = F) 
data["LogP"] <- log(data$PopBio)
length(unique(data$ID))
length(unique(data$Citation))
length(unique(data$Species))
length(unique(data$Temp))
length(unique(data$Citation))
length(unique(data$Medium))
unique(data$PopBio_units)

source("Modelling.R")

# # Subset single experiments
# subset <- subset(data, ID == "1")
# subset["LogP"] <- log(subset$PopBio)
# head(subset)
# 
# plot(subset$Time, subset$PopBio)
# plot(subset$Time, subset$LogP)

## Modelling each subset of data ##
require(dplyr)
set.seed(1234)
results <- data %>%
  group_by(ID) %>%
  do(Modelling(.))

Finals <- data.frame(results)
Finals


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

# Examining failed plots
fail <- c()
fail <- Finals$ID[is.na(Finals$rank)]
fail
length(fail)
type <- Finals$Type[fail]
type

sum(type=="Cubic")
sum(type=="Logistic")
sum(type=="Quadratic")
sum(type=="Gompertz")

datapoints <- c()

for(i in fail){
  datapoints <- c(datapoints, length(data$ID[data$ID==i]))  
}
datapoints
sum(datapoints==5|datapoints==4)/length(datapoints)


big <- fail[datapoints > 5]
big


#Plotting examples 
subset <- subset(data, ID == 1)
models <- subset(Finals, ID == 1)
plot1 <- plotting(subset, models)
plot1
subset <- subset(data, ID == 27)
models <- subset(Finals, ID == 27)
plot27 <- plotting(subset, models)
plot27
subset <- subset(data, ID == 50)
models <- subset(Finals, ID == 50)
plot50 <- plotting(subset, models)

subset <- subset(data, ID == 110)
models <- subset(Finals, ID == 110)
plot165 <- plotting(subset, models)

require(ggpubr)
fig <- ggarrange(plot1, plot27, plot50, plot165, nrow=2, ncol=2, labels = c("A","B","C","D"))
pdf("Example.pdf", 15, 15)
fig
dev.off()


## Frequency of rank ##
# Type
Type_rank <- Finals %>%
  group_by(rank, Type) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n))

Type_rank <- Type_rank %>% 
  group_by(rank) %>%
  mutate(rank_within = dense_rank(desc(freq))) %>%
  arrange(rank, match(Type, c("Quadratic", "Cubic", "Logistic", "Gompertz")))

Type_rank <- data.frame(Type_rank)
head(Type_rank)
Type_rank

# Category
Category_rank <- Finals %>%
  group_by(rank, Category) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n))

Category_rank <- Category_rank %>% 
  group_by(rank) %>%
  mutate(rank_within = dense_rank(desc(freq))) %>%
  arrange(rank, match(Category, c("Phenomenological", "Mechanistic")))

Category_rank <- data.frame(Category_rank)
Category_rank

# Result table 
rank <- c(Type_rank$rank[1:16], rep("No_fit", 4))
length(rank)
category <- c(rep(c("Phenomenological", NA, "Mechanistic", NA), 5))
length(category)
Frequency1 <- c()
Grade1 <- c() 
for(i in 1:10){
  Frequency1 <- c(Frequency1, Category_rank$freq[i], NA)
  Grade1 <- c(Grade1, Category_rank$rank_within[i], NA)
}
length(Frequency1) 
length(Grade1)
Model <- rep(unique(Type_rank$Type),5)
length(Model)
Frequency2 <- c(Type_rank$freq[1:16], 0, Type_rank$freq[17:19])
length(Frequency2)
Grade2 <- c(Type_rank$rank_within[1:16],4,Type_rank$rank_within[17:19])
length(Grade2)
result_table <- data.frame(Rank = rank, 
                           Category = category,
                           Category_frequency = Frequency1,
                           Category_Grade = Grade1,
                           Model = Model,
                           Model_frequency = Frequency2,
                           Model_grade = Grade2)
result_table$Rank <- as.factor(result_table$Rank)

df <- sapply(result_table, as.character)
df[is.na(df)] <- " "
df

library(gridExtra)
pdf("Table.pdf", 10, 6)
grid.table(df)
dev.off()
## Comparison plot ##
require(ggplot2)

plot_type <- ggplot(result_table, aes(fill=Model, y=Model_frequency, x=Rank)) + 
  geom_bar(position="fill", stat="identity") +
  xlab("Rank") + ylab("Frequency") +
  theme_bw() + 
  theme(panel.grid.minor = element_blank()) +
  theme(aspect.ratio=0.8) +
  ggtitle("(a) Model type")
plot_type

plot_category <- ggplot(result_table, aes(fill=Category, y=Category_frequency, x=Rank)) + 
  geom_bar(position="fill", stat="identity") +
  xlab("Rank") + ylab("Frequency") +
  theme_bw() + 
  theme(panel.grid.minor = element_blank()) +
  theme(aspect.ratio=0.8) +
  ggtitle("(b) Model category")
plot_category

require(ggpubr)
  
figure <- ggarrange(plot_type, plot_category, 
          nrow = 2, align = c("v"))
figure
pdf("Model_comparison.pdf", 10, 14)
figure
dev.off()

print("Fished modelling and comparison!")
## Making jpeg plots of each subset ###
# plots <- list()
# for(i in 0:max(data$ID)){
#   subset <- subset(data, ID == i)
#   models <- subset(Finals, ID == i)
#   plots[[i+1]] = plotting(subset, models)
#   
#   jpeg(paste0("../plots/Subset",i,".jpg"), 600, 500)
#   plots[[i+1]]
#   dev.off()
#   
#   cat("Plot", i, "made!")
# }

