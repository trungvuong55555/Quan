
#The ACT is a standardized college admissions test used in the United States
#----------------------------------------

#PART 1 ACT scores

# avg=20.9
#sd=5.7

# generate a normal distribution of 10000 test
# set the seed to 16

set.seed(16, sample.kind = "Rounding")
act_scores <- rnorm(10000, 20.9, 5.7)

#What is the mean of act_scores?
mean(act_scores)
#What is the standard deviation of act_scores?
sd(act_scores)
#A perfect score is 36 or greater (the maximum reported score is 36).
#In act_scores, how many perfect scores are there out of 10,000 simulated tests?

# count one values we need to do this way:
sum(act_scores >= 36)

#In act_scores, what is the probability of an ACT score greater than 30?
sum(act_scores>30)

#In act_scores, what is the probability of an ACT score less than or equal to 10?
mean(act_scores<=10)

# make density plot 
library(ggplot2)
library(tidyverse)

x<- 1:36

f_x <- dnorm(x, 20.9, 5.7)


data.frame(x,f_x) %>%
  ggplot(aes(x,f_x,color="red"))+
  geom_line()

#-----------------------------------------------------

# PART 2 convert raw ACT scores to Z-scores 

#What is the probability of a Z-score greater than 2 (2 standard deviations above the mean)?

z_scores <- (act_scores - mean(act_scores))/sd(act_scores)
mean(z_scores > 2)

#What ACT score value corresponds to 2 standard deviations above the mean (Z = 2)?

2*sd(act_scores) + mean(act_scores)

#What is the 97.5th percentile of act_scores?

qnorm(.975, mean(act_scores), sd(act_scores))

#What is the minimum integer score such that the probability of that score or lower is at least .95?
cdf <- sapply(1:36, function (x){
  mean(act_scores <= x)
})
min(which(cdf >= .95))

#What is the expected 95th percentile of ACT scores?
cdf <- sapply(1:36, function (x){
  mean(act_scores <=x)
})
qnorm(.95, 20.9, 5.7)
min(which(cdf >= .95))
#In what percentile is a score of 26?
p <- seq(0.01, 0.99, 0.01)
sample_quantiles <- quantile(act_scores,p)

names(sample_quantiles[max(which(sample_quantiles < 26))])
