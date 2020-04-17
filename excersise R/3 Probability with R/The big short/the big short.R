# CASE STUDY
#suppose your bank will give out 1,000 loans for $180,000 this year.
#Also, after adding up all costs, suppose your bank loses $200,000 per foreclosure.
#For simplicity, we assume this includes all operational costs.
#A sampling model for this scenario can be coded like this:

n <- 1000
loss_per_foreclosure <- -200000
p <- 0.02 
defaults <- sample( c(0,1), n, prob=c(1-p, p), replace = TRUE)
sum(defaults * loss_per_foreclosure)

# this is random variable
# so the answe allway diferent

# we can easily construct a Monte Carlo simulation to get an idea of the distribution of this random variable

B <- 10000
losses <- replicate(B, {
  defaults <- sample( c(0,1), n, prob=c(1-p, p), replace = TRUE) 
  sum(defaults * loss_per_foreclosure)
})

# we don't really need a Monte Carlo simulation though
# the CLT tells us that
# because our losses are a sum of independent draws

n*(p*loss_per_foreclosure + (1-p)*0)

sqrt(n)*abs(loss_per_foreclosure)*sqrt(p*(1-p))

#We can now set an interest rate to guarantee that, on average, we break even
#Basically, we need to add a quantity  x to each loan, which in this case are represented by draws,
#so that the expected value is 0.
#If we define  l to be the loss per foreclosure, we need:

#which implies  x is:
- loss_per_foreclosure*p/(1-p)

qnorm(0.01)

l <- loss_per_foreclosure
z <- qnorm(0.01)
x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))
x

loss_per_foreclosure*p + x*(1-p)

n*(loss_per_foreclosure*p + x*(1-p)) 

# we can run a MOnte Carlo simulation to double check our theoretical approximations:
B <- 100000
profit <- replicate(B, {
  draws <- sample( c(x, loss_per_foreclosure), n, 
                   prob=c(1-p, p), replace = TRUE) 
  sum(draws)
})
mean(profit)
#> [1] 2118548
mean(profit<0)
#> [1] 0.0124

#-----------------------------------
# THE BIG SHORT

#He claims that even if the default rate is twice as high, say 4%, if we set the rate just a bit higher than this value:
p <- 0.04
r <- (- loss_per_foreclosure*p/(1-p)) / 180000
r

#we will profit. At 5%, we are guaranteed a positive expected value of:
r <- 0.05
x <- r*180000
loss_per_foreclosure*p + x * (1-p)



