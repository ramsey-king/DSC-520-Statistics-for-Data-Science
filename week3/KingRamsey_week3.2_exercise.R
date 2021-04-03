# Assignment: ASSIGNMENT 3.2
# Name: King, Ramsey
# Date: 2021-04-02

## Load the ggplot2 package
library(ggplot2)
theme_set(theme_minimal())
getwd()

## Set the working directory to the Week 3 Assignment directory
setwd("/run/user/1000/gvfs/smb-share:server=media.local,share=home/Drive/Bellevue University/DSC 520 - Statistics for Data Science/GitHub/dsc520/assignments/assignment03")

## Read the csv file into the variable am_com_survey
am_com_survey <- read.csv("acs-14-1yr-s0201.csv")

## Provide statistics about the csv file
str(am_com_survey)
nrow(am_com_survey)
ncol(am_com_survey)

## HS Degree is the number of people within county as a percentage that has a high school degree
## Create a Histogram of the HSDegree variable
the_plot <- ggplot(am_com_survey, aes(HSDegree)) + geom_histogram(bins = 8, aes(y=..density..)) + ggtitle('HS Degree Breakdown') + xlab('HS Degree Percentage') + ylab('Frequency')
the_plot

## iv.  Answer the following questions based on the Histogram produced:
##    1. Based on what you see in this histogram, is the data distribution unimodal?  Yes.  There is a peak in the range from 87.175 to 91.3375.
##    2. Is it approximately symmetrical?  No
##    3. Is it approximately bell-shaped?  One could argue yes.
##    4. Is it approximately normal?  No
##    5. If not normal, is the distribution skewed?  Yes.  If so, in which direction?  This distribution has a negative skew.
##    6. Include a normal curve to the Histogram you plotted.
the_plot + stat_function(fun = dnorm, color='blue', args = list(mean=mean(am_com_survey$HSDegree), sd = sd(am_com_survey$HSDegree)))

##    7.  Explain whether a normal distribution can accurately be used as a model for this data.
##
##        I do not think a normal distribution can be accurately used as a model for this data due to the definition of a normal distribution.
##        A normal distribution, according to 1.7.1 in Discovering Statistics Using R states that "the majority of scores lie around the center
##        of the distribution (so the largest bars on the histogram are all around the central value)."  In our plot, we see that the percentages
##        are skewed negatively, and since normal distributions do not contain any skew, this would not be an accurate normal distribution model.

##  v.  Create a Probability Plot of the HSDegree variable.
ggplot(am_com_survey, aes(sample = HSDegree)) + stat_qq() + stat_qq_line()

## vi. Answer the following questions based on the Probability Plot.
##    1. Based on what you see in this probability plot, is the distribution approximately normal? Explain how you know.
##
##        The distribution is not approximately normal because if the distribution were to be normal, it would follow the diagonal line
##        shown in the plot.  The diagonal line represents the normality of the theoretical sample (x-axis) vs the observed sample (HSDegree)
##        y-axis.
##
##    2. If not normal, is the distribution skewed?  If so, in which direction?  Explain how you know.
##
##        The distribution again is skewed to the left or negatively.  The 'tail' is longer on the left hand side of the probability plot, which
##        would indicate a negative skew.
##
## vii. Now that you have looked at this data visually for normality, you will now quantify normality with numbers using the stat.desc() 
##      function. Include a screen capture of the results produced.
library(pastecs)
options(scipen = 100)
options(digits = 3)
stat.desc(am_com_survey$HSDegree, norm = T)

## viii.  In several sentences provide an explanation of the result produced for skew, kurtosis, and z-scores. In addition, explain how 
##        a change in the sample size may change your explanation?
##    
##        Multiple resources (https://community.gooddata.com/maql-metrics-21/normality-testing-skewness-and-kurtosis-241, 
##        https://www.spcforexcel.com/knowledge/basic-statistics/are-skewness-and-kurtosis-useful-statistics#skewness,
##        and https://codeburst.io/2-important-statistics-terms-you-need-to-know-in-data-science-skewness-and-kurtosis-388fef94eeaa,
##        suggest that values less than -1 or greater than 1 denote a highly skewed distribution.  In this case, we have
##        a skewness value of -1.67476661046, so this variable is highly skewed.
##
##        For kurtosis, we have a value of 4.352.  
##        According to https://www.statisticshowto.com/probability-and-statistics/statistics-definitions/kurtosis-leptokurtic-platykurtic/,
##        "the standard normal distribution has a kurtosis of 3."  In our case, the HSDegree distribution is leptokurtic due to its value
##        being greater than 3.
##
##        According to https://scientificallysound.org/2018/06/14/test-normal-distribution-r-part-2/, "if skew.2SE and kurt.2SE are greater
##        than 1, we can conclude that there is only a 5% chance . . . of obtaining values of skew and kurtosis as or more extreme than 
##        this by chance."  Due to our sample size (n = 136), we would need to consider 2.58SE instead of 2SE.  If our sample size was 
##        greater than 200 observations or more, then visual insppection and actual values of skew and kurtosis would need to be considered.
                         