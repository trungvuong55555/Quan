library(tidyverse)
library(dslabs)
data(polls_us_election_2016)

z <- qt(0.75, nrow(one_poll_per_pollster)-1)
one_poll_per_pollster %>%
  summarize(avg=mean(spread),moe=Z*sd(spread)/sqrt(length(spread)))%>%
  mutate(start=avg-moe, end = ang+moe)

# quantile from t - distribition versus normal distribution
qt(0.975,14)
qnorm(0.975)

help