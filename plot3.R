
#
# Coursera - Explore Data - Course Project 1 - Basic Plotting
#  
# December 11, 2015
#


# Get data locally
# setwd("D:/DataScience/Clean/Explore")

dataset_filename <- "exdata-data-household_power_consumption.zip"

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile=dataset_filename,method="auto", mode = "wb")
unzip (dataset_filename, exdir = "dataset")

# Examine data

#
# read the table where the Date is 2007-02-02
#

#  convert the date string to a date type
#    from http://stackoverflow.com/questions/13022299/specify-date-format-for-colclasses-argument-in-read-table-read-csv
#  name a new class
setClass('Date_ddmmyyyy')
# install.packages("sqldf")

library(sqldf)


#  define the class as converting a string in a specific format to a date
setAs("character","Date_ddmmyyyy", function(from) as.Date(from, format="%d/%m/%Y") )

tbl <- read.csv.sql("dataset\\household_power_consumption.txt" 
                    #  select based on character string format
                    , sql = "SELECT * FROM file WHERE Date IN ( '1/2/2007', '2/2/2007') "
                    , header = TRUE 
                    , sep = ";"
                    , colClasses = c("Date_ddmmyyyy", "character", "numeric",     "numeric",                 "numeric", "numeric", "numeric", "numeric", "numeric")
                    
)

# examine data
# View(tbl)

# plot 

 # Simple plot of power over time using plot.default
png("plot3.png", width = 480, height = 480, units = 'px');

plot(  x=tbl$Sub_metering_1, type = "l", main="", xaxt = "n",
         xlab="",
         ylab="Energy sub metering"
);
lines (x=tbl$Sub_metering_2, col="red");
lines (x=tbl$Sub_metering_3, col="blue");

# define 3 x-axis labels : 0, Middle, Last, label Thu, Fri, Sat
axis(1, at=c(0,length(tbl$Global_active_power)/2,length(tbl$Global_active_power)), 
     labels=c("Thu", "Fri", "Sat"));

dev.off();

