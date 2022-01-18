require(ggplot2)

mites <- read.csv("../data/bee_mites.csv")
head(mites)
str(mites)

model1 <- glm(Dead_mites ~ Concentration, data = mites, family = "poisson")
summary1 <- summary(model1)
summary1
anova(model1, test = "Chisq")

summary1$deviance/summary1$df.residual

par(mfrow = c(2,2))
plot(model1)

range(mites$Concentration)
new_data <- data.frame(Concentration = seq(from = 0, to = 2.16, length = 100))
predictions <- predict(model1, newdata = new_data, type = "link", se.fit = T)
new_data$pred <- predictions$fit
new_data$se <- predictions$se.fit
new_data$upperCI <- new_data$pred + (new_data$se * 1.96)
new_data$lowerCI <- new_data$pred - (new_data$se * 1.96)

ggplot(new_data, aes(x = Concentration, y = exp(pred))) +
  geom_line(col = "black") +
  geom_ribbon(aes(ymin = exp(lowerCI), ymax = exp(upperCI), alpha = 0.1), show.legend = F, fill = "grey") +
  geom_point(mites, mapping = aes(x = Concentration, y = Dead_mites), col = "blue") +
  labs(y = "Number of Dead Mites", x = "Concentration (g/l)") + 
  theme_classic()
