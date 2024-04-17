# COUNTING CARS 🚘

## Contributors 🏎️
Kobe Magee, Grisma Niraula, Feven Ferede

## Introduction
We recorded speed of vehicles near 30th St and 24th Avenue in Rock Island IL on 2 different days. We will analyze the data with minimum, maximum and average speed of various vehicle type in a Shiny application 🛻. 

![git](https://github.com/grismaniraula/DATA-332/assets/118494102/858f7c0f-d542-4af8-a0fc-d421ecf0787d)


## Data Dictionary 📖
Columns that we used to analyze the data:
1. Date: 2 different dates when the speed of vehicles was recorded
2. MPH: Speed of the vehicle
3. Type of vehicle: Types of vehicle
4. Time of the day: Time when the speed of vehicles was recorded
5. Temperature: Temperature throughout the time when the speed of vehicles was recorded

## Data Cleaning 🧽
### 1. Time 🕑:
  - Values we recorded: The time we recorded was in the format of hh/mm/ss.
  - What we changed: We changed the format of time from hh/mm/ss to hh/mm.

    <img width="429" alt="Screenshot 2024-04-15 at 8 35 38 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/67c3309a-0900-4b41-a0dc-d41bf99c1e13">


 ### 2. Type of vehicle 🚌:
  - We renamed the column 'Type of se' to 'Type of vehicle'.
  - And, we used 'tolower' function to convert characters in this respective column to lowercase.
    
    <img width="471" alt="Screenshot 2024-04-17 at 10 48 35 AM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/f52eb716-46d1-40c3-aeaf-a6a1f6f717d2">


## Shiny App 💻

1. We started by creating a dropdown menu where we can select different vehicle types.
2. Then, we created a second dropdown menu for selecting statistic to display that we calculated which are minimum mph, maximum mph, mean mph and average speed of the specific vehicle type.

   <img width="459" alt="Screenshot 2024-04-17 at 12 42 54 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/e4217ca4-f6dd-47d9-ac19-197213ed430e">


3. We, then created a main panel, where all of our plots and graphs can be displayed.
  - Histogram that summarizes any data we choose to look at.
  - Scatter plot for every data point
  - Scatter plot of MPH with Linear Regression

## Data Analysis 📊

### 1. Min, max and mean MPH

  <img width="320" alt="Screenshot 2024-04-17 at 10 52 25 AM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/4d4b40be-e1d5-460a-9e67-53854bda6cc7">


  - We calculated three summary statistics (minimum, maximum, and mean) for the variable "MPH" in the data frame df_data.
  - As seen in the image above, the minimum speed of the vehicles was 17, maximum speed was 45 and the average speed vehicles were moving at was 33.26.


### 2. Average speed of each type of vehicle
  
  <img width="1439" alt="Screenshot 2024-04-17 at 11 09 47 AM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/924fb73d-ecae-4539-9672-088f7330cabf">


  - From the analysis, emergency vehicles like ambulance had the highest average speed of 44.5mph.
  - The lowest speed calculated was of bus with the average speed of 29mph.
  - The average speed for rest of the vehicles like SUV, se, motorcycle, dump truck and truck varied from 32-35mph.


### 3. Mean MPH for SUV


  <img width="1439" alt="Screenshot 2024-04-17 at 12 52 59 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/6af3cb8d-6f60-4925-a9ed-3bf656fbc7be">

  - This measurement of data tells us that the mean speed for SUV was somewhere around 33-35 MPH.
  - This data concludes that the speed of SUVs falls under the category of average speed.


### 4. Scatter plot for every data point


  <img width="1439" alt="Screenshot 2024-04-17 at 1 22 24 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/7d9f5bc4-5bab-4c6b-b698-81c773edd0c4">

  - Each dot represented in the plot above is the speed we recorded for each vehicle.
  - The red line in the plot is a line of best fit. It shows the relationship between the points.
  - We analyzed that since the line of best fit is pretty straight, it tells us that there is no correlation between MPH and how many cars were recorded.


### 5. Scatter plot of MPH with linear regression


  <img width="1439" alt="Screenshot 2024-04-17 at 1 52 16 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/f147d34e-a990-4c0d-8565-3fd50780383b">
  
  - This plot illustrates the relationship between temperature (X-axis) and MPH (Y-axis), showcasing a discernible trend.
  - The linear regression line (red line) fitted to the data highlights a  relation between temperature and MPH.
  - We analyzed that since the line of best fit is pretty straight, it tells us that there is no correlation between MPH and temperature.


## Research 🔍

We did a research on analyzing the speed of the cars, what factors would affect the speed of cars and systems to regulate vehicle speed. The research collectively explores the efficacy of radar and Dynamic Speed Monitoring Display (DSMD) signs in regulating vehicle speeds. Veneziano's research underscores the need for nuanced implementation of radar speed signs, emphasizing pre-deployment speed studies. Williamson and Fries found that radar speed signs induce speed reductions in most drivers, but some continue to speed in the absence of law enforcement. Sandberg, Schoenecker, Sebastian, and Soler's study demonstrates sustained reductions in vehicle speeds following DSMD sign installation, supported by comprehensive data collection and analysis. Overall, these findings advocate for the strategic deployment of speed signage to enhance road safety.

## Conclusion 🫧
We've effectively analyzed the speed data across various vehicle types, providing valuable insights into their average, maximum, and minimum speeds through Shiny app. Through interactive visualization and data exploration, users can grasp the speed distribution and trends with ease.
