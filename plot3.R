install.packages("dplyr")
library(dplyr)
housedata <-  read.table("household_power_consumption.txt",
                         header=TRUE,na.strings="?",sep=";")
house07 <- housedata[(housedata$Date == "1/2/2007" | housedata$Date == "2/2/2007"),]
NewDate <- data.frame(strptime(paste(house07$Date, house07$Time), 
                               format = "%d/%m/%Y %H:%M:%S"))
colnames(NewDate) <- c('DateTime')

house072 <- cbind(NewDate, house07)
house072 <- select(house072, -Date, -Time)
str(house072)
colSums(is.na(house072))
png(filename = "plot3.png", width = 480, height = 480)
plot(house072$DateTime, house072$Sub_metering_1, type = "n", xlab = "",
     ylab = "Energy sub metering" )

points(house072$DateTime, house072$Sub_metering_1, type = "l")

points(house072$DateTime, house072$Sub_metering_2, type = "l", col = "red")

points(house072$DateTime, house072$Sub_metering_3, type = "l", col = "blue")

legend("topright", lty = "solid" , col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3" ) )

dev.off()
