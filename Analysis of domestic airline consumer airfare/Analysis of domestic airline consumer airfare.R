library(readr)
airfare <- read_csv("C:/airfare/airfare.csv")

library(readxl)
cpi_1996_2017 <- read_excel("C:/airfare/cpi_1996_2017.xlsx", 
                            skip = 10)
#
airfare_1a=subset(airfare,airfare$table=="1a") # table 1a
airfare_6=subset(airfare,airfare$table=="6") # table 6

#
range(airfare_1a$year) # the range of year in table 1a

colSums((is.na(airfare_1a)))
which.max(colSums((is.na(airfare_1a))))

year_na=table(airfare_1a$year, is.na(airfare_1a$lg_carrier)) # number of NAs of lg_carrier in each year
year_na
table(airfare_1a$quarter[airfare_1a$year==1996], is.na(airfare_1a$lg_carrier[airfare_1a$year==1996])) # number of NAs of each quarters in 1996
table(airfare_1a$quarter[airfare_1a$year==1997], is.na(airfare_1a$lg_carrier[airfare_1a$year==1997])) 



range(airfare_6$year) # the range of year in table 6
colSums((is.na(airfare_6)))

year_na_6=table(airfare_6$year, is.na(airfare_6$low_fare)) # number of NAs of low_fare in each year
year_na_6
table(airfare_6$quarter[airfare_6$year==1996], is.na(airfare_6$low_fare[airfare_6$year==1996])) # number of NAs of each quarters in 1996
table(airfare_6$quarter[airfare_6$year==1997], is.na(airfare_6$low_fare[airfare_6$year==1997])) # number of NAs of each quarters in 1997

#
table(airfare_1a$airport1[airfare_1a$year=="2017"])
which.max(table(airfare_1a$airport1[airfare_1a$year=="2017"]))


table(airfare_6$city1[airfare_6$year=="2017"]) # how many times the cities appear in the table 6 in 2017
num_connect_2017=as.data.frame(table(airfare_6$city1[airfare_6$year=="2017"])) 
which.max(table(airfare_6$city1[airfare_6$year=="2017"])) # find the city with the most connections
which.min(table(airfare_6$city1[airfare_6$year=="2017"])) # find the city with the least connections
num_connect_2017[order(num_connect_2017$Freq),c(1,2)] # order the table

table(airfare_6$city1[airfare_6$year=="2007"]) # how many times the cities appear in the table 6 in 2017
num_connect_2007=as.data.frame(table(airfare_6$city1[airfare_6$year=="2007"&airfare_6$quarter=="1"])) 
which.max(table(airfare_6$city1[airfare_6$year=="2007"])) # find the city with the most connections
which.min(table(airfare_6$city1[airfare_6$year=="2007"])) # find the city with the least connections
num_connect_2007[order(num_connect_2007$Freq),c(1,2)] # order the table

table(airfare_6$city1[airfare_6$year=="1997"]) # how many times the cities appear in the table 6 in 2017
num_connect_1997=as.data.frame(table(airfare_6$city1[airfare_6$year=="1997"&airfare_6$quarter=="1"])) 
which.max(table(airfare_6$city1[airfare_6$year=="1997"])) # find the city with the most connections
which.min(table(airfare_6$city1[airfare_6$year=="1997"])) # find the city with the least connections
num_connect_1997[order(num_connect_1997$Freq),c(1,2)] # order the table


colnames(num_connect_2017)=c("Var1","2017")
num_connect_2007=as.data.frame(table(airfare_6$city1[airfare_6$year=="2007"&airfare_6$quarter=="1"])) # how many times the cities appear in the table 6 in 2007
colnames(num_connect_2007)=c("Var1","2007")
num_connect_1997=as.data.frame(table(airfare_6$city1[airfare_6$year=="1997"&airfare_6$quarter=="1"])) # how many times the cities appear in the table 6 in 1997
colnames(num_connect_1997)=c("Var1","1997")
num_connect_merged= merge(num_connect_1997, merge(num_connect_2007, num_connect_2017, by="Var1", all.x=TRUE, all.y=TRUE), by = "Var1", all.x = TRUE, all.y = TRUE)

num_connect_merged$"97_17"=num_connect_merged$"2017"-num_connect_merged$"1997" #difference of number of connections 97 to 17
num_connect_merged$"07_17"=num_connect_merged$"2017"-num_connect_merged$"2007" #difference of number of connections 07 to 17
num_connect_merged[order(num_connect_merged$"97_17"),c(1,5)]
num_connect_merged[order(num_connect_merged$"07_17"),c(1,6)]

table(airfare_1a$year,airfare_1a$quarter) # find which quarter and year is missing
table(airfare_6$year,airfare_6$quarter)
#
sum(airfare_1a$passengers[airfare_1a$year==1996&airfare_1a$quarter==1])
sum(airfare_6$passengers)

total_9617=aggregate(airfare_1a$passengers,list(airfare_1a$quarter,airfare_1a$year),FUN=sum)
total_q1=subset(total_9617,total_9617$Group.1==1) # total number of passengers in quarter 1
total_q1$x=90*total_q1$x
total_q2=subset(total_9617,total_9617$Group.1==2) # total number of passengers in quarter 2
total_q2$x=91*total_q2$x
total_q3=subset(total_9617,total_9617$Group.1==3) # total number of passengers in quarter 3
total_q3$x=91*total_q3$x
total_q4=subset(total_9617,total_9617$Group.1==4) # total number of passengers in quarter 4
total_q4$x=91*total_q4$x
par(mfrow=c(2,2))
plot(total_q1$Group.2,total_q1$x,type="o",main="Total Passengers in Quarter 1 Over the Years",ylab = "Total Passengers",xlab="Year")
plot(total_q2$Group.2,total_q2$x,type="o",main="Total Passengers in Quarter 2 Over the Years",ylab = "Total Passengers",xlab="Year")
plot(total_q3$Group.2,total_q3$x,type="o",main="Total Passengers in Quarter 3 Over the Years",ylab = "Total Passengers",xlab="Year")
plot(total_q4$Group.2,total_q4$x,type="o",main="Total Passengers in Quarter 4 Over the Years",ylab = "Total Passengers",xlab="Year")

#

cpi=cpi_1996_2017
time.label = paste(airfare_6$year, airfare_6$quarter, sep=".")
cpi.rate = cbind(apply(cpi[,2:4], 1, mean), apply(cpi[,5:7], 1, mean), apply(cpi[,8:10], 1, mean), apply(cpi[,11:13], 1, mean))
cpi.table = data.frame(time = unique(time.label), cpi = as.numeric(t(cpi.rate))[-c(86, 87, 88)]) #delete columns with NAs
real17_fare = sapply(1:length(time.label), function(x) airfare_6$fare[x]*cpi.table$cpi[85]/cpi.table$cpi[which(cpi.table$time==time.label[x])])
airfare_6$real17_fare=real17_fare # add a new column to table 6 which represents real$ of each year


airfare_1a$real17_fare= sapply(1:length(time.label), function(x) airfare_1a$fare[x]*cpi.table$cpi[85]/cpi.table$cpi[which(cpi.table$time==time.label[x])])
# add a new column to table 6 which represents real$ of each year

#


fare_year=aggregate(airfare_6$real17_fare~ airfare_6$year, airfare_6, mean) # mean of real fare for each year
colnames(fare_year)=c("year","real_fare")
plot(fare_year$year,fare_year$real_fare,type="o",main="Real Airfare Changed Over Years",xlab="Year",ylab="Real Fare")


#
line_1a_2015=lm(airfare_1a$real17_fare[airfare_1a$year=="2015"] ~ airfare_1a$miles[airfare_1a$year=="2015"]) #the model we use
par(mfrow=c(2,2))
plot(airfare_1a$miles[airfare_1a$year=="2015"],airfare_1a$real17_fare[airfare_1a$year=="2015"],xlab="Distance(miles)",ylab="Real Fare",main="The Graph of Real Fare vs Distance (Table 1a)") # the graph of real fare vs distance
abline(line_1a_2015)
plot(line_1a_2015,which=1,main="Table 1a") #residual plot
plot(line_1a_2015,which=2,main="Table 1a") #QQ plot


summary(line_1a_2015)$r.squared # R^2

line_6_2015=lm(airfare_6$real17_fare[airfare_6$year=="2015"] ~ airfare_6$miles[airfare_6$year=="2015"]) #the model we use
par(mfrow=c(2,2))
plot(airfare_6$miles[airfare_6$year=="2015"],airfare_6$real17_fare[airfare_6$year=="2015"],xlab="Distance(miles)",ylab="Real Fare",main="The Graph of Real Fare vs Distance (Table 6)") # the graph of real fare vs distance
abline(line_6_2015)
plot(line_6_2015,which=1,main="Table 6") #residual plot
plot(line_6_2015,which=2,main="Table 6") #QQ plot


summary(line_6_2015)$r.squared 

#

line_1a_2015_passenger=lm(airfare_1a$real17_fare[airfare_1a$year=="2015"] ~ airfare_1a$passengers[airfare_1a$year=="2015"]+airfare_1a$miles[airfare_1a$year=="2015"]) 
par(mfrow=c(1,2))
plot(line_1a_2015_passenger,which=1,main="Table 1a") #residual plot
plot(line_1a_2015_passenger,which=2,main="Table 1a") #QQ plot
#plot(airfare_1a$passengers[airfare_1a$year=="2015"],airfare_1a$fare[airfare_1a$year=="2015"])
abline(line_1a_2015_passenger)

line_6_2015_passenger=lm(airfare_6$real17_fare[airfare_6$year=="2015"] ~ airfare_6$passengers[airfare_6$year=="2015"]+airfare_6$miles[airfare_1a$year=="2015"]) 
par(mfrow=c(1,2))
plot(line_6_2015_passenger,which=1,main="Table 6") #residual plot
plot(line_6_2015_passenger,which=2,main="Table 6") #QQ plot
#plot(airfare_6$passengers[airfare_6$year=="2015"],airfare_6$fare[airfare_6$year=="2015"])
abline(line_6_2015_passenger)


#
city_pair=subset(airfare_6,airfare_6$fare>airfare_6$lg_fare) # subset that only contains (lg_fare<fare)
city_pair_2015=subset(city_pair,city_pair$year=="2015")

city_pair_above=subset(airfare_6,airfare_6$fare<airfare_6$lg_fare) # subset that only contains (lg_fare>fare)
city_pair_2015_above=subset(city_pair_above,city_pair_above$year=="2015")

table(city_pair_2015$lg_carrier) # number of largest carrier (lg_fare<fare)
table(city_pair_2015_above$lg_carrier) # number of largest carrier (lg_fare>fare)
plot(density(city_pair_2015$passengers),xlim=c(0,1000))
plot(density(city_pair_2015_above$passengers),xlim=c(0,1000))


quantile(city_pair_2015$passengers,na.rm =TRUE,prob = seq(0, 1, length = 11)) #decile
quantile(city_pair_2015_above$passengers,na.rm =TRUE,prob = seq(0, 1, length = 11))

#
#boxplot(airfare_1a$real17_fare[airfare_1a$airport1=="SMF"]+airfare_1a$real17_fare[airfare_1a$airport2=="SMF"],airfare_1a$real17_fare[airfare_1a$airport1=="OAK"]+airfare_1a$real17_fare[airfare_1a$airport2=="OAK"],airfare_1a$real17_fare[airfare_1a$airport1=="SFO"]+airfare_1a$real17_fare[airfare_1a$airport1=="SFO"],airfare_1a$real17_fare[airfare_1a$airport1=="SJC"]+airfare_1a$real17_fare[airfare_1a$airport1=="SJC"],ylim=c(0,2000),names =c("SMF","OAK","SFO","SJC"))

mean(airfare_1a$real17_fare[airfare_1a$airport1=="SMF"|airfare_1a$airport2=="SMF"],na.rm=TRUE) # mean real fare
mean(airfare_1a$real17_fare[airfare_1a$airport1=="OAK"|airfare_1a$airport2=="OAK"],na.rm=TRUE)
mean(airfare_1a$real17_fare[airfare_1a$airport1=="SFO"|airfare_1a$airport2=="SFO"],na.rm=TRUE)
mean(airfare_1a$real17_fare[airfare_1a$airport1=="SJC"|airfare_1a$airport2=="SJC"],na.rm=TRUE)

num_long_SMF=sum(airfare_1a$miles[airfare_1a$airport1=="SMF"]>2500)+sum(airfare_1a$miles[airfare_1a$airport2=="SMF"]>2500)
num_long_OAK=sum(airfare_1a$miles[airfare_1a$airport1=="OAK"]>2500)+sum(airfare_1a$miles[airfare_1a$airport2=="OAK"]>2500)
num_long_SFO=sum(airfare_1a$miles[airfare_1a$airport1=="SFO"]>2500)+sum(airfare_1a$miles[airfare_1a$airport2=="SFO"]>2500)
num_long_SJC=sum(airfare_1a$miles[airfare_1a$airport1=="SJC"]>2500)+sum(airfare_1a$miles[airfare_1a$airport2=="SJC"]>2500)

num_long_each_SMF=aggregate(airfare_1a$miles[airfare_1a$airport1=="SMF"|airfare_1a$airport2=="SMF"]~ airfare_1a$year[airfare_1a$airport1=="SMF"|airfare_1a$airport2=="SMF"], airfare_1a, function(x) sum(x > 2500))
colnames(num_long_each_SMF)=c("year","miles") # find number of long distance connections in each year
num_long_each_OAK=aggregate(airfare_1a$miles[airfare_1a$airport1=="OAK"|airfare_1a$airport2=="OAK"]~ airfare_1a$year[airfare_1a$airport1=="OAK"|airfare_1a$airport2=="OAK"], airfare_1a, function(x) sum(x > 2500))
colnames(num_long_each_OAK)=c("year","miles")
num_long_each_SFO=aggregate(airfare_1a$miles[airfare_1a$airport1=="SFO"|airfare_1a$airport2=="SFO"]~ airfare_1a$year[airfare_1a$airport1=="SFO"|airfare_1a$airport2=="SFO"], airfare_1a, function(x) sum(x > 2500))
colnames(num_long_each_SFO)=c("year","miles")
num_long_each_SJC=aggregate(airfare_1a$miles[airfare_1a$airport1=="SJC"|airfare_1a$airport2=="SJC"]~ airfare_1a$year[airfare_1a$airport1=="SJC"|airfare_1a$airport2=="SJC"], airfare_1a, function(x) sum(x > 2500))
colnames(num_long_each_SJC)=c("year","miles")


plot(num_long_each_SMF$year,num_long_each_SMF$miles,type="o",ylim=c(0,80),xlab="Year",ylab="Number of Long-distance Connections",main="Number of Long-distance Connections Over Years")
par(new=TRUE)
plot(num_long_each_OAK$year,num_long_each_OAK$miles,type="o",col="red",xlab="Year",ylab="Number of Long-distance Connections",ylim=c(0,80))
par(new=TRUE)
plot(num_long_each_SFO$year,num_long_each_SFO$miles,type="o",col="blue",xlab="Year",ylab="Number of Long-distance Connections",ylim=c(0,80))
par(new=TRUE)
plot(num_long_each_SJC$year,num_long_each_SJC$miles,type="o",col="green",xlab="Year",ylab="Number of Long-distance Connections",ylim=c(0,80))
legend(2005,25,c("SMF","OAK","SFO","SJC"),c("black","red","blue","green"))
          