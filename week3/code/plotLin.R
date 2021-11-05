rm(list=ls())

## Mathematical display ##
x <- seq(0, 100, by = 0.1)
y <- -4. + 0.25 * x +
  rnorm(length(x), mean = 0., sd = 2.5)

# and put them in a dataframe
my_data <- data.frame(x = x, y = y)

# perform a linear regression
my_lm <- summary(lm(y ~ x, data = my_data))
my_lm

# plot the data
dev.off()
p <-  ggplot(my_data, aes(x = x, y = y,
                          colour = abs(my_lm$residual))
) +
  geom_point() +
  scale_colour_gradient(low = "black", high = "red") +
  theme(legend.position = "none") +
  scale_x_continuous(
    expression(alpha^2 * pi / beta * sqrt(Theta)))
# scale_x_continuous() edits the x axis
# expression() is used for formatting text and print what's inside as symbols 

# add the regression line
p <- p + geom_abline( #abline makes a diagnol line, hline makes horizontal, vline makes vertical 
  intercept = my_lm$coefficients[1][1],
  slope = my_lm$coefficients[2][1],
  colour = "red")

# throw some math on the plot
p <- p + geom_text(aes(x = 60, y = 0,
                       label = "sqrt(alpha) * 2* pi"), 
                   parse = T, size = 6, 
                   colour = "blue")
# parse will format the text inside labels as symbols  
p

pdf("../results/MyLinReg.pdf")
p
dev.off()
