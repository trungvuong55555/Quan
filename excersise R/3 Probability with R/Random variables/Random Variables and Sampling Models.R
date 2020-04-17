# 14.1 Random variables

# we can easily generate random variables using some of the simple examples
# Example, define X to be 1 if a bead is blue and red otherwise:
beads <- rep(c("red", "blue"), times=c(2,3))
X <- ifelse(sample(beads,1)=="blue",1,0)

# Here X is radom variable:
#every time we select a new bead the outcome changes randomly
ifelse(sample(beads,1)=="blue",1,0)
# outcome is somttimes it's 1 and sometimes it's 0
#----------------------------------------------
#14.2 Sampling models

#COURSE
#A sampling model models the random behavior of a process as the sampling of draws from an urn.
#The probability distribution of a random variable is the probability of the observed value falling in any given interval.
#The average of many draws of a random variable is called its expected value.
#The standard deviation of many draws of a random variable is called its standard error.

# we define a random variable S
# that will represent the casino's total winnings.
# A roulette wheel has 18 red pockets, 18 black pockets and 2 green ones

color <- rep(c("Black", "Red", "Green"), c(18,18,2))

# the 1000 outcome from 1000 people play are independent draws from this urn.
#If red come up, casino losees a dollar, so we draw a -$1
# otherewise, the casino wins a dollar and we draw a $1.

n <- 1000
X<- sample(ifelse(color=="Red",-1,1),n ,replace = TRUE)
X[1:10]

#because we know the proportions of 1s and -1
#we can generate the draws with one line of code, without defining color
X<- sample(c(-1,1),n,replace = TRUE, prob = c(9/19,10/19))
# we call this a sampling mode since we are modeling the random behavior of roulette with the sampling of draws from an urn
# the total winnings S is simply the sum of these 1000 independent draws:
S <- sum(X)
S

#-------------------------------
#14.3 the probability distribution of a random variable

# we can estimate the distribution fuction for the random variable S by using a Monte Carlo simulation to generate many realization of the random variable
# we run the experiment of having 1000 people play roulette, over and over
# B = 10000 times
library(dslabs)

n<- 1000
B<- 10000

roulettle_winnings <- function(n)
{
  X <- sample(c(-1,1),n,replace= TRUE, prob = c(9/19,10/19))
  sum(X)
}

S <- replicate(B, roulettle_winnings(n))

# Now we can ask the following: in our simulations, how often did we get sums less than or equal to a
mean(S<=a)
# so we can easily answer the casino's question: how likely is it that we will lose money?

mean(S<0) # it quite low

# we use dminom() and pbinom() to compute the probabilities exactly
# for examble:
# Pr(S<0)= Pr((S+n)/2<(0+n)/2)
# and we can use pbinom to compute Pr(S<=0)

n<- 1000
pbinom(n/2, size=n, prob=10/19)

#because this is a discrete probability function
# to get Pr(S<0) rather than Pr(S<=0), we write

pbinom(n/2-1, size = n, prob = 10/19)

#-----------------------
#14.4 Distributions versus probability distributions

# you should read syllybus to understand
m <- sum(x)/length(x)
s <- sqrt(sum((x - m)^2) / length(x))
#--------------------------
#14.5 Notation for random variables
#--------------------------
#14.6 the expected value and standard error

B <- 10^6
x <- sample(c(-1,1), B, replace = TRUE, prob=c(9/19, 10/19))
mean(x)

2 * sqrt(90)/19

#---------
#14.6.1 Population SD versus the sample SD

library(dslabs)
x <- heights$height
m <- mean(x)
s <- sqrt(mean((x-m)^2))

identical(s, sd(x))
s-sd(x)

n <- length(x)
s-sd(x)*sqrt((n-1) / n)
sqrt(mean((x-m)^2))

#So be careful when using the sd function in R
#However, keep in mind that throughout the book we sometimes use the sd function when we really want the actual SD.

