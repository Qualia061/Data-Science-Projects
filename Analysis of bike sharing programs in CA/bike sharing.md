# Visual Analysis of Bike Sharing Programs in CA

## Description
Bike sharing programs have become popular in big cities over the last decade. In the most common arrangement, customers can rent a bike from an automated "dock" and return it later to any other dock in the city.The rental fee is based on how long they used the bike.

The largest bike sharing program in the United States is in New York City, but bike shares have also recently formed in Los Angeles and the San Francisco Bay Area. The bike sharing programs in many cities publish anonymized data about trips and stations.

## Data
The data is provided by the Los Angeles and Bay Area bike shares on the website (https://bikeshare.metro.net/about/data/). The data sets are provided in a ZIP compressed file. The ZIP file contains:

• 1 CSV file with Bay Area bike share stations.

• 1 CSV file with Bay Area bike share trips.

• 1 CSV file with Los Angeles (Metro) bike share stations.

• 5 CSV files with Los Angeles (Metro) bike share trips.

The following tables are what the data sets look like:

|trip_id|duration_sec|	start_date|	start_station_name|	start_station_id|	end_date|	end_station_name|	end_station_id|	bike_number|	zip_code|	subscriber_type|
--- | --- | ---| ---| ---| ---| ---| ---| ---| ---| ---| ---
|650330|495|2015-02-19 15:46:00 UTC|Yerba Buena Center of the Arts (3rd @ Howard)|	68|	2015-02-19 15:54:00 UTC	|San Francisco Caltrain 2 (330 Townsend)|	69|	463|	94061|	Subscriber|

>**trip_id:** unique id of trip

**duration_sec:** duration of trip (in seconds)

**start_date:** time trip started (in PST)

**start_station_name:** name of station where trip started

**start_station_id:** unique id of station where trip started

**end_date:** time trip ended (in PST)

**end_station_name:** name of station where trip ended

**end_station_id:** unique id of station where trip ended

**bike_number:** unique id of bike used

**zip_code:** home zip code of rider (potentially unreliable)

**subscriber_type:** Subscriber = annual or 30-day member; Customer = 24-hour or 3-day member

station_id|	name|	latitude|	longitude|	dockcount|	landmark|	installation_date|
--- |--- |--- |--- |--- |---|---
2|	San Jose Diridon| Caltrain Station|	37.329732|	-121.901782	|27|	San Jose|	8/6/2013

>**station_id:** unique id of station

**name:** name of station

**latitude:** latitude of station

**longitude:** longitude of station

**dockcount:** total number of docks at the station

**landmark:** city

**installation_date:** date the station was installed


## Analysis



