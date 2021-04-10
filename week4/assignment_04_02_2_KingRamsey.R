# Assignment: ASSIGNMENT 4.2.2
# Name: King, Ramsey
# Date: 2021-04-10

## Load the ggplot2 package
library(ggplot2)
theme_set(theme_minimal())

## Set the working directory to the Week 4 Assignment directory
setwd("/run/user/1000/gvfs/smb-share:server=media.local,share=home/Drive/Bellevue University/DSC 520 - Statistics for Data Science/GitHub/dsc520/assignments/assignment04")

## Read the Excel file into the variable housing data
library(readxl)
housing_data <- read_excel('week-6-housing.xlsx')
head(housing_data)
## a. Use the apply function on a variable in your dataset
##    For my example, I will get the average sale price of all the properties in the housing data set.
apply(housing_data[,c(2)], 2, mean)

## b. Use the aggregate function on a variable in your dataset
##    For my example, I will get the average sale price of all the properties based on their building_grade
##    Note:  backticks (above the tilde on the keyboard) had to be used to deal with the space in the column
##    name Sale Price.
aggregate(`Sale Price` ~ building_grade, housing_data, mean)

## c. Use the plyr function on a variable in your dataset – more specifically, I want to see you split 
##    some data, perform a modification to the data, and then bring it back together
## load the plyr package
library(plyr)
##  Add Redmond as the city name to each row with the 98052 zip code
housing_data$ctyname[housing_data$zip5 == 98052] <- "REDMOND"
##  create a subset of the housing_data with only the 98052 zip code
zip98052 <- subset(housing_data, housing_data$zip5 == 98052)
##  make sure that all the city names have been filled in with Redmond
any(is.na(zip98052$ctyname))
##  bring the 98052 zip code with the city name Redmond back to the housing_data data frame
housing_data

## d.  Check distributions of the data
library(scales)
ggplot(housing_data, aes(`Sale Price`)) + geom_histogram(bins = 15, aes(y=..count..)) + ggtitle('Sales Price') + xlab('Sales Price') + ylab('count') + scale_x_continuous(labels = comma)
ggplot(housing_data, aes(`Sale Price`)) + geom_histogram(bins = 15, aes(y=..density..)) + ggtitle('Sales Price') + xlab('Sales Price') + ylab('density') + scale_x_continuous(labels = comma)

## e.  Identify if there are any outliers
##      To identify outliers, we will define outliiers as Sales Prices that are below the 2.5 percentile and above the 97.5 percentile.  
##  The lower_bound variable gives us the sales price at or below the 2.5 percentile
lower_bound <- quantile(housing_data$`Sale Price`, 0.025)
##  The count function tells us how many sales prices were at or below the 2.5 percentile.
count(housing_data$`Sale Price`< lower_bound)
##  The upper_bound variable gives us the sales prices at or above the 97.5 percentile.
upper_bound <- quantile(housing_data$`Sale Price`, 0.975)
##  The count function tells us how many sales prices were at or above the 97.5 percentile.
count(housing_data$`Sale Price` > upper_bound)

## Create at least 2 new variables.
##  The first variable created will be the total_sqft which will be the square_feet_total_living + sq_ft_lot
housing_data$total_sqft <- housing_data$sq_ft_lot+housing_data$square_feet_total_living

##  The second variable created will be the total_bathroom_count which will add all the bathrooms together
housing_data$total_bathroom_count <- housing_data$bath_full_count + (housing_data$bath_half_count*0.5) + (housing_data$bath_3qtr_count *0.75)  
housing_data