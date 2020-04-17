library(tidyverse)
library(dslabs)

d <- 0.039
Ns <- c(1298, 533, 1342, 897, 774, 254, 812, 324, 1291, 1056, 2172, 516)
p <- (d+1)/2

polls <- map_df(Ns, function(N)
  {
    x <- sample(c(0,1), size= N, replace = TRUE, prob= c(1-p,p))
    x_hat <- mean(x)
    se_hat <- sqrt(x_hat*(1-x_hat)/N)
    list(estimate=2*x_hat-1,
         low=2*(x_hat-1.96*se_hat)/N,
         high=2*(x_hat+1.96*se_hat)/N,
         sample_size=N)
    
}) %>%
  mutate(poll=seq_along(Ns))

sum(polls$sample_size)

#let's call it d, with a weighted average in the following way

d_hat <- polls %>% 
  summarize(avg = sum(estimate*sample_size) / sum(sample_size)) %>% 
  pull(avg)