plot2 <- function() {
     ## Exploratory Dat Analysis - Course Project 1
     ## Data: Individual household eletric power consumption from 2007-02-01 to 2007-02-02
     ## Plot 2: Global Active Power changes by date/time
     
     ## Library call
     library("sqldf")
     library(dplyr)
     
     ## Read data
     if (!file.exists("household_power_consumption.txt")){
          unzip("exdata_data_household_power_consumption.zip")
     }
     ds <- read.csv.sql("household_power_consumption.txt", 
                        sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", 
                        header = TRUE, sep = ";")
     ## Convert to tbl_df data frame
     energy <- tbl_df(ds)
     rm("ds")
     
     ## Add Date_time variable which concatenate date and time together
     energy <- mutate(energy, 
                      Date_time = as.POSIXct(strptime(paste(Date, Time, sep = " "), 
                                                      "%d/%m/%Y %H:%M:%S")))
     
     ## Create Plot2.png
     png(file = "plot2.png", width = 480, height = 480)
     plot(energy$Date_time, 
          energy$Global_active_power, 
          xlab = "", 
          ylab = "Global Active Power (kilowatts)", 
          typ = "l")
     dev.off()
}