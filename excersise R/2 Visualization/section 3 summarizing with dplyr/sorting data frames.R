library(dplyr)
library(dslabs)
data(heights)
data(murders)

# we know about order and sort fuction, but for drdering entire tables, the dplyr function arranfe is useful

# for examole, here we order teh states by population size
murders %>% arrange(population) %>% head()


# with arrange we get to decide which column to sort by.
# to see the states by murders rate, from lowest to highest, we arrange by rate instead

murders %>% arrange(rate) %>% head()

# node: the default behavior is to order in aseding order

murders %>% 
  arrange(desc(rate)) 

#---------------------------------------
#nested SORTING
# if we order by a column with ties, we can use a second column to break the tie. similarly with a thired column

murders %>% arrange(region, rate) %>% head()

#-----------------------------------------
#THE TOP N

#insted function head() by top_n.

murders %>% top_n(5, rate)