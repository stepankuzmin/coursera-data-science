data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = F)
data <- subset(data, as.Date(Date, format = "%d/%m/%Y") %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

png(file = "plot3.png")

plot(data$Sub_metering_1 ~ data$datetime, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$Sub_metering_2 ~ data$datetime, col = "red")
lines(data$Sub_metering_3 ~ data$datetime, col = "blue")
legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()