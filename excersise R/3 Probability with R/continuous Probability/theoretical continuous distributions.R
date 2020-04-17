library(tidyverse)
library(dslabs)
data(heights)


x <- heights %>%
  filter(sex=="Male")%>%
  pull(height)
F <- function(a) mean(x<=a)

# the cumulative distribution for the normal distribution is defined by a mathermatical formula which in R can be obtained with the function pnorm()
#F(a)= pnorm(a, m ,s )

# examble, what is the probability that a randomly selected student is taller then 70 inches

m <- mean(x)
s <- sd(x)
1-pnorm(70.5, m, s)

# theoretucak dustruvytuibs as approxunations

# we don't defien exactily values as 69.685039
# we will define intervals between 69.5 and 70.5
# so the normal distribution is useful for approximating the proportion of students reporting values in intervals like

# example

mean(x<=68.5)-mean(x<=67.5)

mean(x<=69.5)-mean(x<=68.5)

mean(x<70.5)-mean(x<=69.5)

# Note how close we get with the normal approximation

pnorm(68.5,m,s)-pnorm(67.5,m,s)
pnorm(69.5,m,s)-pnorm(68.5,m,s)
pnorm(70.5,m,s)-pnorm(69.5,m,s)

# however, the approximation is not useful for other intervals
# notice how the approximation breaks down when we try to estimate:

mean(x<=70.9)-mean(x<=70.1)

# with

pnorm(70.9,m,s)-pnorm(70.1,m,s)

# in general, we call situtation discretization
# although the true height distribution is conntinuous
#the reported heights tend to be more common at discrete values. in this case, due to rounding
# as long as we are aware of how to deal with this reality, the normal approximation can still be a very useful tool

# 13.11.2 the probability density


