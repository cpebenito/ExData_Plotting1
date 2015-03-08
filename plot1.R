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
png(filename = "plot1.png", width = 480, height = 480)
hist(house072$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
