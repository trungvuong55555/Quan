library(tidyverse)
library(dslabs)
data("polls_us_election_2016")

polls <- polls_us_election_2016 %>% 
  filter(state == "U.S." & enddate >= "2016-10-31" &
           (grade %in% c("A+","A","A-","B+") | is.na(grade)))

# we add a spread estimate:

polls <- polls %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

# the estimated spread is:

d_hat <- polls %>% 
  summarize(d_hat = sum(spread * samplesize) / sum(samplesize)) %>% 
  pull(d_hat)

# the standard error is

p_hat <- (d_hat+1)/2 
moe <- 1.96 * 2 * sqrt(p_hat * (1 - p_hat) / sum(polls$samplesize))
moe

# histogram

polls %>%
  ggplot(aes(spread)) +
  geom_histogram(color="black", binwidth = .01)

#--------------------------------

# pollster bias

polls %>% group_by(pollster) %>% summarize(n())

# fisrt this plot reveals an unpexpected result.

polls %>% group_by(pollster) %>% 
  filter(n() >= 6) %>%
  summarize(se = 2 * sqrt(p_hat * (1-p_hat) / median(samplesize)))

#------------------------------

#16.2 Data-driven models

# lest's collect therir last reported result before the eclection

one_poll_per_pollster <- polls %>% group_by(pollster) %>% 
  filter(enddate == max(enddate)) %>%
  ungroup()


qplot(spread, data = one_poll_per_pollster, binwidth = 0.01)
