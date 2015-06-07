# Exploratory Analysis, Course Project 1
#
# This R file produces the second plot in the assignment, plot2.png It assumes the data is in the current folder, which the TA stated
# is an acceptable assuption.

# Assuming 64 bytes per row of data and 2.1 million rows,

memory <- 64 * 2.1
# The data will consume 135MB and figure a factor of 3 for indexes etc, then 500MB will be sufficient. 
power <- read.table(file="household_power_consumption.txt",sep=';',header=TRUE)
power$Date <- as.Date(power$Date,format='%d/%m/%Y')

# Subset to dates of interest which, according to the project directions, are 2/1/2007 and 2/2/2007 and create a column of type POSIXlt date
# and convert the GlobalPower to a numeric
febPower <- power[(power$Date>='2007/02/01' & power$Date<='2007/02/2'),]
febPower$DateTime   <- as.POSIXct(paste(as.Date(febPower$Date, format="%d/%m/%Y"), febPower$Time, sep=" "))
febPower$Global_active_power <- as.numeric(as.character(febPower$Global_active_power))

# Set output device
png(filename='plot2.png', width = 480, height = 480,)

# plot 
plot(febPower$DateTime , febPower$Global_active_power, type='l',
     ylab='Global Active Power (killowats)',xlab='')

dev.off()
