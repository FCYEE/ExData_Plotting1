## Script to create plot3 from data in Course Project 1 for Explortary
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
png(filename="plot4.png",width = 480, height = 480)

#set graphic parameters for 4 graphs, ordered by rows
par(mfrow=(c(2,2)))

#plot graph DateTime VS Global Active Power using plot function
with(msdata,plot(DateTime,Global_active_power,type="l",ylab="Global Active Power",xlab=""))

#plot graph DateTime VS Voltage using plot function
with(msdata,plot(DateTime, Voltage,type="l",xlab="datetime"))

#plot graph DateTime VS sub metering using plot function
with(msdata,plot(DateTime,Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
with(msdata,points(DateTime,Sub_metering_1,type="s"))
with(msdata,points(DateTime,Sub_metering_2,type="s",col="red"))
with(msdata,points(DateTime,Sub_metering_3,type="s",col="blue"))
legend("topright",lty=c(1,1,1), lwd=c(2,2,2),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"))

#plot graph DateTime VS Global Reactive Power using plot function
with(msdata,plot(DateTime,Global_reactive_power,type="l",xlab="datetime"))

#close device
dev.off()