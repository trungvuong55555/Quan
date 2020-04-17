library(dplyr)
library(dslabs)
data(heights)
data(murders)

# coppy
murders <- murders %>% mutate(rate= total / population * 100000)

us_murder_rate <- murders %>% summarize(rate= sum(total)/sum(population)* 100000)

us_murder_rate

# a common operation in data exploration is to first split data into groups data into groups and then compute summarises for each group
# the group_by fuction helps us do this

heights %>% group_by(sex)

# there is only thing different appaere " groups : sex[2]"
# this is now a special data frame called a grouped data frame and cplyrfunctions

# then we summamarize the data after griouping, this is what happens:

heights %>% group_by(sex) %>% summarize(average= mean(height), standard_deviation = sd(height))
#compare with summary to recognize
s <- heights %>% filter(sex=="Female") %>% summarize(average=mean(height), standard_deviation = sd(height))

print(s)

# so it will return more values, so it difirent with summarize , because summarize will caculate sum all element of table. rest group by caculate each group of table

