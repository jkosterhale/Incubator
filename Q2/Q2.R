
library(plyr)

options(digits=10)

setwd("/Users/jorie/Google Drive/DataScience/IncubatorProject/Q2/")
#housingdata <-read.csv(paste("Historic_Secured_Property_Tax_Rolls.csv", sep =""))
 

#In order to avoid biasing the results towards properties which are assessed more often, 
#consider only the latest assessment for each property, unless otherwise specified.

#Grab only the latest data 
currentHousingData 


# ---- Question A --------
#using all the data (no dropping old assessments)
#What fraction of assessments are for properties of the most common class? 
#For now, consider all the assessments, even though some properties may be listed more than once.

classCount <- count(housingdata$Property.Class.Code.Definition)
classCountRatio <- max(classCount$freq)/sum(classCount$freq)  #0.4707253227


# ---- Question B ----- 
#using last assessment data
#Calculate the average improvement value (using only non-zero assessments) in each neighborhood. 
#What is the difference between the greatest and least average values?




# ---- 
#What is the median assessed improvement value, considering only non-zero assessments? 
#Consider only the latest assessment value for each property, which is uniquely identified by the "Block and Lot Number" column.

# ---- 
#We can use the property locations to estimate the areas of the neighborhoods. 
#Represent each as an ellipse with semi-axes given by a single standard deviation of the longitude and latitude. 
#What is the area, in square kilometers, of the largest neighborhood measured in this manner? Be sure to filter out invalid coordinates.

# ----
#Considering only properties with non-zero numbers of bedrooms and units, calculate the average number of bedrooms per unit in each zip code. 
#Use the ratio of the means instead of the mean of the ratio. What is this ratio in the zip code where it achieves its maximum?

# ----

#What is the yearly growth rate of Land Values over the years covered by this data? 
#Take a simplistic model: the value is given by P=P0ertP=P0ert, where tt is measured in years. 
#(A more complete model would give each property its own base price P(i)0P0(i).) Estimate rr over all assessments with a non-zero land value. (Hint: Consider using linear regression and logarithms.)

# ----

#What is the difference between the average number of units in buildings build in or after 1950, 
#and that for buildings built before 1950? Consider only buildings that have non-zero units reported, and 
# ignore buildings with obviously incorrect years. 
# To try to avoid the effect of improvements to buildings, use the earliest record for each property, not the latest.

# ---- 

# Estimate how built-up each zip code is by comparing the total property area to the total lot area. 
# What is the largest ratio of property area to surface area of all zip codes?
