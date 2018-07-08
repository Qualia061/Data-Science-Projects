
library(lubridate)
library(readr)
library(ggplot2)
library(geosphere)
library(ggmap)
library(sf)

#
sf_bikeshare_trips_rds = function(
  path = "C:/bikes/sf_bikeshare_trips.csv",
  output = "C:/bikes/sf_bikeshare_trips.rds") {
  #load csv
  sf_bikeshare_trips<-read_csv(path) 
  
  #convert the cols to appropriate data types
  sf_bikeshare_trips$trip_id<- as.factor(as.integer(sf_bikeshare_trips$trip_id))
  sf_bikeshare_trips$start_station_id<- as.factor(as.integer(sf_bikeshare_trips$start_station_id))
  sf_bikeshare_trips$end_station_id<- as.factor(as.integer(sf_bikeshare_trips$end_station_id))
  sf_bikeshare_trips$start_date <- ymd_hms(sf_bikeshare_trips$start_date)
  sf_bikeshare_trips$end_date <- ymd_hms(sf_bikeshare_trips$end_date)
  
  #save rds
  saveRDS(sf_bikeshare_trips, output)
  
  sf_bikeshare_trips
}

sf_bikeshare_trips_rds<-sf_bikeshare_trips_rds()

#check and load the rds
sf_bikeshare_trips <- readRDS("C:/Users/hayas/Google Drive/UCD/STA/141A/HW3/bikes/sf_bikeshare_trips.rds")
sapply(sf_bikeshare_trips, class)


#load the file of bay area stations
sf_bike_share_stations_rds = function(
  path = "C:/Users/hayas/Google Drive/UCD/STA/141A/HW3/bikes/sf_bike_share_stations.csv",
  output = "C:/Users/hayas/Google Drive/UCD/STA/141A/HW3/bikes/sf_bike_share_stations.rds"
) {
  #load csv
  sf_bike_share_stations <- read_csv(path)
  
  #convert the cols
  findclass<-sapply(sf_bike_share_stations, class)
  findclass
  sf_bike_share_stations$station_id <- as.factor(as.integer(sf_bike_share_stations$station_id ))
  sf_bike_share_stations$installation_date  <- ymd(sf_bike_share_stations$installation_date )
  
  #save rds
  saveRDS(sf_bike_share_stations, output)
  
  sf_bike_share_stations
}
sf_bike_share_stations_rds<-sf_bike_share_stations_rds()

#check
sf_bike_share_stations <- readRDS("C:/Users/hayas/Google Drive/UCD/STA/141A/HW3/bikes/sf_bike_share_stations.rds")
sapply(sf_bike_share_stations, class)


#

# number of trips started from each stations
num_trips_station=data.frame(table(sf_bikeshare_trips$start_station_id))

#merge the data frames
sf_bike_share_stations_merged=merge(sf_bike_share_stations, num_trips_station, by.x = "station_id",by.y = "Var1", all = T)

#create a subset only contains landmark==SF
sf_bike_share_stations_merged_only=subset(sf_bike_share_stations_merged,landmark=="San Francisco")

# removing duplicates
sf_bike_share_stations_merged_only_removed=sf_bike_share_stations_merged_only[!duplicated(sf_bike_share_stations_merged_only[,1]),]


qmplot(longitude, latitude, data=sf_bike_share_stations_merged_only_removed, color =I("red"),size=factor(Freq), darken=0.1, zoom = 15)

library(ggrepel) #avoid overlapping
# get SF map
sfc_map <- get_map(c(lon = -122.405, lat = 37.79), zoom = 14.1, maptype="roadmap")
ggmap(sfc_map)
# draw points on the map, larger the size of the points larger the frequency
ggmap(sfc_map)+geom_point(aes(longitude,latitude,size=Freq),alpha=I(1/3),data=sf_bike_share_stations_merged_only_removed)+ geom_text_repel(data=sf_bike_share_stations_merged_only_removed, aes(longitude, latitude, label=name),color="red",vjust=1,hjust=0.5,size=3,fontface = "bold")+labs(title = "Map of Stations in San Francisco",x="longitude",y="latitude",size="Frequency")

#

la_bikeshare_trips_rds = function(
  path = "C:/Users/hayas/Desktop/bikes/LA",
  output = "C:/Users/hayas/Desktop/bikes/LA/la_bikeshare_trips.rds") {
  #load csv
  files=list.files(path,pattern=".csv")
  # Change the column names of each csv file and convert the data type
  data_frames_1=lapply(files,function(p){
    la_bikeshare_trips = read_csv(p)
    colnames(la_bikeshare_trips)=c("trip_id","duration","start_time","end_time","start_station_id","statr_lat","start_lon","end_station_id","end_lat","end_lon","bike_id","plan_duration","trip_route_category","passholder_type")
    la_bikeshare_trips$trip_id=as.factor(as.integer(la_bikeshare_trips$trip_id))
    la_bikeshare_trips$start_time=mdy_hm(la_bikeshare_trips$start_time)
    la_bikeshare_trips$end_time=mdy_hm(la_bikeshare_trips$end_time)
    la_bikeshare_trips$start_station_id=as.factor(as.integer(la_bikeshare_trips$start_station_id))
    la_bikeshare_trips$end_station_id=as.factor(as.integer(la_bikeshare_trips$end_station_id))
    la_bikeshare_trips$bike_id=as.factor(as.integer(la_bikeshare_trips$bike_id))
    la_bikeshare_trips
  })
  #Bind all data frames
  la_bikeshare_trips_1=do.call(rbind,data_frames_1)
  # save the rds file
  saveRDS(la_bikeshare_trips_1, output)
  
  la_bikeshare_trips_1
}

la_bikeshare_trips_rds<-la_bikeshare_trips_rds()

#check and load the rds
la_bikeshare_trips_rds <- readRDS("C:/Users/hayas/Google Drive/UCD/STA/141A/HW3/bikes/LA/la_bikeshare_trips.rds")
sapply(la_bikeshare_trips_rds, class)

colSums(is.na(la_bikeshare_trips))

la_bike_share_stations_rds = function(
  path = "C:/Users/hayas/Google Drive/UCD/STA/141A/HW3/bikes/metro-bike-share-stations-2017-10-20.csv",
  output = "C:/Users/hayas/Google Drive/UCD/STA/141A/HW3/bikes/metro-bike-share-stations-2017-10-20.rds") {
  #load csv
  la_bike_share_stations = read_csv(path)
  
  #convert the cols
  la_bike_share_stations$Station_ID=as.factor(la_bike_share_stations$Station_ID)
  la_bike_share_stations$Go_live_date=mdy(la_bike_share_stations$Go_live_date)
  la_bike_share_stations$Status=as.factor(la_bike_share_stations$Status)
  
  #save the rds file
  saveRDS(la_bike_share_stations , output)
  
  la_bike_share_stations
}

la_bike_share_stations_rds<-la_bike_share_stations_rds()

#check and load the rds
la_bike_share_stations <- readRDS("C:/Users/hayas/Google Drive/UCD/STA/141A/HW3/bikes/metro-bike-share-stations-2017-10-20.rds")
sapply(la_bike_share_stations, class)


#

la_loc_station=la_bikeshare_trips[,c(5:7)] #columns: station_id+lon+lat
la_loc_station_exact=la_loc_station[!duplicated(la_loc_station[,1]),] #removing the duplicates and get the station location

#number of trips started from each stations
num_trips_station_la=data.frame(table(la_bikeshare_trips$start_station_id))

la_bike_share_stations_merged=merge(num_trips_station_la,la_loc_station_exact, by.x = "Var1",by.y = "start_station_id", all = T)

la_bike_share_stations_merged_name=merge(la_bike_share_stations_merged,la_bike_share_stations, by.x = "Var1",by.y = "Station_ID", all = T)

la_bike_share_stations_merged_removed=la_bike_share_stations_merged_name[-c(1,128:131),] #removing abnormal rows


qmplot(start_lon, start_lat, data=la_bike_share_stations_merged_removed, color =I("red"),size=factor(Freq), darken=0.1, zoom = 5)

#get LA map
la_map <- get_map(c(lon = -118.2468, lat = 34.045), zoom = 14, maptype="roadmap")
ggmap(la_map)
# plot the points on the map and size=number of trips started from that station
ggmap(la_map)+geom_point(aes(start_lon, start_lat,size=Freq),alpha=I(1/3),data=la_bike_share_stations_merged_removed)+ geom_text_repel(data=la_bike_share_stations_merged_removed, aes(start_lon, start_lat, label=Station_Name),color="red",vjust=1,hjust=0.5,size=3,fontface = "bold")+labs(title = "Map of Stations in Downtown Los Angeles",x="longitude",y="latitude",size="Frequency")


#
# Let's start with Bay Area
# merge the data frames for future use
sf_bikeshare_trips_merged_q5_start_station=merge(sf_bikeshare_trips,sf_bike_share_stations[,c("station_id", "latitude","longitude")], by.x = "start_station_id",by.y = "station_id", all.x = T)

#rename the columns from convinience
names(sf_bikeshare_trips_merged_q5_start_station)[13]="start_lon"
names(sf_bikeshare_trips_merged_q5_start_station)[12]="start_lat"

sf_bikeshare_trips_merged_q5_bothloc=merge(sf_bikeshare_trips_merged_q5_start_station,sf_bike_share_stations[,c("station_id", "latitude","longitude")], by.x = "end_station_id",by.y = "station_id", all.x = T)

names(sf_bikeshare_trips_merged_q5_bothloc)[14]="end_lat"
names(sf_bikeshare_trips_merged_q5_bothloc)[15]="end_lon"

#a subset that contains two pairs of lon and lat
sf_bikeshare_trips_merged_q5_bothloc_removed=sf_bikeshare_trips_merged_q5_bothloc[!duplicated(sf_bikeshare_trips_merged_q5_bothloc[,3]),]

#four subsets containg trips in the morning(6am-10am), afternoon(10am-3pm), evening(3pm-7pm)and night(7pm-) 
sf_bikeshare_trips_morning=subset(sf_bikeshare_trips_merged_q5_bothloc_removed,(hour(sf_bikeshare_trips_merged_q5_bothloc_removed$start_date)<10)&(hour(sf_bikeshare_trips_merged_q5_bothloc_removed$start_date)>=6))
sf_bikeshare_trips_afternoon=subset(sf_bikeshare_trips_merged_q5_bothloc_removed,(hour(sf_bikeshare_trips_merged_q5_bothloc_removed$start_date)>=10)&(hour(sf_bikeshare_trips_merged_q5_bothloc_removed$start_date)<15))
sf_bikeshare_trips_afternoon_after=subset(sf_bikeshare_trips_merged_q5_bothloc_removed,(hour(sf_bikeshare_trips_merged_q5_bothloc_removed$start_date)>=15)&(hour(sf_bikeshare_trips_merged_q5_bothloc_removed$start_date)<19))
sf_bikeshare_trips_night=subset(sf_bikeshare_trips_merged_q5_bothloc_removed,(hour(sf_bikeshare_trips$start_date)>=19))


num_trips_morning_sf=nrow(sf_bikeshare_trips_morning) # number of trips started between 6am to 10am
num_trips_afternoon_sf=nrow(sf_bikeshare_trips_afternoon) # number of trips started between 10am to 3pm
num_trips_afternoon_after_sf=nrow(sf_bikeshare_trips_afternoon_after) #number of trips started between 3pm to 7pm
num_trips_night_sf=nrow(sf_bikeshare_trips_night) # number of trips started between 7pm to midnight


#calculate the distance using distGeo() at different time of day
sf_distance_morning=distGeo(cbind(sf_bikeshare_trips_morning$start_lon,sf_bikeshare_trips_morning$start_lat),cbind(sf_bikeshare_trips_morning$end_lon,sf_bikeshare_trips_morning$end_lat))
sf_bikeshare_trips_morning$distance=sf_distance_morning

sf_distance_afternoon=distGeo(cbind(sf_bikeshare_trips_afternoon$start_lon,sf_bikeshare_trips_afternoon$start_lat),cbind(sf_bikeshare_trips_afternoon$end_lon,sf_bikeshare_trips_afternoon$end_lat))
sf_bikeshare_trips_afternoon$distance=sf_distance_afternoon

sf_distance_afternoon_after=distGeo(cbind(sf_bikeshare_trips_afternoon_after$start_lon,sf_bikeshare_trips_afternoon_after$start_lat),cbind(sf_bikeshare_trips_afternoon_after$end_lon,sf_bikeshare_trips_afternoon_after$end_lat))
sf_bikeshare_trips_afternoon_after$distance=sf_distance_afternoon_after

sf_distance_night=distGeo(cbind(sf_bikeshare_trips_night$start_lon,sf_bikeshare_trips_night$start_lat),cbind(sf_bikeshare_trips_night$end_lon,sf_bikeshare_trips_night$end_lat))
sf_bikeshare_trips_night$distance=sf_distance_night


#Duration at different time of day
sf_time_interval_morning = sf_bikeshare_trips_morning$start_date %--% sf_bikeshare_trips_morning$end_date
sf_bikeshare_trips_morning$duration=as.numeric(as.duration(sf_time_interval_morning))

sf_time_interval_afternoon = sf_bikeshare_trips_afternoon$start_date %--% sf_bikeshare_trips_afternoon$end_date
sf_bikeshare_trips_afternoon$duration=as.numeric(as.duration(sf_time_interval_afternoon))

sf_time_interval_afternoon_after = sf_bikeshare_trips_afternoon_after$start_date %--% sf_bikeshare_trips_afternoon_after$end_date
sf_bikeshare_trips_afternoon_after$duration=as.numeric(as.duration(sf_time_interval_afternoon_after))

sf_time_interval_night = sf_bikeshare_trips_night$start_date %--% sf_bikeshare_trips_night$end_date
sf_bikeshare_trips_night$duration=as.numeric(as.duration(sf_time_interval_night))

#removing roundtrips where start_station_id == end_station_id
sf_bikeshare_trips_morning_oneway=subset(sf_bikeshare_trips_morning,sf_bikeshare_trips_morning$end_station_id!=sf_bikeshare_trips_morning$start_station_id)
sf_bikeshare_trips_afternoon_oneway=subset(sf_bikeshare_trips_afternoon,sf_bikeshare_trips_afternoon$end_station_id!=sf_bikeshare_trips_afternoon$start_station_id)
sf_bikeshare_trips_afternoon_after_oneway=subset(sf_bikeshare_trips_afternoon_after,sf_bikeshare_trips_afternoon_after$end_station_id!=sf_bikeshare_trips_afternoon_after$start_station_id)
sf_bikeshare_trips_night_oneway=subset(sf_bikeshare_trips_night,sf_bikeshare_trips_night$end_station_id!=sf_bikeshare_trips_night$start_station_id)

# barplots of frequency
barplot(c(num_trips_morning_sf,num_trips_afternoon_sf,num_trips_afternoon_after_sf,num_trips_night_sf),main="Trip Frequency at Different Times of Day in Bay Area",names=c("Morning","Noon","Afternoon","Night"),ylab="Frequency",xlab="Different Times of Day",ylim=c(0,350000))
# boxplots of distance
boxplot(sf_bikeshare_trips_morning_oneway$distance,sf_bikeshare_trips_afternoon_oneway$distance,sf_bikeshare_trips_afternoon_after_oneway$distance,sf_bikeshare_trips_night_oneway$distance,names=c("Morning","Noon","Afternoon","Night"),ylim=c(0,3500),ylab="Distance(meter)",xlab="Different Times of Day",main="Trip Distance in Bay Area")
# boxplots of duration
boxplot(sf_bikeshare_trips_morning$duration,sf_bikeshare_trips_afternoon$duration,sf_bikeshare_trips_afternoon_after$duration,sf_bikeshare_trips_night$duration,names=c("Morning","Noon","Afternoon","Night"),ylim=c(0,2700),ylab="Duration(second)",xlab="Different Times of Day",main="Trip Duration in Bay Area")


#LA
#four subsets containg trips in the morning(6am-10am), afternoon(10am-3pm), evening(3pm-7pm)and night(7pm-) 
la_bikeshare_trips_morning=subset(la_bikeshare_trips,(hour(la_bikeshare_trips$start_time)<10)&(hour(la_bikeshare_trips$start_time)>=6))
la_bikeshare_trips_afternoon=subset(la_bikeshare_trips,(hour(la_bikeshare_trips$start_time)>=10)&(hour(la_bikeshare_trips$start_time)<15))
la_bikeshare_trips_afternoon_after=subset(la_bikeshare_trips,(hour(la_bikeshare_trips$start_time)>=15)&(hour(la_bikeshare_trips$start_time)<19))
la_bikeshare_trips_night=subset(la_bikeshare_trips,(hour(la_bikeshare_trips$start_time)>=19))

#calculate the distance using distGeo() at different time of day
la_distance_morning=distGeo(cbind(la_bikeshare_trips_morning$start_lon,la_bikeshare_trips_morning$start_lat),cbind(la_bikeshare_trips_morning$end_lon,la_bikeshare_trips_morning$end_lat))
la_bikeshare_trips_morning$distance=la_distance_morning

la_distance_afternoon=distGeo(cbind(la_bikeshare_trips_afternoon$start_lon,la_bikeshare_trips_afternoon$start_lat),cbind(la_bikeshare_trips_afternoon$end_lon,la_bikeshare_trips_afternoon$end_lat))
la_bikeshare_trips_afternoon$distance=la_distance_afternoon

la_distance_afternoon_after=distGeo(cbind(la_bikeshare_trips_afternoon_after$start_lon,la_bikeshare_trips_afternoon_after$start_lat),cbind(la_bikeshare_trips_afternoon_after$end_lon,la_bikeshare_trips_afternoon_after$end_lat))
la_bikeshare_trips_afternoon_after$distance=la_distance_afternoon_after

la_distance_night=distGeo(cbind(la_bikeshare_trips_night$start_lon,la_bikeshare_trips_night$start_lat),cbind(la_bikeshare_trips_night$end_lon,la_bikeshare_trips_night$end_lat))
la_bikeshare_trips_night$distance=la_distance_night

#Duration at different time of day
la_time_interval_morning = la_bikeshare_trips_morning$start_time %--% la_bikeshare_trips_morning$end_time
la_bikeshare_trips_morning$duration_new=as.numeric(as.duration(la_time_interval_morning))

la_time_interval_afternoon = la_bikeshare_trips_afternoon$start_time %--% la_bikeshare_trips_afternoon$end_time
la_bikeshare_trips_afternoon$duration_new=as.numeric(as.duration(la_time_interval_afternoon))

la_time_interval_afternoon_after = la_bikeshare_trips_afternoon_after$start_time %--% la_bikeshare_trips_afternoon_after$end_time
la_bikeshare_trips_afternoon_after$duration_new=as.numeric(as.duration(la_time_interval_afternoon_after))

la_time_interval_night = la_bikeshare_trips_night$start_time %--% la_bikeshare_trips_night$end_time
la_bikeshare_trips_night$duration_new=as.numeric(as.duration(la_time_interval_night))

#Removing roundtrips where trip_route_category=="Round trip"
la_bikeshare_trips_morning_oneway=subset(la_bikeshare_trips_morning,la_bikeshare_trips_morning$trip_route_category!="Round Trip")
la_bikeshare_trips_afternoon_oneway=subset(la_bikeshare_trips_afternoon,la_bikeshare_trips_afternoon$trip_route_category!="Round Trip")
la_bikeshare_trips_afternoon_after_oneway=subset(la_bikeshare_trips_afternoon_after,la_bikeshare_trips_afternoon_after$trip_route_category!="Round Trip")
la_bikeshare_trips_night_oneway=subset(la_bikeshare_trips_night,la_bikeshare_trips_night$trip_route_category!="Round Trip")

# barplots of frequency
barplot(c(nrow(la_bikeshare_trips_morning),nrow(la_bikeshare_trips_afternoon),nrow(la_bikeshare_trips_afternoon_after),nrow(la_bikeshare_trips_night)),main="Trip Frequency at Different Times of Day in LA",names=c("Morning","Noon","Afternoon","Night"),ylab="Frequency",xlab="Different Times of Day",ylim=c(0,350000))
# boxplotsof distance
boxplot(la_bikeshare_trips_morning_oneway$distance,la_bikeshare_trips_afternoon_oneway$distance,la_bikeshare_trips_afternoon_after_oneway$distance,la_bikeshare_trips_night_oneway$distance,names=c("Morning","Noon","Afternoon","Night"),xlab="Different Times of Day",ylab="Distance(meter)",ylim=c(0,3500),main="Trip Distance at Different Times of Day in LA")
# boxplots of duration
boxplot(la_bikeshare_trips_morning$duration_new,la_bikeshare_trips_afternoon$duration_new,la_bikeshare_trips_afternoon_after$duration_new,la_bikeshare_trips_night$duration_new,names=c("Morning","Noon","Afternoon","Night"),ylim=c(0,2700),main="Trip Duration at Different Times of Day in LA",xlab="Different Times of Day",ylab="Duration(second)")

#

# create a subset only contains SF area for different times of day (landmark==SF)
sf_bikeshare_trips_morning_oneway_landmark=merge(sf_bikeshare_trips_morning_oneway, sf_bike_share_stations[,c("station_id", "landmark")], by.x = "start_station_id",by.y = "station_id", all.x  = T)
sf_bikeshare_trips_morning_oneway_sf=subset(sf_bikeshare_trips_morning_oneway_landmark,sf_bikeshare_trips_morning_oneway_landmark$landmark=="San Francisco")
sf_bikeshare_trips_morning_oneway_sf=sf_bikeshare_trips_morning_oneway_sf[!duplicated(sf_bikeshare_trips_morning_oneway_sf[,3]),]

sf_bikeshare_trips_afternoon_oneway_landmark=merge(sf_bikeshare_trips_afternoon_oneway, sf_bike_share_stations[,c("station_id", "landmark")], by.x = "start_station_id",by.y = "station_id", all.x  = T)
sf_bikeshare_trips_afternoon_oneway_sf=subset(sf_bikeshare_trips_afternoon_oneway_landmark,sf_bikeshare_trips_afternoon_oneway_landmark$landmark=="San Francisco")
sf_bikeshare_trips_afternoon_oneway_sf=sf_bikeshare_trips_afternoon_oneway_sf[!duplicated(sf_bikeshare_trips_afternoon_oneway_sf[,3]),]

sf_bikeshare_trips_afternoon_after_oneway_landmark=merge(sf_bikeshare_trips_afternoon_after_oneway, sf_bike_share_stations[,c("station_id", "landmark")], by.x = "start_station_id",by.y = "station_id", all.x  = T)
sf_bikeshare_trips_afternoon_after_oneway_sf=subset(sf_bikeshare_trips_afternoon_after_oneway_landmark,sf_bikeshare_trips_afternoon_after_oneway_landmark$landmark=="San Francisco")
sf_bikeshare_trips_afternoon_after_oneway_sf=sf_bikeshare_trips_afternoon_after_oneway_sf[!duplicated(sf_bikeshare_trips_afternoon_after_oneway_sf[,3]),]

sf_bikeshare_trips_night_oneway_landmark=merge(sf_bikeshare_trips_night_oneway, sf_bike_share_stations[,c("station_id", "landmark")], by.x = "start_station_id",by.y = "station_id", all.x  = T)
sf_bikeshare_trips_night_oneway_sf=subset(sf_bikeshare_trips_night_oneway_landmark,sf_bikeshare_trips_night_oneway_landmark$landmark=="San Francisco")
sf_bikeshare_trips_night_oneway_sf=sf_bikeshare_trips_night_oneway_sf[!duplicated(sf_bikeshare_trips_night_oneway_sf[,3]),]



#Calculate the bearings at different times of day
sf_bearing_morning=bearing(cbind(sf_bikeshare_trips_morning_oneway_sf$start_lon,sf_bikeshare_trips_morning_oneway_sf$start_lat),cbind(sf_bikeshare_trips_morning_oneway_sf$end_lon,sf_bikeshare_trips_morning_oneway_sf$end_lat))
sf_bikeshare_trips_morning_oneway_sf$bearing=sf_bearing_morning

sf_bearing_afternoon=bearing(cbind(sf_bikeshare_trips_afternoon_oneway_sf$start_lon,sf_bikeshare_trips_afternoon_oneway_sf$start_lat),cbind(sf_bikeshare_trips_afternoon_oneway_sf$end_lon,sf_bikeshare_trips_afternoon_oneway_sf$end_lat))
sf_bikeshare_trips_afternoon_oneway_sf$bearing=sf_bearing_afternoon

sf_bearing_afternoon_after=bearing(cbind(sf_bikeshare_trips_afternoon_after_oneway_sf$start_lon,sf_bikeshare_trips_afternoon_after_oneway_sf$start_lat),cbind(sf_bikeshare_trips_afternoon_after_oneway_sf$end_lon,sf_bikeshare_trips_afternoon_after_oneway_sf$end_lat))
sf_bikeshare_trips_afternoon_after_oneway_sf$bearing=sf_bearing_afternoon_after

sf_bearing_night=bearing(cbind(sf_bikeshare_trips_night_oneway_sf$start_lon,sf_bikeshare_trips_night_oneway_sf$start_lat),cbind(sf_bikeshare_trips_night_oneway_sf$end_lon,sf_bikeshare_trips_night_oneway_sf$end_lat))
sf_bikeshare_trips_night_oneway_sf$bearing=sf_bearing_night


# the frequency of the bearing in different 
library(ggplot2)
g1=ggplot(sf_bikeshare_trips_morning_oneway_sf,aes(bearing))+ geom_histogram()+coord_polar(start=3.05)+labs(title="Bearing in the Morning",x="Bearing",y="Frequency")
g2=ggplot(sf_bikeshare_trips_afternoon_oneway_sf,aes(bearing))+ geom_histogram()+coord_polar(start=3.05)+labs(title="Bearing at Noon",x="Bearing",y="Frequency")
g3=ggplot(sf_bikeshare_trips_afternoon_after_oneway_sf,aes(bearing))+ geom_histogram()+coord_polar(start=3.05)+labs(title="Bearing in the Afternoon",x="Bearing",y="Frequency")
g4=ggplot(sf_bikeshare_trips_night_oneway_sf,aes(bearing))+ geom_histogram()+coord_polar(start=3.05)+labs(title="Bearing at Night",x="Bearing",y="Frequency")
# combine four ggplots into one
source("http://peterhaschke.com/Code/multiplot.R")
multiplot(g1, g2, g3, g4, cols=2)
