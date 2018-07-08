# Analysis of Domestic Airline Consumer Airfare

## Description
The U.S. Department of Transportation (DoT) records and publishes tables of information for public use. I would like to analyze two tables from their Domestic Airline Consumer Airfare Report. Both tables
contain directionless fare information.
The first of these, Table 1a, contains information for flights between pairs of airports. Only airports in cities
with more than one airport are listed.
The second, Table 6, contains information about flights between pairs of cities. Specific airport details are
omitted. Only cities that average at least 10 passengers per day are listed.
The datasets are provided with two files:

• **airfare.csv**: The airfare dataset described above, in comma-separated values (CSV) format. Adapted
from the U.S. Department of Transportation.

• **cpi_1996_2017.xls**: A consumer price index (CPI) dataset for transportation, in Microsoft Excel
format. From the U.S. Bureau of Labor Statistics.

## Data

Here is the first row of **airfare.csv**:

|year|	quarter	|city1|	city2|	fare|	miles|	passengers|	airport1|	airport2|	lg_fare|	lg_carrier|	lg_marketshare|	low_fare|	low_carrier|	low_marketshare|	city_id1|	city_id2|	airport_id1|	airport_id2|	table|
--- | --- | ---| ---| ---| ---| ---| ---| ---| ---| ---|--- | --- | ---| ---| ---| ---| ---| ---| ---|
1996|	1|	Allentown/Bethlehem/Easton, PA|	Orlando, FL	|198.6784846|	906	|234.9450549|	ABE|	MCO|	257.2974916|	FL|	0.55940131|	124.1705696|	US|	0.295603368|	30135|	31454|	10135|	13204|	1a|


>**year:** year
>
>**quarter:** quarter
>
>**city1:** descriptive label for city_id1
>
>**city2:** descriptive label for city_id2
>
>**fare:** mean fare in nominal dollars
>
>**miles:** non-stop straight-line miles
>
>**passengers:** mean passengers per day
>
>**airport1:** IATA code for first airport
>
>**airport2:** IATA code for second airport
>
>**lg_fare:** mean fare in nominal dollars for carrier with largest market share
>
>**lg_carrier:** carrier with largest market share
>
>**lg_marketshare:** market share for carrier with largest market share
>
>**low_fare:** mean fare in nominal dollars for carrier with lowest fare
>
>**low_carrier:** carrier with lowest fare
>
>**low_marketshare:** market share for carrier with lowest fare
>
>**city_id1:** identification number for first city market
>
>**city_id2:** identification number for second city market
>
>**airport_id1:** identification number for first airport
>
>**airport_id2:** identification number for second airport
>
>**table:** name of table

Here is the first row of **cpi_1996_2017.xls**:

Year|	Jan	|Feb|	Mar|	Apr|	May|	Jun|	Jul|	Aug|	Sep|	Oct|	Nov|	Dec|	HALF1|	HALF2
--- | --- | ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---
1996	|139.9|	140.4|	141.2|	143.1|	144.4|	144.0|	143.5|	142.8|	143.2|	143.9	|144.8|	145.2|	142.2|	143.9|

## Analysis

I noticed that the number of missing values in 1996 and 1997 is significantly higher than that of the other years. In 1996, the second, third and fourth quarter has the most number of missing variables. In 1997, the fourth quarter has the most number of the missing variables. One possible reason is that the computer was not common in 1996 and 1997, and the data was written by hand. Therefore, it is more difficult for us to retrieve the data. 

Define the connection of city A as the flight from city A to the other city. For example, a flight from A to B is considered as one connection.

![3a](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/3a.png)

In 2017, Atlanta, GA has the most connections (157 connections) to other cities. This is reasonable, because the travelers flying from east coast to west coast or the opposite usually stop at Atlanta. It has one of the largest airports in America.  The cities shown below have the least connections to other cities.

![3b](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/3b.png)
![3c](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/3c.png)

We can see that they all have the connection equal to 1.
Since the data in 2017 only contains the data for the first quarter, when we compare with other years, we only compare with the data of the first quarter.


![3d](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/3d.png)

In 2007, Atlanta, GA has the most connections (164 connections). 

![3e](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/3e.png)

In 1997, Atlanta, GA has the most connections (161 connections).
The rank of Boston, MA is higher in 2017 than that of in 1997 and 2007. 

![3f](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/3f.png)

The I calculated the difference of the number of connections between different years. From 1997 to 2017, Austin, TX has increased connectivity the most, increased by 31 connections. 

![3g](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/3g.png)

From 2007 to 2017, Austin, TX has increased connectivity the most, increased by 24 connections. The airport in Austin, TX is becoming the new epicenter of air travel due to the growth of the demand and its location. 


![4a](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/4a.png)

By looking at the plots, We can see that the number of passengers decreased significantly in 2001, because of the event of September 11, 2001. The national air space was temporarily closed. Some passengers were fear of the attack and the recovery in the number of passengers was slow.
We also notice that there is a decline around 2008. One possible reason is that the economy declined during that time period, so the number of travelers also declined.
After 2013, the number of passengers began to increase gradually. The growth of economy can be one of the possible reasons.

![6a](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/6a.png)

The real fare began to decline from 2000 and declined sharply in 2001. One of the possible reasons is the event of September 11, 2001. Because of the attack, the passengers tried to avoid air travel and the recovery in the number of passengers was slow even when the fare was low. The real fare began to increase from 2011. One of the possible reasons is that the number of travelers increased with the growth of the economy. 

![7a](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/7a.png)

Table 1a is above and Table 6 is on the next page.
I noticed that there is some relationships between real fare and distance. I would like to use linear regression model to find out the relationship between real fare and distance. The distance is the predictor variable and the real fare is the response variable. First, I would like to check if the assumptions of linear regression model are satisfied. 
The residuals of Table 1a and 6 are equally spread around the horizontal line without any distince patterns. Therefore, the assumptions of linearity and constant variance are  satisfed. Also, the residuals are normally distributed, since the residuals follow a staight line in Q-Q plots (although some outlier exist). We can also assume that the observations are independent according to the description of the data set. Thus, we can apply linear regression model to both tables.

![7b](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/7b.png)

From the plots, we can see that there is positive linear relationship between the real fare and the distance for both tables. The real fare increases as the distance increases. This makes sense, because the cost of the flights increases as the distance increases.


The coefficients of the table 1a are 177.87(intercept) and 0.059(slope). R^2=0.31.


The coefficients of the table 6 are 211.23(intercept) and 0.057(slope). R^2=0.23


Since the R^2 of table 1a is larger, the fit is better using the data in table 1a. 


The differences exist because the number of the rows in table 1a and 6 is different. There may be more outliers in table 6 than in table 1a. Also, by looking at the linear regression plots, we notice that the data points in table 1a are closer to the regression line. 


![8a](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/8a.png)
![8b](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/8b.png)

Let us consider average daily passengers in addition to distance.
The model takes distance and average daily passengers as predictor variables and fare as response variable.
The residuals of Table 1a are equally spread around the horizontal line without any distince patterns. Therefore, the assumptions of linearity and constant variance are  satisfed. Also, the residuals are normally distributed, since the residuals follow a staight line in Q-Q plot (although some outliers exist). We can also assume that the observations are independent according to the description of the data set. Thus, we can apply linear regression model to table 1a.
The coefficients of the table 1a are 188.95(intercept), 0.057(coef. of year) and -0.027(coef. of passengers). R^2=0.31.
The relationship between the distance and the real fare is positive, but the relationship between the passengers and the real fare is negative. This is reasonable since the passengers tend to save money and avoid the flights with high fares.
However, we notice that the residuals of table 6 are not euqally spread and the line is not horizontal. Therefore, the assumptions of linearity and constant variance are violated. The line in the Q-Q plot is straight, so the residual may be normally distributed. Since the assumptions are violated, we cannot apply the linear regression model.
We can apply linear regression model to the data in table 1a, but cannot apply to the data in table 6. The residual plot of table 6 contains many extreme values, so there may be many outliers in table 6.


I considered both city1 and city 2 and calculated the mean for each airport.
The average real fare of SMF is about 265.166.
The average real fare of OAK is about 261.589.
The average real fare of SMF is about 280.582.
The average real fare of SMF is about 274.553.
Since the standard deviations of all airports are around 100, we can conclude that there is no significant differences in the real fares among the airports. 

Define long-distance connection as the connection that is longer than 2500 miles. 
Then, SMF has 836 long-distance connections, OAK has 1291 long-distance connections, SFO has 1335 long-distance connections, SJC has 1317 long-distance connections. Thus, SFO has the most long-distance connections.

![10](https://github.com/Qualia061/Data-Science-Projects/blob/master/Analysis%20of%20domestic%20airline%20consumer%20airfare/pics/10.png)

From the plot, we can see that for most years, SFO usually has the most long-distance connections. OAK and SJC usually are the second and the third. The number of long-distance connections in 2017 is low, because we do not have the data for 2017 Q2,3,4.
