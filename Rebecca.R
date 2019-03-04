# Using R to produce beautiful plots using ggplot2 library to investigate
# relation between life expectancy and gdp per capital

# Loading packages
library(gapminder) #Contains data set to use
library(ggplot2)   #Plotting library

# Loading thr gapminder data set
data("gapminder")

# Looking at the few records of the data
head(gapminder)

# Checking for missing data values
anyNA(gapminder) #There no missing data values








 ####Plotting####
g <- ggplot(gapminder,aes(gdpPercap,lifeExp,color=continent,size=pop))+
  geom_point(alpha=0.5)
g

####Layers####
l <- ggplot(gapminder,aes(gdpPercap,lifeExp,size=pop))+
  geom_point(alpha=0.5,aes(color=continent))+
  geom_smooth(se=FALSE,method = "loess",color="black")
l

####Scales####
library(dplyr)
gap_2007 <- filter(gapminder,year==2007)

g7 <- ggplot(gap_2007,aes(gdpPercap,lifeExp,color=continent,size=pop))+
  geom_point(alpha=0.5)

g7
##log scale
g + scale_x_log10(breaks=c(1,10,100,1000,10000),limits=c(1,120000))
g7 + scale_x_log10()

##labels
g7 + labs(title="GDP Versus LIFEexpectancy",x="GDP In LOG10 scale",
         y="LifeExpectancy",size="Population",color="Continent")

##Scales
g7 <- ggplot(gap_2007,aes(gdpPercap,lifeExp,color=continent,size=pop))+
  geom_point(alpha=0.5)+
  scale_x_log10()+
 labs(x="GDP In log10 scale",
         y="LifeExpectancy",size="Population",color="Continent")+
  scale_size(range = c(0.1,10),breaks = 1000000*c(250,500,750,1000,1250),
                labels = c("250","500","750","1000","1250"))
g7

##Faceting
g7 + facet_wrap(~continent)

g7

##Themes
g7 <- g7 + geom_text(aes(gdpPercap,lifeExp,label=country),color="purple",
               data = filter(gap_2007,pop>1000000000 | country %in% c("Nigeria","United States")))+
  theme_classic()+
  theme(legend.position = "top",axis.line = element_line(color = "grey85"),
           axis.ticks = element_line(color = "grey85"),text = element_text(size = 15),
        plot.title = element_text(hjust = 0.5))+
  scale_size( range = c(0.1,10),guide = "none")+
  ggtitle("GDP per Capital Versus LifeExpectancy in 2007")

g7 + bbc_style()

ggsave("beautifulPlot.pdf",g7,width = 6,height = 4.5)
