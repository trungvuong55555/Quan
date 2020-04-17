#library(tidyverse)
#library(gtools)

#entree_choice <-function(x)
#{
  #x*nrow(combinations(6,2))*3
#}

#combos <- sapply(1:12, entree_choice)

#data.frame(entrees=1:12, combos) %>%
  #filter(combos>365) %>%
  #min(.$entress)

# excersice

# at restaurant, the manager want to customer have more 365 meal for year.
# therefore, on the menu have three type entree, side and drink
# the basic menu have one of entree ( there are 6 entrees), one of two sides ( there are x sides, x mean the value need find), one of three drinks ( there are 3 drink)
# find x min?

library(tidyverse)
library(gtools)

sides_choice <- function(x)
{
  6*nrow(combinations(x,2))*3
}

combos <- sapply(2:12, sides_choice)

data.frame(entree= 2:12, combo= combos) %>%
  filter(combo>365) %>%
  pull(entree)