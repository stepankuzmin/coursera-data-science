data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = F)
data <- subset(data, as.Date(Date, format = "%d/%m/%Y") %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

png(file = "plot2.png")
plot(data$Global_active_power ~ data$datetime, type = "l", xlab = '', ylab = "Global Active Power (kilowatts)")
dev.off()