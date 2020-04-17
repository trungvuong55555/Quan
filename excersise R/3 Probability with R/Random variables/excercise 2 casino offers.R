#A casino offers a House Special bet on roulette, which is a bet on five pockets (00, 0, 1, 2, 3) out of 38 total pockets.
#The bet pays out 6 to 1
#In other words, a losing bet yields -$1 and a successful bet yields $6
# A gambler wants to know the chance of losing money if he places 500 bets on the roulette House Special.
#
n <- 500

p<- 5/38
q<- 1-p

a<-6
b<- -1
#What is the expected value of the payout for one bet?
mu<- a*p+b*q
mu
#What is the standard error of the payout for one bet?
sigma <- abs(a-b)*sqrt(p*q)
sigma


#What is the standard error of the average payout over 500 bets?
sigma/sqrt(n)

#What is the expected value of the sum of 500 bets?
n*mu
#What is the standard error of the sum of 500 bets?
sqrt(n)*sigma

#Use pnorm() to calculate the probability of losing money over 500 bets

pnorm(0, n*mu, sqrt(n)*sigma)