# code monte carlo simulation of confidence intervals
p <- 0.45
N <- 1000



x <- sample(c(0,1), size=N, replace=TRUE, prob= c(1-p,p))
x_hat<- mean(x) # calculate X_hat
se_hat<- sqrt(x_hat*(1-x_hat)/N) # calculate SE_hat, SE of the mean of N observations
c(x_hat-1.96*se_hat, x_hat+1.96*se_hat) # build interval of 2*SE above and below mean

# this is the random variation

pnorm(1.96)-pnorm(-1.96)

# if we want to have a large probability, say 99%
# we need to multiply by whatever z satisfies the following

z<- qnorm(0.995)
pnorm(z)-pnorm(-z)

qnorm(0.975)

# code geom
library(tidyverse)
data("nhtemp")
data.frame(year = as.numeric(time(nhtemp)), temperature = as.numeric(nhtemp)) %>%
  ggplot(aes(year, temperature)) +
  geom_point() +
  geom_smooth() +
  ggtitle("Average Yearly Temperatures in New Haven")

#----------------------------------------
# A monte carlo simulation

N <- 1000
B <- 10000

inside <- replicate(B,
                    {
                      x <- sample(c(0,1), size=N, replace= TRUE, prob=c(1-p,p))
                      x_hat<- mean(x)
                      se_hat<- sqrt(x_hat * (1- x_hat)/N)
                      between(p, x_hat-1.96*se_hat, x_hat +1.96* se_hat)
                    }
  )

mean(inside)

help('qnorm')

pnorm(qnorm(0.995))
