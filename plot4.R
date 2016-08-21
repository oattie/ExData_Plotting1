# Read data and making the #4 plot.

#Read data function
readData <- function(){
	# Download data
	download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest=paste0(getwd(),"/plotdata.zip"), method="auto")
}

# Unzip function
unzipFile <- function(){
	# Unzip data
	unzip("plotdata.zip")
}


#Main function
plot4 <- function(){
	# To download data
	readData()
	# To unzip data
	unzipFile()
	
	# To read the data into a data frame
	interestingDate <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.string="?")	
	
	# To convert data in Date column to date type
	interestingDate$Date <- as.Date(interestingDate$Date, format="%d/%m/%Y")
	# Subset only data in 2007-02-01 and 2007-02-02
	df <- subset(interestingDate, Date == as.Date("2007-02-01",format="%Y-%m-%d") | Date == as.Date("2007-02-02",format="%Y-%m-%d"))
	
	# To convert data in Date+Time columns to datetime type
	df$Time <- strptime(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")
	
	# Set up the canvas to prin 4 graphs
	par(mfrow=c(2,2))

	#plot 1
	with(df, plot(Time,Global_active_power, type="l", xlab="", ylab="Global Active Power"))

	#plot 2
	with(df, plot(Time,Voltage, type="l",ylab="Voltage", xlab="datetime"))
	
	#plot 3
	with(df, plot(Time,Sub_metering_1,type="l", xlab="", ylab="Energy Sub Metering"))
	with(df, lines(Time, Sub_metering_2, type="l", col="red"))
	with(df, lines(Time, Sub_metering_3, type="l", col="blue"))

	legend("topright", cex=0.9, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))

	#plot 4
	with(df, plot(Time,Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power"))
	
 	
	# To print out the device
	dev.copy(png,"plot4.png", width = 480, height = 480)
	# To turn of the device
	dev.off()
}


