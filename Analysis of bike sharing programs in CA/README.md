# Visual Analysis of Bike Sharing Programs in Bay Area and LA

## Description
Bike sharing programs have become popular in big cities over the last decade. In the most common arrangement, customers can rent a bike from an automated "dock" and return it later to any other dock in the city.The rental fee is based on how long they used the bike.

The largest bike sharing program in the United States is in New York City, but bike shares have also recently formed in Los Angeles and the San Francisco Bay Area. The bike sharing programs in many cities publish anonymized data about trips and stations.

## Data
The data is provided by the Los Angeles and Bay Area bike shares on the website (https://bikeshare.metro.net/about/data/). The data sets are provided in a ZIP compressed file. The ZIP file contains:

• 1 CSV file with Bay Area bike share stations.

• 1 CSV file with Bay Area bike share trips.

• 1 CSV file with Los Angeles (Metro) bike share stations.

• 5 CSV files with Los Angeles (Metro) bike share trips.

The following tables are examples of what the data sets look like:

|trip_id|duration_sec|	start_date|	start_station_name|	start_station_id|	end_date|	end_station_name|	end_station_id|	bike_number|	zip_code|	subscriber_type|
--- | --- | ---| ---| ---| ---| ---| ---| ---| ---| ---
|650330|495|2015-02-19 15:46:00 UTC|Yerba Buena Center of the Arts (3rd @ Howard)|	68|	2015-02-19 15:54:00 UTC	|San Francisco Caltrain 2 (330 Townsend)|	69|	463|	94061|	Subscriber|

>**trip_id:** unique id of trip
>
>**duration_sec:** duration of trip (in seconds)
>
>**start_date:** time trip started (in PST)
>
>**start_station_name:** name of station where trip started
>
>**start_station_id:** unique id of station where trip started
>
>**end_date:** time trip ended (in PST)
>
>**end_station_name:** name of station where trip ended
>
>**end_station_id:** unique id of station where trip ended
>
>**bike_number:** unique id of bike used
>
>**zip_code:** home zip code of rider (potentially unreliable)
>
>**subscriber_type:** Subscriber = annual or 30-day member; Customer = 24-hour or 3-day member

station_id|	name|	latitude|	longitude|	dockcount|	landmark|	installation_date|
--- |--- |--- |--- |--- |---|---
2|	San Jose Diridon| Caltrain Station|	37.329732|	-121.901782	|27|	San Jose|	8/6/2013

>**station_id:** unique id of station
>
>**name:** name of station
>
>**latitude:** latitude of station
>
>**longitude:** longitude of station
>
>**dockcount:** total number of docks at the station
>
>**landmark:** city
>
>**installation_date:** date the station was installed


## Analysis



![sf map](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20bike%20sharing%20programs%20in%20CA/pics/sf%20map.png)


The information about the locations of the Bay Area bike share stations in San Francisco can be obtained from the latitude and longitude columns in the data sets. The size of the grey circle on the map implies the number of trips started from that bike station. From the map, I noticed that there are many bike stations near the bart stations in San Francisco. The number of trips started from these bike stations is usually larger. One possible reason is that people who get off the bart prefer to ride bikes rather than to walk or drive cars. The parking space in San Francisco is very limited and usually not cheap. They probably work at San Francisco and use these public transports every day. There are also some bike stations along the seaside. Tourists can ride bikes and enjoy the beauty of the beach. The number of trips is the largest at San Francisco Caltrain station. It is probably because of the large number of travelers at that station.


![la map](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20bike%20sharing%20programs%20in%20CA/pics/la%20map.png)


From the map, I noticed that there are many bike stations near Pershing Square, Union Station, museums and parks. Also, the number of trips is significantly higher near these areas. One of the possible reasons is that there are many scenic spots in that area and it is more convenient for tourists to move from one spot to the other by riding bikes. There are also many offices near Pershing Square. People who work at these offices may choose to ride bikes, since the parking space is limited and traffic flow is slow.



Next, I would like to investigate trip frequency, distance, and duration change at different times of day.



![freq](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20bike%20sharing%20programs%20in%20CA/pics/freq.png)


I defined the trip frequency as the number of trips started from the station and defined morning as (6am-10am), noon as (10am-3pm),afternoon as (3pm-7pm) and night as (7pm-). From the plot, I noticed that the trip frequency is higher in the morning and afternoon. It is probably because the bikes are used by people who work in Bay Area. They go to work in the morning and go back home in the afternoon. At night, not many people choose to ride bikes, which is probably because it is unsafe to ride at night.


![dist](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20bike%20sharing%20programs%20in%20CA/pics/distance.png)


I ignored the roundtrips in the dataset, which have distance equal to zero. From the boxplots, I noticed that the medians of the distance are higher in the morning and in the afternoon. It is probably because during that period most riders are workers that riding from the bart stations to their offices, so the distance is longer. At noon, people may use the bikes to buy some food from grocery stores, and the distance is shorter. Also, there exist many outliers, which is probably because some people forgot to return the bikes on time.


![dura](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20bike%20sharing%20programs%20in%20CA/pics/duration.png)


I defined trip duration as the time period from the start time to the end time of a trip. From the boxplots, we notice that the median of the trip duration in the morning is lower than that of the others. It is probably because the workers in the morning do not want to be late for work. At noon, the trip duration is higher, probably because many tourists have enough time to go cycling and enjoy the beauty of Bay Area.


![freq la](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20bike%20sharing%20programs%20in%20CA/pics/freq%20la.png)


From the boxplots, I noticed that the trip frequency in LA is significantly higher at noon and in the afternoon. The pattern is quite different compare with the boxplots of the trip frequency in Bay Area. This is probably because the average working time in LA is shorter than that of Bay Area. Another possible reason is that many tourists ride bikes to discover the city at noon and in the afternoon. 


![dist la](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20bike%20sharing%20programs%20in%20CA/pics/distance%20la.png)


The trip distance is higher in the morning and afternoon, but lower at noon and at night. In the morning, the workers in LA use bikes for transportation and the distance can be long. At noon, some workers may use the bikes to get some food near their offices, so the distance may be short. 


![dura la](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20bike%20sharing%20programs%20in%20CA/pics/duration%20la.png)


The trip duration in the morning is significantly lower than that of the other time. In the morning, most users are workers and they do not want to be late for work. At other three time period, most users are tourists and they have plenty of time to ride bikes and discover the city. Thus, the trip durations are higher than that of in the morning.


By comparing the plots, we can conclude that the main user of the bike stations in Bay Area is worker who prefer to ride a bike to their offices and the main user in LA is tourist who rides a bike for relaxing. The trip duration in LA is higher than that in Bay Area most of the time, but the trip distance in Bay Area is longer, which implies the riders in LA are not rushing for time. The frequency is much higher in Bay Area since the data set contains the data from earlier years.

### Driving Directions
![direc](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20bike%20sharing%20programs%20in%20CA/pics/direction.png)

I plotted four histograms in polar coordinates corresponding to the frequency of the bearing in San Francisco. From the plots, we notice that in the morning, most people are traveling to the north and some are traveling to the south. At noon, people travel to the north-east, the north west and the south-west. In the afternoon, most people travel to the south. The pattern at night is similar to the pattern at noon.
The pattern appears in the plots of the bearing in the morning and afternoon is possible because most offices are located at the north of San Francisco and people ride to the north in the morning. In the afternoon, they want to go back to their home, so they ride to the south. 


