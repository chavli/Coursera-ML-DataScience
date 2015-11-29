
# load data
data = read.csv("raw_data/electrical.csv")

# create a new 'datetime' column
data$datetime = paste(data$Date, data$Time)
data$Date = as.Date(data$Date, format="%Y-%m-%d")
data$datetime = strptime(data$datetime, "%Y-%m-%d %H:%M:%S")

png(file="plot3.png", width=480, height=480, units="px")
with(subset(data, Date == "2007-02-01" | Date == "2007-02-02"), {
    plot(x=datetime, y=Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
    lines(x=datetime, y=Sub_metering_2, col="red")
    lines(x=datetime, y=Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
           , col=c("black", "red", "blue"), lty=1)
})
dev.off()