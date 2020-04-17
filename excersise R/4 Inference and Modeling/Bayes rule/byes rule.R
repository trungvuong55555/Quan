library(tidyverse)
library(dslabs)
# there are 100000 people
# prob=0.00025 disease

prev <- 0.00025
N<- 100000

outcome <- sample(c("Disease","Healthy"),N, replace=TRUE, prob= c(prev, 1-prev))

# note that there are very few people with the disease

N_D <- sum(outcome=="Disease")
N_D

N_H <- sum(outcome=="Healthy")
N_H

# also, there are many without the disease
# which make it more probable that we will see some false positves given that the test is not perfect
# now each person gets the test, which is correct 99% of the time:

accuracy <- 0.99
test <- vector("character",N)

test[outcome=="Disease"] <- sample(c("+","-"),N_D, replace=TRUE, prob=c(accuracy,1-accuracy))
test[outcome=="Healthy"] <- sample(c("-","+"),N_H, replace=TRUE, prob=c(accuracy,1-accuracy))

# Because there are so many more controls than cases,
# even with a low false positive rate we get more control than cases in the group that tested positive

table(outcome, test)
