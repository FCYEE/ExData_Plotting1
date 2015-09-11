## Script to create plot1 from data in Course Project 1 for Explortary
## Analysis in Coursera

data<-read.table("./data/household_power_consumption.txt",stringsAsFactors=FALSE,sep=";",header=TRUE)
data[[1]]<-as.Date(data[[1]],"%d/%m/%Y")

for (i in 3:9){
data[[i]]<-as.numeric(data[[i]])
}

sdata<-subset(data,data[[1]]=="2007-02-01"|data[[1]]=="2007-02-02")
png(filename="plot1.png",width = 480, height = 480)
hist(sdata$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()

