# about SAT testing

# corect 1 point. Other case, you will penaty -0.25 point 
# there are 44 setence with each question 5 answer choices

#What is the probability of guessing correctly for one question?
p <- 1/5

#What is the expected value of points for guessing on one question?

a <- 1
b <- -0.25
mu <- a*p +b*(1-p)

#What is the expected score of guessing on all 44 questions?
n <- 44
n*mu

#What is the standard error of guessing on all 44 questions?

sigma <- sqrt(n) * abs(b-a) * sqrt(p*(1-p))
sigma

#Use the Central Limit Theorem to determine the probability that a guessing student scores 8 points or higher on the test.

1-pnorm(8, mu, sigma)

#Set the seed to 21, then run a Monte Carlo simulation of 10,000 students guessing on the test.
#What is the probability that a guessing student scores 8 points or higher?
set.seed(x, sample.kind = "Rounding")

B <- 10000


S <- replicate(B,
               {
                 X<- sample(c(1,-0.25),n, replace= TRUE, prob= c(p,1-p))
                 sum(X)
               })

mean(S>=8)

#-----------------------
#2

#Suppose that the number of multiple choice options is 4 and that there is no penalty for guessing - that is, an incorrect question gives a score of 0.

#What is the expected value of the score when guessing on this new test?

p <- 1/4
a <- 1
b <- 0
n <- 44
mu <- n * a*p + b*(1-p)
mu

#What is the lowest p such that the probability of scoring over 35 exceeds 80%?

p <- seq(0.25, 0.95, 0.05)

p <- seq(0.25, 0.95, 0.05)
exp_val <- sapply(p, function(x){
  mu <- n * a*x + b*(1-x)
  sigma <- sqrt(n) * abs(b-a) * sqrt(x*(1-x))
  1-pnorm(35, mu, sigma)
})

min(p[which(exp_val > 0.8)])


