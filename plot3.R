#get and read the data
dat <- unzip ("./exdata_data_household_power_consumption.zip")
dat <- read.csv("./household_power_consumption.txt", header=TRUE, sep =";", stringsAsFactors = F)
View(data)

#subset the df_table based on the correct format for Date 
library(dplyr)
data <-tbl_df(dat)
data$Date <- as.Date(data$Date,"%d/%m/%Y")
dt <- filter(data, data$Date == "2007-02-01" |data$Date == "2007-02-02")

#merge Date and Time and add the new variable to the data
DateTime <- paste(dt$Date,dt$Time)
DateTime <- strptime(DateTime, "%Y-%m-%d %H:%M:%S")
dt <- cbind(DateTime,dt)
#convert some variables as numeric
dt[,4:10] <- sapply(dt[,4:10],as.numeric)

#plot3 create on the "png" graphics file devices
png('plot3.png')
plot(dt$DateTime,dt$Sub_metering_1,xlab="",ylab="Energy sub metering", type="l", ylim = c(0, max(dt$Sub_metering_1, dt$Sub_metering_2, dt$Sub_metering_3)))
lines(dt$DateTime,dt$Sub_metering_2, type = "l", col = "red")
lines(dt$DateTime,dt$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()
