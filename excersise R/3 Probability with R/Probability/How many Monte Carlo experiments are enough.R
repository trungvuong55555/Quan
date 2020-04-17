#The larger the number of Monte Carlo replicates  B , the more accurate the estimate.
#Determining the appropriate size for  B  can require advanced statistics.
#One practical approach is to try many sizes for  B  and look for sizes that provide stable estimates.

B <- 10^seq(1, 5, len = 100) 
compute_prob <- function(B, n = 22){    # function to run Monte Carlo simulation with each B
  same_day <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}
prob <- sapply(B, compute_prob)    # apply compute_prob to many values of B
plot(log10(B), prob, type = "1")    # plot a line graph of estimates 