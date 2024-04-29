library(readxl)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(stringr)
library(lubridate)
library(rsconnect)
library(shiny)
library(DT)
library(officer)

setwd("~/Desktop/Counting Cars Data")
df_data <- read_xlsx('332 Car Data.xlsx')

df_data <- df_data %>%
  mutate(`Time of Day` = format(`Time of Day`, "%H:%M"))

df_data <- df_data %>%
  rename(`Type of vehicle` = `Type of se`)

df_data$`Type of vehicle` <- tolower(df_data$`Type of vehicle`)

min_mph <- min(df_data$MPH)
max_mph <- max(df_data$MPH)
mean_mph <- mean(df_data$MPH)

avg_speed <- df_data %>%
  group_by(`Type of vehicle`) %>%
  summarise(avg_speed = round(mean(MPH), 1))

# Define UI
ui <- fluidPage(
  
  # Application title
  titlePanel("Car Data Analysis"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      
      # Dropdown menu for selecting vehicle type
      selectInput(inputId = "vehicle",
                  label = "Select Vehicle Type:",
                  choices = unique(df_data$`Type of vehicle`)),
      
      # Dropdown menu for selecting statistic to display
      selectInput(inputId = "stat",
                  label = "Select Statistic:",
                  choices = c("Minimum MPH" = "min",
                              "Maximum MPH" = "max",
                              "Mean MPH" = "mean",
                              "Average Speed by Vehicle Type" = "avg_speed"))
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      
      # Output: Graph
      plotOutput(outputId = "graph")
    )
  ),
  
  # Add a new tab for ggplot graph and linear regression
  tabsetPanel(
    tabPanel("Histogram & Summary", plotOutput("graph")),
    tabPanel("Scatter Plot", plotOutput("ggplot_graph")),
    tabPanel("MPH Compared to Temp", plotOutput("linear_regression_plot")),
    tabPanel("Counting Cars Research", textOutput("word_document_text"))
  )
)

# Define server logic
server <- function(input, output) {
  
  # Function to generate plot based on selected inputs
  output$graph <- renderPlot({
    
    # Subset data based on selected vehicle type
    data <- df_data[df_data$`Type of vehicle` == input$vehicle, ]
    
    # Plot based on selected statistic
    if (input$stat %in% c("min", "max", "mean")) {
      # Plot single statistic
      plot_stat <- switch(input$stat,
                          "min" = min_mph,
                          "max" = max_mph,
                          "mean" = mean_mph)
      hist(data$MPH, main = paste("Histogram of MPH for", input$vehicle),
           xlab = "MPH", col = "skyblue", border = "black")
      abline(v = plot_stat, col = "red", lwd = 2)
      
    } else if (input$stat == "avg_speed") {
      # Plot average speed by vehicle type
      ggplot(avg_speed, aes(x = `Type of vehicle`, y = avg_speed)) +
        geom_bar(stat = "identity", fill = "skyblue") +
        geom_text(aes(label = avg_speed), vjust = -0.5, color = "black", size = 3) +
        labs(x = "Type of Vehicle", y = "Average Speed (MPH)", title = "Average Speed by Type of Vehicle") +
        theme_minimal()
    }
  })
  
  # Render ggplot graph
  output$ggplot_graph <- renderPlot({
    ggplot(df_data, aes(x = 1:nrow(df_data), y = MPH)) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      labs(x = "Data Point", y = "MPH", title = "Scatter Plot of Every Data Point")
  })
  
  # Perform linear regression and render the linear regression plot
  output$linear_regression_plot <- renderPlot({
    # Subset data based on selected vehicle type
    data <- df_data[df_data$`Type of vehicle` == input$vehicle, ]
    
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
  
  # Read and display the content of the Word document
  output$word_document_text <- renderText({
    doc <- read_docx("Counting Cars Research.docx")
    text_content <- docx_summary(doc)
    
    # Filter out empty strings or strings with only whitespace characters
    text_content <- text_content[text_content != "" & !grepl("^\\s*$", text_content)]
    
    # Concatenate the text into a single string
    text <- paste(text_content, collapse = "\n")
    text
  })
}
  
# Run the application
shinyApp(ui = ui, server = server)

