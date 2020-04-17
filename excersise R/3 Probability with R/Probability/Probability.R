# 13.1 Discrete probability

#--------------------------------

# 13.1.1 Relative frequency

#--------------

# 13.1.2 Notation

#--------------

# 13.1.3 probability distributions

#-------------------------------


# 13.2 Monte Carlo simulations for categorical data

# we demonstrate its use in the code below.
# First, we use the function rep() to generate the urn:

beads <- rep(c("red","blue"), times=c(2,3))
beads
sample(beads,1)
# and then use sample to pick a bead at random



# we want to repeat this experiment an infinite number of times
# but it is impossible to repeat forever.
# Instead, we repeat the experiment a large enough number of times to make the result parctically equivalent to repeating forever
# this is an example of Monte Carlo simulation

# to perform our first Monte Carlo simulation
# we use the replicate() function, which permits us to repeat the same task any number of time.
# Here, we repeat the random event B = 10000 times

B <- 10000
events <- replicate(B, sample(beads,1))
events

# we can now see if our definition actually is in agreement with this Monte Carlo simulation  approximation
# we can use table to see distribution

tab <- table(events)
tab

# and prop.table gives us the proportions:

prop.table(tab)
# fuction mean()to  a logical vector returns thr proprotion of elements that are TRUE
# It is very common to use the mean() function in this way calculate probabilities and we will do so throughout the course

# to find thr probability of drawing a blue bead at random, you can run

mean( beads=="blue")

#--------------------
#13.2.1 setting the random seed

#If you use R 3.6, you should always use the second form of set.seed() in this course series (outside of DataCamp assignments). Failure to do so may result in an otherwise correct answer being rejected by the grader. In most cases where a seed is required, you will be reminded of this fact.
set.seed(1986)#if you want to ensure that results are exactly the same every time you run them

#13.2.2 with and without replacement

# example, notice what happen when we ask to randomly select five beads

sample(beads,5)

# if we select six beads be selected, we get an error

sample(beads,6)

# instead for function replicate(), we will use:

events <- sample(beads,B,replace=TRUE)
prop.table(table(events))

#--------------------------------
# 13.3 independence

x <- sample(beads,5)

x[2:5]

#--------------------------------
# 13.4 conditional probabilities

#------------------------------
# 13.5 Addition and multiplication rules
#-------------
#13.5.1 Multiplication rule
#-------------
#13.5.2 Multiplication rule under independence

# 13.5.3 addition rule

#-----------------------------
#13.6 Combination and permutations 

# first, let's construct a deck of cards.
# we will expand.gird() and paste()
# paste() to create strings by joining smaller strings

number<- "Three"
suit<- "hearts"
paste(number, suit)

#paste() also works on pairs of vectors performing the operation element-wise:

paste(letters[1:5], as.character(1:5))

# the function expand.grid() give us all the combainations of entries of two vector.

expand.grid(pants=c("blue","Black"),shirt= c("white","Grey","plaid"))

# Here is how we generate a deck of card

suits <- c("Diamonds","Clubs","Hearts","Spades")
numbers <- c("Ace", "Deuce", "Three","Four", "Five", "Six", "Seven","Eight","Nine","Ten","Jack","Queen","King")

deck <- expand.grid(number=numbers, suit=suits )
deck <- paste(deck$number, deck$suit)

# with the deck constructed,
# we can double check that the probability of a King in the first card is 1/13 by computing the proportion of possible outcomes that satisfy our condition

kings <- paste("King",suits)
mean(deck%in%kings)

# to confirm by listing out all possible outcomes
# we can use the the permutations() function from the gtools package

library(gtools)
permutations(3,2)

# we can add a vector
# if we want to see five random seven digit phone numbers out of all possible phone numbers( without repeat)

all_phone_numbers <- permutations(10,7,v=0:9)
n <- nrow(all_phone_numbers)
index <- sample(n,5)
all_phone_numbers[index,]

# instead of using the numbers 1 through 10, it uses what we provided through v : the digits 0 through 9.

# to compute all possible way we can choose two cards when the order matters,we type:

hands <- permutations(52, 2, v=deck)

# this is a matrix with two columns and 2652 rows. 
# with a matrix we can get the first and second card like this:

first_card <-hands[,1]
second_card<- hands[,2]



# now the cases for which the first hadn was a King can be computed like this:

kings <- paste("King",suits)
sum(first_card %in% kings)

# to get the conditional probability, we compute what fraction of these have a king in the second card:
sum(first_card%in%kings & second_card %in%kings)/ sum(first_card%in%kings)

# i don't know how to explain

aces <- paste("Ace", suits)

facecard <- c("King", "Queen", "Jack", "Ten")
facecard <- expand.grid(number = facecard, suit = suits)
facecard <- paste(facecard$number, facecard$suit)

hands <- combinations(52, 2, v = deck)
mean(hands[,1] %in% aces & hands[,2] %in% facecard)

# we assume the Ace comes first
# this is only beacuse we know the way combination( ) enumerates possibilities and it will list this case first
mean((hands[,1] %in% aces & hands[,2] %in% facecard) |
       (hands[,2] %in% aces & hands[,1] %in% facecard))

set.seed(1986)

set.seed(1)
set.seed(1, sample.kind="Rounding") 
#----------------------------
# extend
# birthday problem

# checking for duplicated bdays in one 50 person group
n <- 50
bdays <- sample(1:365, n, replace = TRUE)    # generate n random birthdays
any(duplicated(bdays))    # check if any birthdays are duplicated

# Monte Carlo simulation with B=10000 replicates
B <- 10000
results <- replicate(B, {    # returns vector of B logical values
  bdays <- sample(1:365, n, replace = TRUE)
  any(duplicated(bdays))
})
mean(results)    # calculates proportion of groups with duplicated bdays

# example duplicated() : this fuction retruen TRUE or FALSE

duplicated(c(1,2,3,4,5,1,4,7))




