# Read data and making the #1 plot.

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
plot1 <- function(){
	# To download data
	readData()
	#To unzip data
	unzipFile()
	
	# To read the data into a data frame
	interestingDate <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.string="?")	
	
	# To convert data in Date column to date type
	interestingDate$Date <- as.Date(interestingDate$Date, format="%d/%m/%Y")
	# Subset only data in 2007-02-01 and 2007-02-02
	df <- subset(interestingDate, Date == as.Date("2007-02-01",format="%Y-%m-%d") | Date == as.Date("2007-02-02",format="%Y-%m-%d"))

	# To plot the graph
	with(df, hist(Global_active_power, xlab="Global Active Power (kilowatts)",  main="Global Active Power", col="red"))

	# To print out into PNG file.
	dev.copy(png,"plot1.png", width=480, height=480)
	
	# To turn off the device
	dev.off()
}


