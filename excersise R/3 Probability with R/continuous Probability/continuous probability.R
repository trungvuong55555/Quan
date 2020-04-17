# here we define the vector x to contain these heights
# fomular of cumulative distribution function(CDF) F(a)= Pr(x<=a)

library(tidyverse)
library(dslabs)
data(heights)


x <- heights %>%
  filter(sex=="Male")%>%
  pull(height)

# here we defined the empirical distribution function as:

F <- function(a) mean(x<=a)

# if i pick one of the male students at random
# what is the chance that he is taller than 70.5 inches
# using the CDF we obtain an answer by typing:

1-F(70)

# once a CDF is defind
# we can use this to compute the probability of any subset
# for instance,  the probability of a student being between height a and height b is

# F(b)-F(a)

# because we can compute the probability for any possible event this way
# the cumulative probability function defines the probability distribution for picking a height at random from our vector of heights x