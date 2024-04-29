library(readxl)
library(ggplot2)
library(rsconnect)
library(shiny)
library(DT)
library(dplyr)
library(lubridate)

setwd("C:/Users/kobem/Documents/GitHub/DATA-332/Counting Cars IRL")
group1 <- read.csv('UpdatedCarTracking.csv')
group2 <- read_xlsx('MergedCarData.xlsx')
group3 <- read.csv('IRL_Car_Data.csv')
group4 <- read_xlsx('counting_cars.xlsx')
group5 <- read_xlsx('Car.xlsx')
group6 <- read_xlsx('Car Data Excel.xlsx')
group7 <- read_xlsx('Car_Data.xlsx')
group8 <- read_xlsx('Speed analyst 332 Car Data.xlsx')

# Rename and remove columns for each group
group1 <- group1 %>%
  rename(Student = Name,
         MPH = Speed..mph.,
         `Type of Vehicle` = Type.of.Car,
         Temperature = Weather,
         `Time of Day` = Time.of.Day) %>%
  select(-Car.Number)

group2 <- group2 %>%
  rename(`Time of Day` = Time,
         MPH = Speed,
         Student = Name) %>%
  select(-`Orange Light`, -State)

group3 <- group3 %>%
  rename(`Time of Day` = Time.of.Day,
         Student = Collector,
         Weather = Wheater) %>%
  select(-Week.Day)

group4 <- group4 %>%
  rename(Temperature = Temp, 
         `Time of Day` = Time) %>%
  select(-c(6:11))

group5 <- group5 %>%
  rename(MPH = `Speed MPH`,
         `Type of Vehicle` = `Vehicle Type`,
         `Time of Day` = Time,
         Student = `Collector Name`) %>%
  select(-Day, -`Flashing Light`, -`Vehicle Color`, -Manufacturer)

group6 <- group6 %>%
  rename(`Time of Day` = Time,
         MPH = Speed) %>%
  select(-Color, -`License plate state`)

group7 <- group7 %>%
  rename(MPH = Speed,
         `Time of Day` = Time,
         `Type of Vehicle` = Type,
         Student = Name) %>%
  select(-Color)

group8 <- group8 %>%
  rename('Type of Vehicle' = 'Type of se') %>%
  select(-'Orange Light')


# Add missing columns
group1 <- group1 %>%
  mutate(`Group Number` = 1, Date = 'N/A', Weather = 'N/A')

group2 <- group2 %>%
  mutate(`Group Number` = 2, 'Type of Vehicle' = 'N/A')

group3 <- group3 %>%
  mutate(`Group Number` = 3, Date = 'N/A', 'Type of Vehicle' = 'N/A')

group4 <- group4 %>%
  mutate(`Group Number` = 4, Student = 'N/A', 'Type of Vehicle' = 'N/A')

group5 <- group5 %>%
  mutate(`Group Number` = 5, Date = 'N/A')

group6 <- group6 %>%
  mutate(`Group Number` = 6, Student = 'N/A', 'Type of Vehicle' = 'N/A')

group7 <- group7 %>%
  mutate(`Group Number` = 7)

group8 <- group8 %>%
  mutate(`Group Number` = 8)

#Remove Time of Day Column
# Function to remove the "Time of Day" column
remove_time_column <- function(df) {
  df <- select(df, -`Time of Day`)
  return(df)
}

# Convert "Date" column to character type for each group
convert_date_column <- function(df) {
  df$Date <- as.character(df$Date)
  return(df)
}

# Remove "Time of Day" column and convert "Date" column for each group
group1 <- group1 %>%
  remove_time_column() %>%
  convert_date_column()

group2 <- group2 %>%
  remove_time_column() %>%
  convert_date_column()

group3 <- group3 %>%
  remove_time_column() %>%
  convert_date_column()

group4 <- group4 %>%
  remove_time_column() %>%
  convert_date_column()

group5 <- group5 %>%
  remove_time_column() %>%
  convert_date_column()

group6 <- group6 %>%
  remove_time_column() %>%
  convert_date_column()

group7 <- group7 %>%
  remove_time_column() %>%
  convert_date_column()

group8 <- group8 %>%
  remove_time_column() %>%
  convert_date_column()

#Combine all groups
combined_data <- bind_rows(
  group1,
  group2,
  group3,
  group4,
  group5,
  group6,
  group7,
  group8
)

# Rearrange columns in combined_data
combined_data <- combined_data %>%
  select(`Group Number`, Student, Date, `Type of Vehicle`, MPH, Weather, Temperature)

# Convert "Type of Vehicle" column to lowercase
combined_data <- combined_data %>%
  mutate(`Type of Vehicle` = tolower(`Type of Vehicle`))

# Count the frequency of each unique variable in "Type of Vehicle" column
vehicle_counts <- combined_data %>%
  count(`Type of Vehicle`, name = "Frequency")

# View the result
print(vehicle_counts)

# Replace values in "Type of Vehicle" column
combined_data <- combined_data %>%
  mutate(`Type of Vehicle` = case_when(
    `Type of Vehicle` == "hatchback" ~ "sedan",
    `Type of Vehicle` == "se" ~ "sedan",
    `Type of Vehicle` == "minivan" ~ "suv",
    `Type of Vehicle` == "van" ~ "suv",
    TRUE ~ `Type of Vehicle`
  ))

#Finding MIN/MAX/MEAN
min_mph <- min(combined_data$MPH)
max_mph <- max(combined_data$MPH)
mean_mph <- mean(combined_data$MPH)

# Calculate average speed by vehicle type
average_speed_by_vehicle <- combined_data %>%
  group_by(`Type of Vehicle`) %>%
  summarize(Average_Speed = mean(MPH, na.rm = TRUE))

# Define UI
ui <- fluidPage(
  titlePanel("Vehicle Speed Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("vehicle_type", "Vehicle Type:", choices = c("All", unique(combined_data$`Type of Vehicle`))),
      selectInput("summary_stat", "Summary Statistic:", choices = c("Min", "Max", "Mean", "Average")),
      selectInput("average_speed", "Average Speed:", choices = c("Show", "Hide"))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Summary Statistics", plotOutput("speed_plot")),
        tabPanel("Scatter Plot", plotOutput("scatter_plot")),
        tabPanel("Linear Regression", plotOutput("linear_regression_plot"))
      ),
      verbatimTextOutput("avg_speed_output")
    )
  )
)


# Define server logic
server <- function(input, output) {
  
  # Filter data based on selected vehicle type
  filtered_data <- reactive({
    if(input$vehicle_type == "All") {
      data <- combined_data
    } else {
      data <- combined_data %>% filter(`Type of Vehicle` == input$vehicle_type)
    }
    return(data)
  })
  
  # Calculate summary statistic for selected vehicle type
  summary_statistic <- reactive({
    data <- filtered_data()
    summary_stat <- switch(input$summary_stat,
                           "Min" = min(data$MPH, na.rm = TRUE),
                           "Max" = max(data$MPH, na.rm = TRUE),
                           "Mean" = mean(data$MPH, na.rm = TRUE),
                           "Average" = aggregate(MPH ~ `Type of Vehicle`, data = data, FUN = mean))
    return(summary_stat)
  })
  
  # Generate plot based on selected vehicle type and summary statistic
  output$speed_plot <- renderPlot({
    data <- filtered_data()
    p <- ggplot(data, aes(x = `Type of Vehicle`, y = MPH)) +
      geom_boxplot() +
      labs(title = paste("Speed Distribution by Vehicle Type -", input$summary_stat),
           x = "Vehicle Type", y = "MPH")
    print(p)
  })
  
  # Render ggplot graph for scatter plot with linear regression
  output$linear_regression_plot <- renderPlot({
    # Subset data based on selected vehicle type and filter out N/A values for Temperature
    data <- combined_data[!is.na(combined_data$Temperature) & combined_data$Temperature != "N/A", ]
    
    # Perform linear regression with temperature
    lm_model <- lm(MPH ~ Temperature, data = data)
    
    # Create scatter plot with linear regression line
    scatter <- ggplot(data, aes(x = Temperature, y = MPH)) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      labs(x = "Temperature", y = "MPH", title = "Scatter Plot of MPH with Linear Regression")
    
    # Print scatter plot with linear regression line
    print(scatter)
  })
  
  # Render ggplot graph for scatter plot of every data point
  output$scatter_plot <- renderPlot({
    data <- filtered_data()
    ggplot(data, aes(x = 1:nrow(data), y = MPH)) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      labs(x = "Data Point", y = "MPH", title = "Scatter Plot of Every Data Point")
  })
  
  # Display average speed for each vehicle type
  output$avg_speed_output <- renderPrint({
    if(input$average_speed == "Show") {
      summary_stat <- summary_statistic()
      if(input$summary_stat == "Average") {
        return(summary_stat)
      } else {
        return(paste("Selected summary statistic for", input$summary_stat, ":", summary_stat))
      }
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
