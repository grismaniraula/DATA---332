# Counting-Cars
## Feven Ferede, Kobe Magee, Grisma Niruala

---
## Introduction
This project encompassed gathering data on vehicle speeds using a radar speed detector positioned along 24th Ave with a speed limit of 30mph. The data gathered is from the whole class.
<div align = "center">
<img src = "images/30 mph.jpg" width = "450")>
</div>

---
## Data Dictionary 📖 
Columns that we used to analyze the data:
1. Date: the different dates when the speed of vehicles were recorded
2. Day: the day when the data was recorded (a group did day like saturday, sunday, etc not date in mm-dd format)
3. Speed: Speed of the vehicle
4. Vehicle Type: Types of vehicle
5. Time: Time when the speed of vehicles was recorded
6. Temperature: Temperature throughout the time when the speed of vehicles was recorded
7. Weather: The weather, if it was sunny, partly cloudy, raining, etc during the time the data was recorded
8. Name: The names of student's who collected the data

---
## Data Cleaning 🧽
1. Data Name Reassignment:
   i. Assigned names as "group 1", "group 2", etc to the excel and csv files loaded. Below is what it looks like:
<div>
<img src = "images/data to group naming and numbering.png" width = "450")>
</div>
2. Renaming Columns
   i.We renamed columns so all the columns from the different data are similar. We also removed columns that     are unnecessary to the data analysis. Below is a snippet of the code we wrote as an example to show how we renamed and removed the columns:
<div>
<img src = "images/data analysis part 1 example.png" width = "450")>
</div>
3. Uniformity in the columns:
   i. We want all the tables with the same type of columns: Time of Day, Temperature, Type of Vehicle, MPH, Student, Group Number, and Weather. So we decided to add into the tables and for the ones without data for a column other than group number. the data under that column is assigned N/A. Below is an example of the code:
<div>
<img src = "images/adding missing columns.png" width = "450")>
</div>

4. Removal of the "Time of Day" column:
<div>
<img src = "images/removal of time of day column.png" width = "450")>
</div>

5. We converted the "Date" column to character type for each group:
<div>
<img src = "images/convert date column to character type.png" width = "450")>
</div>

6. We removed the "Time of Day" column and convert the "Date" column for each group:
<div>
<img src = "images/remove of time of day column and conversion of date column.png" width = "450")>
</div>

7. We combined all 8 groups and rearranged the table.
<div>
<img src = "images/combined data.png" width = "450")>
</div>

9. Then we converted the column "Type of Vehicle" column to lowercase
<div>
<img src = "images/type of vehicle column.png" width = "450")>
</div>

10. We then replaced some of the values in "Type of Vehicle" column:
<div>
<img src = "images/replacing values in type of vehicle column.png" width = "450")>
</div>

---
## Shiny App 💻
1. We created a dropdown menu where you can select the vehicle type, summary statistics (includes min, max, mean, and average speed), and average speed (whether under each plot based on the summary statistics chosen, one would want to see the average speed).
<div>
<img src = "<div>
<img src = "images/remove of time of day column and conversion of date column.png" width = "450" width = "450")>
</div>

Here is the link to the ShinyApp: [https://kobemagee20.shinyapps.io/all_car_data/]

---
## Data Analysis 📊
Using ShinyApp, we created 3 different graphs to visualize the minimumn, maximum, mean, and average speed of all the types of vehicles: box and whisker plot, scatter plot, an dlinear regression. Below are some images that show these visualisations.

1. Summary Statistics
   - This shows a graph with a summary of all the vehicles in the min, max, mean, or average speed. It will also show a table with the average speed within each category (under average speed, a table with all the types of vehicles' average speed will be shown). Below are example graphs of the minimum speed and average speed:
   i. Minimum Speed:
<div>
   <img src = "images/summary stats min speed.png" width = "450"> 
</div>

2. Scatterplot:
   - This shows a scatterplot graph of all the vehicles types:
<div>
   <img src = "images/scatterplot avergae speed.png" width = "450"> 
</div>

3. Linear Regression:
   - This shows a linear regression plot of all the vehicles types:
<div>
   <img src = "images/linear regression graph.png" width = "450"> 
</div>   
