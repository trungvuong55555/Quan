
# it's look like summarize
# we must use library(dplyr) to use summarize

library(dplyr)
library(dslabs)
data(heights)
data(murders)

# the following code computes teh average and standard deviation for females:

s <- heights %>% filter(sex=="Female") %>% summarize(average=mean(height), standard_deviation = sd(height))

print(s)

# then we will access the components with accessor $

s$average
s$standard_deviation

# we can obtain these values with just one line using the quantile funtion

heights %>% filter( sex== "Female") %>% summarize(range= quantile(height, c(0,0.5,0.1))) # we will receive an error beneath

# we will learn how to deal with functions that return more than one value

murders <- murders %>% mutate(rate= total / population * 100000)

summarize( murders, mean(rate))

# but this is compution above the small states are given teh same weight as the large ones
# so murder rate is the total number of murders in teh US divided by the total US population.
# therefore after compute is correct computation is:

us_murder_rate <- murders %>% summarize(rate= sum(total)/sum(population)* 100000)

print(us_murder_rate)

# note summarize() can compute any summarates on vectors and returns a single value, but it cannot operate on functions that return multiple values.

