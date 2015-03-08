unzip("exdata-data-household_power_consumption.zip")

library(dplyr)
data <- read.table("household_power_consumption.txt", header=T, sep=";", 
                   na.string= "?")

data$datetime <- paste(data$Date, data$Time, sep=" ")
data$datetime <- strptime(data$datetime, format="%d/%m/%Y %H:%M:%S")
data$caldate <-  as.Date(data$datetime, format="%d/%m/%Y")
head(data)



subset_data <- subset(data[,-1:-2], caldate >= "2007-02-01" & 
                        caldate <= "2007-02-02")
rm(list=c("data"))

png("plot2.png", width = 480, height = 480)

plot(subset_data$datetime,  
     subset_data$Global_active_power,
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab=" "
      )
     

dev.off()

