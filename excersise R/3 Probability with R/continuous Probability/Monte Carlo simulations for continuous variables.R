library(tidyverse)
library(dslabs)
library(ggplot2)
data(heights)

#to generate normally distribution outcomes :
#use fuction rnorm() takes three argument: size, average and standard deviation and produces produces random numbers

n<- length(x)
m <- mean(x)
s <- sd(x)

simulated_heights<- rnorm(n,m,s)

hist(simulated_heights)
  

# example
# we pick 800 males at random
# what is the distrubution of the tallest person?
#How rare is a seven footer in a group of 800 males?

# so the monter Carlo simulaton helps us answer that question?

B <- 10000

tallest <- replicate(B, {
  simulated_data <- rnorm(800, m, s)
  max(simulated_data)
})

# having a seven footer is quite rare:

mean(tallest>= 7*12)

hist(tallest,col="grey")

# look at this, that does not look normal