# Exploratory Analysis, Course Project 1
#
# This R file produces the fourth plot in the assignment, plot4.png. It assumes the data is in the current folder, which the TA stated
# is an acceptable assuption.

# Assuming 64 bytes per row of data and 2.1 million rows:

memory <- 64 * 2.1
# The data will consume 135MB and figure a factor of 3 for indexes etc, then 500MB will be sufficient. 

# Read data file and convert Date variable for easier subsetting.
power <- read.table(file="household_power_consumption.txt",sep=';',header=TRUE)
power$Date <- as.Date(power$Date,format='%d/%m/%Y')

# Subset to dates of interest which, according to the project directions, are 2/1/2007 and 2/2/2007 and create a column of type POSIXlt date
# and convert the Sub_metering 1 and 2 to numerics. SWub_metereing_3 is already a numeric.
febPower <- power[(power$Date>='2007/02/01' & power$Date<='2007/02/2'),]
febPower$DateTime   <- as.POSIXct(paste(as.Date(febPower$Date, format="%d/%m/%Y"), febPower$Time, sep=" "))
febPower$Sub_metering_1 <- as.numeric(as.character(febPower$Sub_metering_1))
febPower$Sub_metering_2 <- as.numeric(as.character(febPower$Sub_metering_2))
febPower$Global_active_power <- as.numeric(as.character(febPower$Global_active_power))
febPower$Global_reactive_power <- as.numeric(as.character(febPower$Global_reactive_power))
febPower$Voltage <- as.numeric(as.character(febPower$Voltage))

# Set output device
png(filename='plot4.png', width = 480, height = 480,)

par(mfcol=c(2,2))
# plot 1
plot(febPower$DateTime , febPower$Global_active_power, type='l',
     ylab='Global Active Power (killowats)',xlab='')

#plot 2

lineNames <- names(febPower)[7:9]
plot(febPower$DateTime,febPower$Sub_metering_1,col='black',type='l',ylab='Energy sub metering',xlab='')

lines(febPower$DateTime,febPower$Sub_metering_2,col='red')
lines(febPower$DateTime,febPower$Sub_metering_3,col='blue')

legend("topright", legend = lineNames, col = c('black','red','blue'), lwd = 1, bty='n')

#Plot 3
plot(febPower$DateTime , febPower$Voltage, type='l',
     ylab='Voltage',xlab='datetime')

#Plot 4
plot(febPower$DateTime , febPower$Global_reactive_power, type='l',
     ylab='Global_reactive_power',xlab='datetime')

dev.off()
