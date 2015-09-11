## Script to create plot2 from data in Course Project 1 for Explortary
## Analysis in Coursera

library(dplyr)

# Read txt file
data<-read.table("./data/household_power_consumption.txt",stringsAsFactors=FALSE,sep=";",header=TRUE,colClasses="character")

# Convert columns beside Date and Time to numeric
for (i in 3:9){
data[[i]]<-as.numeric(data[[i]])
}

# Extract data by dates 1/2/2007 or 2/2/2007
data$Date<-as.Date(data$Date,"%d/%m/%Y")
sdata<-filter(data, Date=="2007-02-01"|Date=="2007-02-02")

#Convert Date in sdata back to characters
sdata$Date<-as.character(sdata$Date)

#Create new column DateTime consisting of time and date
msdata<-mutate(sdata, DateTime = paste(Date,Time))

#Convert new column DateTime to POSIXlt class
msdata$DateTime <- strptime(msdata$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Open graphic device for png
png(filename="plot2.png",width = 480, height = 480)

#plot graph using plot function
with(msdata,plot(DateTime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))

#close device
dev.off()



