#Use normal approximation to estimate the proportion of heights between 79 and 81 inches and save it in an object called approx.
#Report how many times bigger the actual proportion is compared to the approximation.

# code

library(dslabs)
data(heights)
x <- heights$height[heights$sex == "Male"]
avg <- mean(x)
stdev <- sd(x)
exact <- mean(x>79 & x<=81)
approx <- pnorm(81, avg, stdev) - pnorm(79, avg, stdev)
exact/approx


