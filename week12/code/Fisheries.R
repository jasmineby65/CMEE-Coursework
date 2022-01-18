require(ggplot2)
require(MASS)
require(ggpubr)

fish <- read.csv("../data/fisheries.csv", stringsAsFactors = T)
head(fish)
str(fish)

ggplot(fish, aes(x = MeanDepth, y = TotAbund)) +
  geom_point() +
  labs(x = "Mean Depth (km)", y= "Total Abundance") +
  theme_classic()


# Fitting a linear model #
linear_model <- lm(TotAbund ~ MeanDepth, data = fish)
par(mfrow = c(2,2))
plot(linear_model)


# Fitting a poisson GLM model #
poisson_model1 <- glm(formula = TotAbund ~ MeanDepth, family = "poisson", data = fish)
poisson_summary1 <- summary(poisson_model1)
poisson_summary1


# Diagnosing model #
plot(poisson_model1) # Showed there was large dispersion at higher end 

# checking for outliers 
sum(cooks.distance(poisson_model1)>1) 
# Cook's distance > 1 is used as an indicator for being an outlier
# sum = 29 so too many to be actual outliers 

# checking dispersion parameter
poisson_summary1$deviance/poisson_summary1$df.residual # shows overdispersion 


# Adding covariabe to model #
scatterplot <- ggplot(fish, aes(x = MeanDepth, y = TotAbund, color = factor(Period))) +
  geom_point() + 
  labs(x = "Mean Depth (km)", y = "Total Abundance") + 
  theme_classic() +
  scale_color_discrete(name = "Period", labels = c("1979-1989", "1997-2002"))

boxplot <- ggplot(fish, aes(x = factor(Period, labels = c("1979-1989", "1997-2002")), y = TotAbund)) +
  geom_boxplot() +
  theme_classic() + 
  labs(x = "Period", y = "Total Abundance") 

ggarrange(scatterplot, boxplot, labels = c("A", "B"), ncol=1, nrow=2)


poisson_model2 <- glm(TotAbund ~ MeanDepth*factor(Period), data = fish, family = "poisson")
poisson_summary2 <- summary(poisson_model2)
poisson_summary2

poisson_summary2$deviance/poisson_summary2$df.residual # slightly lower but still overdispersed


# Fitting a negative binomial model # 
nb_model1 <- glm.nb(TotAbund~MeanDepth*factor(Period), data = fish)
nb_summary1 <- summary(nb_model1)
nb_summary1

nb_summary1$deviance/nb_summary1$df.residual

anova(nb_model1, test = "Chisq")

# Removing interaction 
nb_model2 <- glm.nb(TotAbund ~ MeanDepth + factor(Period), data = fish)
nb_summary2 <- summary(nb_model2)
nb_summary2

nb_summary2$deviance/nb_summary2$df.residual

anova(nb_model2, test="Chisq")

plot(nb_model2)


# Plotting GLM #
# Unlike lm() that can be plotted exactly, GLM has to be plotted with predicted values
range(fish$MeanDepth) # find the range of MeanDepth

# Making uniformly distributed points for plotting 
period1 <- data.frame(MeanDepth = seq(from = 0.804, to = 4.865, length = 100), Period = "1")
period2 <- data.frame(MeanDepth = seq(from = 0.804, to = 4.865, length = 100), Period = "2")

period1_prediction <- predict(nb_model2, newdata = period1, type = "link", se.fit = TRUE)
# type = "link" will produce predictions on the same scale as the explanatory variables (log-linear scale in this case for poisson link)
# type = "response" will produce predictions on the same scale as the reponse variable (this will back-transform the predction i.e. revserse the log trasnformation)
# se.fit = TRUE will include prediciton of standard error not just point
# Need to use type="link" in this case because back-trasnformation of se will distort it so can only do it in the original scale 
period2_prediction <- predict(nb_model2, newdata = period2, type = "link", se.fit = TRUE)

# Making a dataframe
period1$pred <- period1_prediction$fit
period1$se <- period1_prediction$se.fit
period1$upperCI <- period1$pred + (period1$se*1.96)
period1$lowerCI <- period1$pred - (period1$se*1.96)

period2$pred <- period2_prediction$fit
period2$se <- period2_prediction$se.fit
period2$upperCI <- period2$pred + (period2$se*1.96)
period2$lowerCI <- period2$pred - (period2$se*1.96)

complete <- rbind(period1, period2)
head(complete)

# Plotting 
ggplot(complete, aes(x=MeanDepth, y=exp(pred))) + # exponential to back-transform to y
  geom_line(aes(colour = factor(Period))) + 
  geom_ribbon(aes(ymin = exp(lowerCI), ymax = exp(upperCI), fill = factor(Period), alpha = 0.3), show.legend = FALSE) +
  geom_point(fish, mapping = aes(x=MeanDepth, y=TotAbund, colour = factor(Period))) + 
  # Mapping = needed because geom_point is not using data from complete 
  labs(y="Total Abundance", x="Mean Depth (km)") + theme_classic() +
  scale_colour_discrete(name = "Period", labels = c("1979-1989", "1997-2002"))


# Alternative way of plotting #
require(interactions)
interact_plot(nb_model2, pred=MeanDepth, modx = Period, plot.points = T, data = fish)
# pred = predictor variable 
# modx = covariance
# plot.points = T adds scatter points