plot3 <- function() {
     ## Exploratory Dat Analysis - Course Project 1
     ## Data: Individual household eletric power consumption from 2007-02-01 to 2007-02-02
     ## Plot 3: Energy sub Metering (1, 2, 3) changes by date/time
     
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
     
     ## Create Plot3.png
     png(file = "plot3.png", width = 480, height = 480)
     plot(energy$Date_time, 
          energy$Sub_metering_1, 
          xlab = "", 
          ylab = "Energy sub metering", 
          typ = "l")
     lines(energy$Date_time, 
           energy$Sub_metering_2, 
           type="l", col = "red")
     lines(energy$Date_time, 
           energy$Sub_metering_3, 
           type="l", col = "blue")
     legend("topright", 
            lty = 1, 
            col = c("black", "blue", "red"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     dev.off()
}