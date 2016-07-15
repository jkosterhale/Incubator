
library(plyr)
library(dplyr)
library(tidyr)
library(data.table)

#correct sig fig
options(digits=10)

#grab the data
setwd("/Users/jorie/Google Drive/DataScience/IncubatorProject/Challange/Q2/data/")
housingdata <- fread("Historic_Secured_Property_Tax_Rolls.csv",header = T,)
housingdata <- read.csv("Historic_Secured_Property_Tax_Rolls.csv",header = T,)

#Grab only data from the latest assessment  
dt.housing <- data.table(housingdata, key="Block.and.Lot.Number")
#grab the subset .SD of data that has max fiscal year 
dt2.housing <- dt.housing[, .SD[Closed.Roll.Fiscal.Year %in% max(Closed.Roll.Fiscal.Year)], by=Block.and.Lot.Number] 
c.housing<- data.table(dt2.housing,key="Block.and.Lot.Number")

#check that we have the right number of plots 
length(unique(housingdata$Block.and.Lot.Number)) == dim(c.housing)[1]


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

as.numeric(c.housing$Closed.Roll.Assessed.Improvement.Value) -> c.housing$Closed.Roll.Assessed.Improvement.Value
c.housing.nonzero <- c.housing[,.SD[c.housing$Closed.Roll.Assessed.Improvement.Value!=0]]
means.neigh<- c.housing.nonzero[, mean(Closed.Roll.Assessed.Improvement.Value), by= Neighborhood.Code.Definition]
max(means.neigh$V1)-min(means.neigh$V1) #5,085,780.383

# ---- Question C -----
#What is the median assessed improvement value, considering only non-zero assessments? 
#Consider only the latest assessment value for each property, which is uniquely identified by the "Block and Lot Number" column.
median.house <- c.housing.nonzero[, median(Closed.Roll.Assessed.Improvement.Value,na.rm = T)]  # 209244.5


# ---- 
#We can use the property locations to estimate the areas of the neighborhoods. 
#Represent each as an ellipse with semi-axes given by a single standard deviation of the longitude and latitude. 
#What is the area, in square kilometers, of the largest neighborhood measured in this manner? Be sure to filter out invalid coordinates.

#Area = Pi * A * B ,

#get the lat and long out 
as.character(c.housing$Location) -> c.housing$Location
c.housing$Location <- gsub(c.housing$Location, pattern = "\\(",replacement = "")
c.housing$Location <- gsub(c.housing$Location, pattern = "\\)",replacement = "")
locData <- separate(data = c.housing, col = Location, into = c("Long","Lat"),sep = ",")
sdLong <- sd(locData$Long,na.rm = T)
sdLat <- sd(locData$Lat,na.rm = T)


#convert to kilometers 


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
