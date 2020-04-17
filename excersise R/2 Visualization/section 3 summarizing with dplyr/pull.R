library(dplyr)
library(dslabs)
data(heights)
data(murders)

# coppy
murders <- murders %>% mutate(rate= total / population * 100000)

us_murder_rate <- murders %>% summarize(rate= sum(total)/sum(population)* 100000)

us_murder_rate

# check type of us_murder_rate

class(us_murder_rate)

# as most dylyr functions, summarize always returns a data frame

# this have problem if we want to use functions that require a numberic value
# here we show a useful trick for accessing values stored in data when using pipes: when a data object is piped that object and its columns can be accessed using the PULL funtions

us_murder_rate %>% pull(rate)

us_murder_rate$rate

# to get a number form the origincal data table with one line of code we can type

us_murder_rate <- murders %>% summarize(rate=sum(total)/sum(population)*100000)%>% pull(rate)

us_murder_rate

# which is now a numeric:

class(us_murder_rate)
#---------------------------------------------
# additional

# the dot operator allows dplyr functions to return single  vector of numbers instead of only data frames
# us_murder_rate %>% .$rate is equivalent to us_murder_rate$rate

#------------------------
# extract the numeric US murder rate with the dot operator
us_murder_rate %>% .$rate
us_murder_rate <- murders %>%
  summarize(rate = sum(total) / sum(population * 100000)) %>%
  .$rate

class(us_murder_rate)

#NODE THAT COMMON REPLACEMENT FOR THE DOT OPERATOR IS THE PULL FUNTION. 
