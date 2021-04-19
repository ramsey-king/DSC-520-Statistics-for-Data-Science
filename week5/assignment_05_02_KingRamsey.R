# Assignment: ASSIGNMENT 5.2
# Name: King, Ramsey
# Date: 2021-04-17

## Load the ggplot2 package
library(ggplot2)
theme_set(theme_minimal())

## Set the working directory to the Week 4 Assignment directory
setwd("/run/user/1000/gvfs/smb-share:server=media.local,share=home/Drive/Bellevue University/DSC 520 - Statistics for Data Science/GitHub/dsc520/assignments/assignment04")

## Read the Excel file into the variable housing data
library(readxl)
housing_data <- read_excel('week-6-housing.xlsx')

library(dplyr)
## ********************************** Section A ***************************** ##
##  Using the dplyr package, use the 6 different operations to analyze/transform the data
##  Select -- selects the Sale Price and square_feet_total_living columns in order to make the price per square foot column
##  Mutate -- create a column that is the sale price per square foot
housing_data %>% select(`Sale Price`, square_feet_total_living) %>% mutate(Price_per_sqft=`Sale Price`/square_feet_total_living)


## group_by and summarize -- We are going to calculate the average and median sale prices by zip code:
housing_data %>% group_by(zip5) %>% summarize(AvgSalePrice=mean(`Sale Price`), MedianSalePrice=median(`Sale Price`))

## arrange -- We will sort the avg sale price by zip code from largest to smallest:
housing_data %>% group_by(zip5) %>% summarize(AvgSalePrice=mean(`Sale Price`), 
                                              MedianSalePrice=median(`Sale Price`)) %>% 
                                              arrange(desc(AvgSalePrice))

## Filter -- we want to select only the homes sold with the zip code 98074.
housing_data %>% filter(zip5 == 98074)

## ********************************** Section B ***************************** ##
## Using the purrr package, perform 2 functions on your dataset.  You could use zip_n,
## keep, discard, compact, etc.
library(purrr)

## Get the averages for all numeric columns in housing_data using map_dbl():
housing_data %>% map_dbl(mean)

## Search the data frame to see if some elements are of class character:
housing_data %>% some(is.character)

## ********************************** Section C ***************************** ##
## Use the cbind and rbind function on your data set
## We are going to create an ID_num and then bind it to the housing_data data frame using cbind
row_id <- c(1:12865)

housing_data_row_id <- cbind(housing_data, row_id)

# Now we will use rbind to add another entry to the housing_data_row_id dataset
# The new home entry will be a dataframe saved to the new_home variable
new_home <- data.frame(Sale_Date=as.Date(16862, origin="1970-01-01"), Sale_Price=1145999, sale_reason=1, sale_instrument=3,
                       sale_warning='56', sitetype='R1', addr_full='12440 166TH CT NW', zip5=98052,
                       ctyname='REDMOND', postalctyn='REDMOND', lon=-122.1170, lat=47.7110,
                       building_grade=9, square_feet_total_living=4600, bedrooms=3,
                       bath_full_count=3, bath_half_count=3, bath_3qtr_count=3, 
                       year_built=2015, year_renovated= 0, current_zoning='R4',
                       sq_ft_lot=54440, prop_type='R', present_use=2, row_id=12866)

# Here, we rename the column headers "Sale Price" and "Sale Date" to include an underscore
housing_data_row_id <- housing_data_row_id %>% rename(Sale_Price = `Sale Price` , Sale_Date = `Sale Date`)

# Then we use rbind to combine the two datasets together with the new entry from the new_home dataset:
housing_data_row_id_new_home <- rbind(housing_data_row_id, new_home)

## ********************************** Section D ***************************** ##
## Split a string, then concatenate the results back together

library(stringr)
# We will split the date string
dateList <- str_split(housing_data_row_id_new_home$Sale_Date, pattern = "-")

# Combine them into one matrix
dateMatrix <- data.frame(Reduce(rbind, dateList))

# Name the columns
names(dateMatrix) <- c("Year", "Month", "Date")

# Concatenate the results back together
dateListConcat <- sprintf("%s-%s-%s", dateMatrix$Year, dateMatrix$Month, dateMatrix$Date)
head(dateListConcat)
