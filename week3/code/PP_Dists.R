rm(list=ls())

## Loading data ##
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(MyDF)
str(MyDF)
head(MyDF)

require(tidyverse)
dplyr::glimpse(MyDF)

## Making subsets by feeding type ##
levels(MyDF$Type.of.feeding.interaction)

insect <- subset(MyDF, Type.of.feeding.interaction == "insectivorous")
dim(insect)

pisci <- subset(MyDF, Type.of.feeding.interaction == "piscivorous")
dim(pisci)

plank <- subset(MyDF, Type.of.feeding.interaction == "planktivorous")
dim(plank)

preda <- subset(MyDF, Type.of.feeding.interaction == "predacious")
dim(preda)

pre_pis <- subset(MyDF, Type.of.feeding.interaction == "predacious/piscivorous")
dim(pre_pis)


## Pred_Subplots.pdf ##
# distribution of predator mass by feeding interaction type 
dev.off()

pdf("../results/Pred_Subplots.pdf", 10, 7)
par(mfcol=c(1,5))

par(mfg=c(1,1))
boxplot(log10(insect$Predator.mass), col="coral1",
        xlab="Insectivorous", ylab = "Log10(Predator Mass (g))", ylim=c(-5,7))

par(mfg=c(1,2))
boxplot(log10(pisci$Predator.mass), col="coral1",
        xlab="Piscivorous", yaxt="n", ylab="",  ylim=c(-5,7))

par(mfg=c(1,3))
boxplot(log10(plank$Predator.mass), col="coral1",
        xlab="Planktivorous", ylab = "", yaxt="n",  ylim=c(-5,7))

par(mfg=c(1,4))
boxplot(log10(preda$Predator.mass), col="coral1",
        xlab="Predacious", ylab = "", yaxt="n", ylim=c(-5,7))

par(mfg=c(1,5))
boxplot(log10(pre_pis$Predator.mass), col="coral1",
        xlab="Predacious/piscivorous", ylab = "", yaxt="n", ylim=c(-5,7))

mtext("Predator Mass by Feeding Interaction Type", 
      side=3, outer = T, line = -3, font=2)

dev.off()


## Prey_Subplots.pdf ##
# distribution of prey mass by feeding interaction type
dev.off()
pdf("../results/Prey_Subplots.pdf", 10, 7)

par(mfcol=c(1,5))

par(mfg=c(1,1))
boxplot(log10(insect$Prey.mass), col="steelblue1",
        xlab="Insectivorous", ylab = "Log10(Prey Mass (g))", ylim=c(-10,4))

par(mfg=c(1,2))
boxplot(log10(pisci$Prey.mass),col="steelblue1",
        xlab="Piscivorous", yaxt="n", ylab="",ylim=c(-10,4))

par(mfg=c(1,3))
boxplot(log10(plank$Prey.mass),col="steelblue1",
        xlab="Planktivorous", ylab = "", yaxt="n",  ylim=c(-10,4))

par(mfg=c(1,4))
boxplot(log10(preda$Prey.mass),col="steelblue1",
        xlab="Predacious", ylab = "", yaxt="n", ylim=c(-10,4))

par(mfg=c(1,5))
boxplot(log10(pre_pis$Predator.mass),col="steelblue1",
        xlab="Predacious/piscivorous", ylab = "", yaxt="n", ylim=c(-10,4))

mtext("Prey Mass by Feeding Interaction Type", side=3, outer = T, line = -3, font=2)

dev.off()


## SizeRatio_Subplots.pdf ##
# size ratio of prey mass over predator mass by feeding interaction type 
dev.off()
pdf("../results/SizeRatio_Subplots.pdf", 10, 7)

par(mfcol=c(1,5))

par(mfg=c(1,1))
boxplot(log10((insect$Prey.mass)/(insect$Predator.mass)), col="yellowgreen",
        xlab="Insectivorous", ylab = "Log10(Size ratio (g))",ylim=c(-8.5,2.2))

par(mfg=c(1,2))
boxplot(log10((pisci$Prey.mass)/(pisci$Predator.mass)), col="yellowgreen",
        xlab="Piscivorous", yaxt="n", ylab="", ylim=c(-8.5,2.2))

par(mfg=c(1,3))
boxplot(log10((plank$Prey.mass)/(plank$Predator.mass)), col="yellowgreen",
        xlab="Planktivorous", ylab = "", yaxt="n",  ylim=c(-8.5,2.2))

par(mfg=c(1,4))
boxplot(log10((preda$Prey.mass)/(preda$Predator.mass)), col="yellowgreen",
        xlab="Predacious", ylab = "", yaxt="n", ylim=c(-8.5,2.2))

par(mfg=c(1,5))
boxplot(log10((pre_pis$Prey.mass)/(pre_pis$Predator.mass)), col="yellowgreen",
        xlab="Predacious/piscivorous", ylab = "", yaxt="n", ylim=c(-8.5,2.2))

mtext("Size Ratio of Prey Mass over Predator Mass by Feeding Interaction Type", 
      side=3, outer = T, line = -3, font=2)

dev.off()


## PP_Results.csv ##
# mean and median log predator mass, prey mass, predator-prey size ratio by feeding type 
# Headers: Category, Feeding type, Mean, Median 

results <- matrix(NA, 15, 4)
colnames(results) <- c("Category", "Feeding_type", "Log10(Mean)", "Log10(Median)")
results

name <- c("Prey_mass(g)", "Predator_mass(g)", "Size_ratio")
results[,"Category"] <- rep(name, each=5) 
results

type <- levels(MyDF$Type.of.feeding.interaction)
results[,"Feeding_type"]<- rep(type,3)
results

preymean <- tapply(log10(MyDF$Prey.mass),MyDF$Type.of.feeding.interaction, mean)
preymedian <- tapply(log10(MyDF$Prey.mass),MyDF$Type.of.feeding.interaction, median)

predmean <- tapply(log10(MyDF$Predator.mass),MyDF$Type.of.feeding.interaction, mean)
predmedian <- tapply(log10(MyDF$Predator.mass),MyDF$Type.of.feeding.interaction, median)

sizemean <- tapply(log10(MyDF$Prey.mass/MyDF$Predator.mass),MyDF$Type.of.feeding.interaction, mean)
sizemedian <- tapply(log10(MyDF$Prey.mass/MyDF$Predator.mass),MyDF$Type.of.feeding.interaction, median)

results[1:5,"Log10(Mean)"] <- preymean 
results[1:5,"Log10(Median)"] <- preymedian

results[6:10,"Log10(Mean)"] <- predmean 
results[6:10,"Log10(Median)"] <- predmedian

results[11:15,"Log10(Mean)"] <- sizemean 
results[11:15,"Log10(Median)"] <- sizemedian

results
write.csv(results, "../results/PP_Results.csv", row.names=F)












