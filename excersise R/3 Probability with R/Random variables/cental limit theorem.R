# 14.7 Central Limit Theorem

# we previously ran this Monte Carlo simulation:

library(tidyverse)


n <- 1000
B <- 10000

roulette_winnings <- function(n)
{
  X <- sample(c(-1,1), n, replace= TRUE, prob= c(9/19,10/19))
  sum(X)
}

S <- replicate(B,roulette_winnings(n))

# the cental Limit theorem (CTL) tells us that the sum S is approxiamted by a normal distribution
# using the formulas abovbe, we know that the expected value and standard error are

n * (20-18)/38 

sqrt(n) * 2 * sqrt(90)/19 

# the theoretical values abouve match those obtained with the monte carlo simulation

mean(S)
sd(S)

# we can see, all of them the same result

#---------------
# 17.1 How large is large in the Central Limit Theorem?
#--------------

# 14.8 Statistical properties of averages

#--------------

# 14.9.1 misinterpreting law of averages



# using the CLT, we can skip the Monte Carlo simulation and insted compute the probability of the casino losing money using this appromximation:

mu <- n * (20-18)/38
se <-  sqrt(n) * 2 * sqrt(90)/19 
pnorm(0, mu, se)

# which also very good agreement with our Monte Carlo result:
mean(S<0)