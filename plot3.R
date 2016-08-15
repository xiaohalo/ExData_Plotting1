# read in a part of the data, which include data
# from the dates 2007-02-01 and 2007-02-02
initial <- read.table("household_power_consumption.txt", 
                   sep=";", header= TRUE, skip=0, nrows=10)

classes <- sapply(initial, class)

powerData <- read.table("household_power_consumption.txt", 
                      sep=";", colClasses = classes, 
                      col.names = colnames(initial),
                      skip=66600, nrows=3000)
rm(initial, classes)

# extract data from dates "1/2/2007" and "2/2/2007"
powerData <- subset(powerData, Date=="1/2/2007" | Date=="2/2/2007")

powerData$Date <- as.character(powerData$Date)

row.names(powerData) <- 1:dim(powerData)[1]


powerData$dateTime <- with(powerData,
                       paste(as.character(Date), as.character(Time), sep=":"))

powerData$dateTime <- strptime(powerData$dateTime, "%d/%m/%Y:%T")

# op <- par(no.readonly = TRUE)
png("plot3.png", width=480, height=480, units = "px")

with(powerData, plot(dateTime, Sub_metering_1, type="l", lwd=2,
     xlab="", ylab="Energy sub metering"))

with(powerData, lines(dateTime, Sub_metering_2, col="red", lwd=2))

with(powerData, lines(dateTime, Sub_metering_3, col="blue", lwd=2))

legend("topright", lty=c(1, 1, 1), lwd = c(2, 2, 2),
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

# par(op)