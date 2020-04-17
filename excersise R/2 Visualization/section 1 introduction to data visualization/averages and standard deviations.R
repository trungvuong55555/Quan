#Suppose you only have avg and stdev below, but no access to x, can you approximate the proportion of the data that is between 69 and 72 inches?
#Given a normal distribution with a mean mu and standard deviation sigma, you can calculate the proportion of observations less than or equal to a certain value with
#pnorm(value, mu, sigma). Notice that this is the CDF for the normal distribution. We will learn much more about pnorm later in the course series, but you can also learn more now with ?pnorm.

#code

library(dslabs)
data(heights)
x <- heights$height[heights$sex=="Male"]
avg <- mean(x)
stdev <- sd(x)
pnorm(72, avg, stdev) - pnorm(69, avg, stdev)#