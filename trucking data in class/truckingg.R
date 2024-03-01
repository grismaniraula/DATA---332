library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

rm(list = ls()) #to clear the existing environment

setwd("~/Desktop/Spring 2024/DATAA-332/trucking data in class") #set working directory

df_truck <- read_excel("trucking_data.xlsx", skip = 3, .name_repair = "universal", 
                      sheet = 2)

#select columns
df <- df_truck [, c(4:15)]

#deselect columns
df <- subset(df, select = -c(...10))

#difference in days within a column
date_min <- min(df$Date)
date_max <- max(df$Date)

#days of driving
days <- difftime(max(df$Date), min(df$Date))
print(days)
number_of_days_recorded <- nrow(df)

#hours of driving
total_hours <- sum(df$Hours)
average_hours_per_day_recorded <- round(total_hours / number_of_days_recorded, digits = 3)
print(average_hours_per_day_recorded)

#total fuel expense
df$fuel_cost <- df$Gallons * df$Price.per.Gallon
total_fuel_expense <- round(sum(df$fuel_cost), digits = 2)

#new column added
df$total_cost <- df$fuel_cost + df$Tolls + df$Misc
df$other_costs <- df$Tolls + df$Misc


#other expense
total_misc <- sum(df$Misc)
total_tolls <- sum(df$Tolls)
other_expense <- total_misc + total_tolls

#total expense
total_expense <- round(sum(df$total_cost), digits = 2)

#total gallons consumed
total_gallon_consumed <- sum(df$Gallons)

#total miles driven
total_odometer_beginning <- sum(df$Odometer.Beginning)
total_odometer_ending <- sum(df$Odometer.Ending)
total_miles_driven <- total_odometer_ending - total_odometer_beginning

miles_per_gallon <- round(total_miles_driven/total_gallon_consumed, digits = 3)

#cost per mile
total_cost_per_mile <- round(total_expense / total_miles_driven, digits = 3)

#splitting the data
df[c('Warehouse', 'Starting_city_state')] <- str_split_fixed(df$Starting.Location, ',', 2)

#replace comma with space
df$Starting_city_state <- gsub(',', "", df$Starting_city_state)

#df[c('Column1', 'Column2')] <- str_split_fixed(df$City_State, ',', 2)
#nchar(df$City_State)[1]

df_starting_pivot <- df %>%
  group_by(Starting_city_state) %>%
  summarize(count = n(), 
            mean_size_hours = mean(Hours, na.rm = TRUE),
            sd_hours = sd(Hours, na.rm = TRUE),
            total_hourss = sum(Hours, na.rm = TRUE),
            total_gallons = sum(Gallons, na.rm = TRUE)
            
  )

#chart
ggplot(df_starting_pivot, aes(x = Starting_city_state, y = count)) +
  geom_col() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))


#delivery location
df$Delivery.Location <- str_squish(df$Delivery.Location)

df_ending_pivot <- df %>%
  group_by(Delivery.Location) %>%
  summarize(count = n(),
            total_expenses = sum(total_cost, na.rm = TRUE),
            total_fuel_expenses = sum(fuel_cost, na.rm = TRUE),
            other_expenses = sum(other_costs, na.rm = TRUE),
            totall_miles_driven = sum((Odometer.Ending - Odometer.Beginning), na.rm = TRUE),
            miless_per_gallon = sum((total_miles_driven/total_gallon_consumed), na.rm = TRUE),
           

  )
            
  
ggplot(df_ending_pivot, aes(x = Delivery.Location, y = count))+
  geom_col() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))



