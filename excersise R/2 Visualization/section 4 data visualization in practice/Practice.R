library(tidyverse)
library(dslabs)
data(gapminder)

gapminder %>% as_tibble()


#------------
#Han Rosling's quiz

gapminder %>%
  filter(year==2015 & country %in% c("Sri Lanka","Turkey")) %>%
  select(country, infant_mortality)

#--------------
#9.2 Scatterplots

filter(gapminder,year==1962) %>%
  ggplot(aes(fertility, life_expectancy, color=continent)) +
  geom_point()

#------------------------------------
#9.3 Faceting

# we will you function facet_grid to compare
# the function expects teh row and colum variables to be separated by a ~

filter(gapminder, year%in%c(1962,2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point()+
  facet_grid(continent~year)

#this situtation, there is just one cariable and we use .

filter(gapminder, year%in%c(1962,2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point()+
  facet_grid(.~year)

#-----------
#9.3.1 facet_wrap

# this situtation consider for some years.
# we will use facet_warp

years <- c(1962,1980,1990,2000,2012)
continents <- c("Europe", "Asia")
gapminder %>%
  filter(year %in% years & continent %in% continents) %>%
  ggplot(aes(fertility,life_expectancy,col=continent))+
  geom_point()+
  facet_wrap(~year)

#-----------
#9.3.2 Fixed scales for better compraisons

filter(gapminder, year%in%c(1962,2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point()+
  facet_grid(.~year,scales="free")

#in this plot above, we have to pay special attention to the range to notice that the plot on the right has a larger life expectancy

#---------------------------
# 9.4 time series plots

gapminder %>%
  filter(country=="United States") %>%
  ggplot(aes(fertility,life_expectancy))+
  geom_line()

gapminder %>%
  filter(country%in%c("South Korea","Germany")) %>%
  ggplot(aes(fertility,life_expectancy))+
  geom_path()

# we want to assign each point to a group, one for each country

gapminder %>%
  filter(country%in%c("South Korea","Germany")& !is.na(fertility)) %>%
  ggplot(aes(year,life_expectancy, group=country, col= country))+
  geom_line()

#--------
# 9.4.1 Labels instead of legends
countries <- c("South Korea","Germany")
labels <- data.frame(country = countries, x = c(1975,1965), y = c(60,72))

gapminder %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(year, life_expectancy, col = country)) +
  geom_line() +
  geom_text(data = labels, aes(x, y, label = country), size = 5) +
  theme(legend.position = "none")
#---------------------------
#9.5 data transformations

gapminder <- gapminder %>% mutate(dollars_per_day=gdp/population/365)

# 9.5.1 log transformation
# here is a hisotgram of per day incomes from 1970
past_year <- 1970
gapminder %>%
  filter(year==past_year & ! is.na(gdp))%>%
  ggplot(aes(dollars_per_day))+
  geom_histogram(binwidth=1, col= "blue")
# here is the distribution if we apply a log base 2 tranform
past_year <- 1970
gapminder %>%
  filter(year==past_year & ! is.na(gdp))%>%
  ggplot(aes(log2(dollars_per_day)))+
  geom_histogram(binwidth=1, col= "blue")

# in a way this provides a close up of the mid to lower income  contries

#----------
#9.5.2 which base?
# which base 10 makes more sense, consider poplation sizes. A log base 10 is preferable since the range for these is:

gapminder %>%
  filter(year==past_year) %>%
  summarize(min=min(population), max=max(population))

# here is the histogram of the transformed values:
gapminder %>%
  filter(year==past_year) %>%
  ggplot(aes(log10(population)))+
  geom_histogram(binwidth = 0.5, col="black")

# in the above, we quickly see that country populations range between ten thousand and teh bilion
#---------------
#9.5.3 transform the values of the scale?
# if we log the data, we can more easily interpret intermediate values in the scale
# 1---x---10----100

#---------------------------
#9.6 visualizing multimodal distributions
#----------------
#9.7 comparing multiple distributions with boxplots and ridge plots
gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
  ggplot(aes(dollars_per_day, region)) +
  geom_point() +
  scale_x_continuous(trans = "log2")  

#--- error
gapminder <- gapminder %>% 
  mutate(group = case_when(
    region %in% c("Western Europe", "Northern Europe","Southern Europe", 
                  "Northern America", 
                  "Australia and New Zealand") ~ "West",
    region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
    region %in% c("Caribbean", "Central America", 
                  "South America") ~ "Latin America",
    continent == "Africa" & 
      region != "Northern Africa" ~ "Sub-Saharan",
    TRUE ~ "Others"))

gapminder <- gapminder %>% 
  mutate(group = factor(group, levels = c("Others", "Latin America", 
                                          "East Asia", "Sub-Saharan",
                                          "West")))
help('reorder')
help('xlab')
#----------------------------------
#9.7.1 Boxplots

p<- gapminder %>%
  filter(year==past_year & !is.na(gdp)) %>%
  ggplot(aes(group, dollars_per_day))+
  geom_boxplot()+
  scale_y_continuous(trans="log2")+
  xlab("")+
  theme(axis.text.x=element_text(angle=90,hjust=1))

p+geom_point(alpha=0.5)
#----------------
#9.7.2 ridge plots

library(ggridges)
p <- gapminder %>% 
  filter(year == past_year & !is.na(dollars_per_day)) %>%
  ggplot(aes(dollars_per_day, group)) + 
  scale_x_continuous(trans = "log2") 
p  + geom_density_ridges() 

#I didn't understand this problem because my computer didn't load this library
#-------------------
#9.7.3 Example: 1970: versus 2010 income distributions

present_year <- 2010

years <- c(past_year, present_year)

gapminder %>%
  filter(year %in% !is.na(gdp)) %>%
  mutate(west = ifelse(group=="West","West","Developing")) %>%
  ggplot(aes(dollars_per_day))+
  geom_histogram(binwidth=1, col="black")+
  scale_x_continuous(trans="log2")+
  facet_grid(year~west)

help('intersect')
# due after 1990s SoViet union break then now, there are more country that year(1970). So, we need to find these country

country_list_1 <- gapminder %>%
  filter(year==past_year & !is.na(dollars_per_day)) %>%
  pull(country)

country_list_2 <- gapminder %>%
  filter(year==present_year & !is.na(dollars_per_day)) %>%
  pull(country)

country_list <- intersect(country_list_1,country_list_2)
# to see which specific regions improve the most
# we can ramake the boxplots we made above
# but now adding teh year 2010 and then using facet to compare the two years


# Note that we have to convert the year columns from numeric to factor
gapminder %>% 
  filter(year %in% years & country %in% country_list) %>%
  mutate(year = factor(year)) %>%
  ggplot(aes(group, dollars_per_day, fill = year)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_y_continuous(trans = "log2") +
  xlab("") 

# let's start by nothing that density plots for income distribution in 1970 and 2010 deliver the message that the gap is closing
gapminder %>% 
  filter(year %in% years & country %in% country_list) %>%
  ggplot(aes(dollars_per_day)) +
  geom_density(fill = "red") + 
  scale_x_continuous(trans = "log2") + 
  facet_grid(. ~ year)
# but when overlay two densities
# the default is to have the area represented each distribution add up to 1,
# regardless of the size of each group

gapminder %>%
  filter(year%in% years & country %in% country_list) %>%
  mutate(group = ifelse(group == "West","West","Developing"))%>%
  ggplot(aes(dollars_per_day,fill = group))+
  scale_x_continuous(trans="log2")+
  geom_density(alpha=0.2) +
  facet_grid(year~.)

#---------------------------------------
#9.7.4 Accessing coputed variables

# we can now create the desired plot by simply changing the mapping in the previous code chunk. we will also expand the limits of the x_axis

p <- gapminder %>% 
  filter(year %in% years & country %in% country_list) %>%
  mutate(group = ifelse(group == "West", "West", "Developing")) %>%
  ggplot(aes(dollars_per_day, y = ..count.., fill = group)) +
  scale_x_continuous(trans = "log2", limit = c(0.125, 300))

p + geom_density(alpha = 0.2) + 
  facet_grid(year ~ .)

# if we want to densities to be smoother
# we use the bw argument 

p+ geom_density(alpha=0.2, bw=0.75)+
  facet_grid(year~.)

# to visualize if any of the groups defined above are driving this
# we can quickly make a ridge plot:
gapminder %>% 
  filter(year %in% years & !is.na(dollars_per_day)) %>%
  ggplot(aes(dollars_per_day, group)) + 
  scale_x_continuous(trans = "log2") + 
  geom_density_ridges(adjust = 1.5) +
  facet_grid(. ~ year)

# another way to achieve this is by stacking the densities on top of each other
gapminder %>% 
  filter(year %in% years & country %in% country_list) %>%
  group_by(year) %>%
  mutate(weight = population/sum(population)*2) %>%
  ungroup() %>%
  ggplot(aes(dollars_per_day, fill = group)) +
  scale_x_continuous(trans = "log2", limit = c(0.125, 300)) + 
  geom_density(alpha = 0.2, bw = 0.75, position = "stack") + 
  facet_grid(year ~ .) 

#---------------------------
#9.7.5 Weighted densities

# we can actually waight the smooth densities using the weight mapping argument. 

