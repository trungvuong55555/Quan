# adistribution is a function or description that shows the possible values of a variable and how often those values occur.

# load the dataset
libarary(dslabs)
data(heights)

#make a table of category proportions

prop.table(table(heights$sex))
