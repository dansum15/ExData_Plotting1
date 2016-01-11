if(!file.exists("exdata-data-household_power_consumption.zip")) {
  zipfile <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",zipfile)
  file <- unzip(zipfile)
  unlink(zipfile)
}
data <- read.table(file, header=T, sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset.data <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]
subset.data$Global_active_power <- as.numeric(as.character(subset.data$Global_active_power))
subset.data$Global_reactive_power <- as.numeric(as.character(subset.data$Global_reactive_power))
subset.data$Voltage <- as.numeric(as.character(subset.data$Voltage))
subset.data <- transform(subset.data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
subset.data$Sub_metering_1 <- as.numeric(as.character(subset.data$Sub_metering_1))
subset.data$Sub_metering_2 <- as.numeric(as.character(subset.data$Sub_metering_2))
subset.data$Sub_metering_3 <- as.numeric(as.character(subset.data$Sub_metering_3))

plot(subset.data$timestamp,subset.data$Global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
