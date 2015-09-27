data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = F)
data <- subset(data, as.Date(Date, format = "%d/%m/%Y") %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))

png(file = "plot1.png")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()