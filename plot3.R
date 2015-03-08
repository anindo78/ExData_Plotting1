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

png("plot3.png", width = 480, height = 480)

plot(subset_data$datetime,  
     subset_data$Sub_metering_1,
     type="l",
     ylab="Energy sub metering",
     xlab=" "
)

lines(subset_data$datetime,  
     subset_data$Sub_metering_2,
     type="l",
     col="red"
)


lines(subset_data$datetime,  
      subset_data$Sub_metering_3,
      type="l",
      col="blue"
)

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="o",
       lty=c(1,1,1),
       lwd=c(2,2,2),
       col=c("black", "red", "blue")
       
)   
      

dev.off()
