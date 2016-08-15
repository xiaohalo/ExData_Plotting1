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

# concatenate date and time to a new variable dateTime
powerData$dateTime <- with(powerData,
                       paste(as.character(Date), as.character(Time), sep=":"))

# convert dateTime to date class
powerData$dateTime <- strptime(powerData$dateTime, "%d/%m/%Y:%T")

# op <- par(no.readonly = TRUE)
# open a png device
png("plot1.png", width=480, height=480, units = "px")

hist(powerData$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowalts)",
     ylab = "Frequency",
     main = "Global Active Power")

dev.off()

# par(op)