library(tidyverse)
library(dslabs)
data(polls_us_election_2016)

polls <- polls_us_election_2016 %>% 
  filter(state == "U.S." & enddate >= "2016-10-31" &
           (grade %in% c("A+","A","A-","B+") | is.na(grade)))

polls <- polls %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

one_poll_per_pollster <- polls %>% group_by(pollster) %>% 
  filter(enddate == max(enddate)) %>%
  ungroup()

results <- one_poll_per_pollster %>% 
  summarize(avg = mean(spread), se = sd(spread)/sqrt(length(spread))) %>% 
  mutate(start = avg - 1.96*se, end = avg + 1.96*se) 

# observed poll data:

mu <- 0
tau <- 0.035
sigma <- results$se
Y <- results$avg
B <- sigma^2 / (sigma^2 + tau^2)

posterior_mean <- B*mu + (1-B)*Y
posterior_se <- sqrt( 1/ (1/sigma^2 + 1/tau^2))

posterior_mean
posterior_se

# we have a credible interval of:

posterior_mean + c(-1.96, 1.96)*posterior_se

# Pr(d>0|X_hat) can be computed like this

1 - pnorm(0, posterior_mean, posterior_se)

#--------------------------------------
# Mathematical representations of models

set.seed(3)
J <- 6
N <- 2000
d <- .021
p <- (d + 1)/2


X <- d + rnorm(J, 0, 2 * sqrt(p * (1 - p) / N))

help('rnorm')

# if we apply the same mode,l we write

I <- 5
J <- 6
N <- 2000
X <- sapply(1:I, function(i){
  d + rnorm(J, 0, 2 * sqrt(p * (1 - p) / N))
})

# the model above does not account for pollster-to-pollster variability
# we will use hi to represent the house effect of the i-th pollster

I <- 5
J <- 6
N <- 2000
d <- .021
p <- (d + 1) / 2
h <- rnorm(I, 0, 0.025)
X <- sapply(1:I, function(i){
  d + h[i] + rnorm(J, 0, 2 * sqrt(p * (1 - p) / N))
})

# add b

mu <- 0
tau <- 0.035
sigma <- sqrt(results$se^2 + .025^2)
Y <- results$avg
B <- sigma^2 / (sigma^2 + tau^2)

posterior_mean <- B*mu + (1-B)*Y
posterior_se <- sqrt( 1/ (1/sigma^2 + 1/tau^2))

1 - pnorm(0, posterior_mean, posterior_se)

# 16.8.4 Predicting the electoral college
# here are the top 5 states ranked by electoral votes in 2016

results_us_election_2016 %>% top_n(5, electoral_votes)

results <- polls_us_election_2016 %>%
  filter(state!="U.S." & 
           !str_detect(state, "CD") & 
           enddate >="2016-10-31" & 
           (grade %in% c("A+","A","A-","B+") | is.na(grade))) %>%
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100) %>%
  group_by(state) %>%
  summarize(avg = mean(spread), sd = sd(spread), n = n()) %>%
  mutate(state = as.character(state))

# here are the five closest races according to the polls

results %>% arrange(abs(avg))

results <- left_join(results, results_us_election_2016,by ="state")

# notice that some states have no polls because the winner is pretty much known

results_us_election_2016 %>%
  filter(!state %in% results$state)%>%
  pull(state)

results <- results %>%
  mutate(sd = ifelse(is.na(sd), median(results$sd, na.rm = TRUE), sd))

help('is.na')

B <- 10000
mu <- 0
tau <- 0.02
clinton_EV <- replicate(B, {
  results %>% mutate(sigma = sd/sqrt(n), 
                     B = sigma^2 / (sigma^2 + tau^2),
                     posterior_mean = B * mu + (1 - B) * avg,
                     posterior_se = sqrt(1 / (1/sigma^2 + 1/tau^2)),
                     result = rnorm(length(posterior_mean), 
                                    posterior_mean, posterior_se),
                     clinton = ifelse(result > 0, electoral_votes, 0)) %>% 
    summarize(clinton = sum(clinton)) %>% 
    pull(clinton) + 7
})

mean(clinton_EV > 269)

# ad with bias term

tau <- 0.02
bias_sd <- 0.03
clinton_EV_2 <- replicate(1000, {
  results %>% mutate(sigma = sqrt(sd^2/n  + bias_sd^2),  
                     B = sigma^2 / (sigma^2 + tau^2),
                     posterior_mean = B*mu + (1-B)*avg,
                     posterior_se = sqrt( 1/ (1/sigma^2 + 1/tau^2)),
                     result = rnorm(length(posterior_mean), 
                                    posterior_mean, posterior_se),
                     clinton = ifelse(result>0, electoral_votes, 0)) %>% 
    summarize(clinton = sum(clinton) + 7) %>% 
    pull(clinton)
})
mean(clinton_EV_2 > 269)
#-------------------------------------
# Forecasting

one_pollster <- polls_us_election_2016 %>%
  filter(pollster== "Ipsos" & state == "U.S.")%>%
  mutate(spread=rawpoll_clinton/100 - rawpoll_trump/100)

#
se <- one_pollster %>% 
  summarize(empirical = sd(spread), 
          theoretical = 2 * sqrt(mean(spread) * (1 - mean(spread)) /
                                   min(samplesize)))




