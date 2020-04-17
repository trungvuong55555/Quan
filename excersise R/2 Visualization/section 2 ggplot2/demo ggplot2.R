# we will be creating plots using the ggplot 2 package.

library(dplyr)
library(ggplot2)
library(dslabs)

# we start by loading the dataset

data(murders)

# ggplot objects

p <- murders %>% ggplot()
class(p)
print(p)

#---------------------------
#geometries
# fomular : geom_X where X is teh name of the geometry 

#----------------------------
# aesthetic mappings 
#aesthetic describe how properties of the data connect with features of the graph, such as : an axis , size or color.
# we can drop teh "x=" and "y=" if we wanted to since tehse tare teh first and second expected arguments, as seen in the help page.

#---------------------------
#understand it is plus them each other

#---------------------------
#global versus local aesthetic mappings

# code exam

p <- murders %>% ggplot(aes(population/10^6, total, label=abb))
# and then we can simply write teh following code to produce the previous plot:

p +geom_point(size=3) + geom_text(nudge_x=1.5)

# we keep the size and nudge_x arguments in geom_point and geom_text, respectively, because we want to only increase the size of points and only nudge the labels

#----------------------------

#scales

#---------------------------

# labels and tiles
#node labels need inside aes beacuase once we set them outside it will have error due it's not find them

#--------------------------

# categories as colors

#----------------------------

# annotiation, shape and adj...

#----------------------------

# add-on packages
# fomular ds_theme_set()

#-----------------

# when we join them together. the fantastic will appare

#---------------

# quick plots with qplot
# this mean is make hurry function plot

#-------------------------

# grids of plots 
# it will transform one graph become another graph







