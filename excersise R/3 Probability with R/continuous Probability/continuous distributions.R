library(tidyverse)
library(dslabs)
library(ggplot2)
data(heights)

# the functions qnorm give us the quantiles

# so we can draw a distribution like this:

x <- seq(-4, 4, length.out = 100)
qplot(x, f, geom = "line", data = data.frame(x, f = dnorm(x)))