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

#plot2 create on the "png" graphics file devices
png(file='plot2.png')
plot(dt$DateTime,dt$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)", type="l")
dev.off()
