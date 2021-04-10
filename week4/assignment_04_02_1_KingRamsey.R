# Assignment: ASSIGNMENT 4.2.1
# Name: King, Ramsey
# Date: 2021-04-10

## Load the ggplot2 package
library(ggplot2)
theme_set(theme_minimal())

## Set the working directory to the Week 4 Assignment directory
setwd("/run/user/1000/gvfs/smb-share:server=media.local,share=home/Drive/Bellevue University/DSC 520 - Statistics for Data Science/GitHub/dsc520/assignments/assignment04")

## Read the csv file into the variable scores
scores <- read.csv("Scores.csv")

## 1. What are the observational units in this study?
##  The observational units in this study are the students.

## 2. Identify the variables mentioned in the narrative paragraph and determine which are categorical and quantitative?
str(scores)
## Count and Score are quantitative and Section is categorical due to its factor assignment from R.

## 3. Create one variable to hold a subset of your data set that contains only the Regular Section and one variable for the Sports Section.
regularData <- subset(scores, scores$Section=="Regular")
sportsData <- subset(scores, scores$Section=="Sports")

## 4. Use the Plot function to plot each Sections scores and the number of students achieving that score. 
##    Use additional Plot Arguments to label the graph and give each axis an appropriate label. 
ggplot(regularData, aes(Score)) + geom_histogram(bins = 19, aes(y=..count..)) + ggtitle('Regular Section Scores')+ xlab('scores') + ylab('count') + xlim(100,500) + ylim(0,5)
ggplot(sportsData, aes(Score)) + geom_histogram(bins = 19, aes(y=..count..)) + ggtitle('Sports Section Scores') + xlim(100,500) + xlab('scores') + ylab('count') + ylim(0,5)

## 4a. Comparing and contrasting the point distributions between the two section, looking at both tendency and consistency: 
##     Can you say that one section tended to score more points than the other? Justify and explain your answer.
library(pastecs)
by(scores, scores$Section, stat.desc, basic=F, norm=T)
## In looking at the statistics given for the Regular section, we have an average (mean) score of 327.6.  The mean of the sports section
## is 307.3.  This suggests that the regular section tended to score more points than the sports section.

## 4b.  Did every student in one section score more points than every student in the other section? 
##      If not, explain what a statistical tendency means in this context.
sum(regularData$Score)
sum(sportsData$Score)

##  The sum of the regular section scores is 6225.  The sum of the sports section scores is 5840.  This suggests that those who take the
##  regular course is statistically more likely to score slightly better than those who take the sports section course.

## 4c.  What could be one additional variable that was not mentioned in the narrative 
##      that could be influencing the point distributions between the two sections?

##      The count variable has not been considered in this narrative.  I am unaware as to what the count variable signifies, but it may 
##      have an effect on the section scores.