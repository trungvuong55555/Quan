# basic data wrangling

#To change a data table by adding a new column, or changing an existing one, we use the mutate() function.
#To filter the data by subsetting rows, we use the function filter().
#To subset the data by selecting specific columns, we use the select() function.
#We can perform a series of operations by sending the results of one function to another function using the pipe operator, %>%.

# installing and loading the dplyr package
install.packages("dplyr")
library(dplyr)
# adding a column with mutate
library(dslabs)
data("murders")
murders <- mutate(murders, rate = total / population * 100000)

# subsetting with filter
filter(murders, rate <= 0.71)

# selecting columns with select
new_table <- select(murders, state, region, rate)

# using the pipe
murders %>% select(state, region, rate) %>% filter(rate <= 0.71)

#----------------------------
#We can use the data.frame() function to create data frames.
#By default, the data.frame() function turns characters into factors.  To avoid this, we utilize the stringsAsFactors argument and set it equal to false.

# creating a data frame with stringAsFactors = FALSE
grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"), 
                     exam_1 = c(95, 80, 90, 85), 
                     exam_2 = c(90, 85, 85, 90),
                     stringsAsFactors = FALSE)