library(shiny)
library(ggplot2)
library(dplyr)
library(leaflet)
library(maps)
library(mapdata)
library(ggplot2)
library(caret)
library(randomForest)
library(rsconnect)


# Predefined coordinates for countries
country_coords <- data.frame(
  country = c("Germany", "United States", "Canada", "India", "Australia", "United Kingdom", "France", "Netherlands", "Italy", "Spain"),
  longitude = c(10.4515, -95.7129, -106.3468, 78.9629, 133.7751, -3.4360, 2.2137, 5.2913, 12.5674, -3.7038),
  latitude = c(51.1657, 37.0902, 56.1304, 20.5937, -25.2744, 55.3781, 46.6034, 52.1326, 41.8719, 40.4168)
)

data <- read.csv("jobs_in_data.csv")

# Check the unique locations
unique(data$company_location)

# Generate some findings
findings <- list(
  "Highest average salary is in the United States.",
  "Most job listings are for data scientists.",
  "Senior-level positions offer the highest salaries on average.",
  "France has competitive salaries for mid-level positions."
)

# Define UI
ui <- navbarPage(
  title = "Data Analysis of Jobs in Data Science",
  tabPanel(
    "Documentation",
    fluidPage(
      tags$head(
        tags$style(HTML("
          body { background-color: #f5f5f5; }
          .title { color: #4CAF50; font-weight: bold; }
          .section-title { color: #FF5722; font-size: 1.5em; margin-top: 20px; }
          .summary { background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
          .findings { background-color: #ffeb3b; padding: 15px; border-radius: 5px; margin-top: 10px; }
        "))
      ),
      div(class = "title", "Documentation"),
      sidebarLayout(
        sidebarPanel(
          h4("Research Overview", class = "section-title"),
          p("This Shiny application analyzes data science job listings from various sources.
            The objective is to identify trends and patterns in job requirements, locations, and salaries."),
          h4("Research Requirements", class = "section-title"),
          p("1. Analyze job titles and their frequency."),
          p("2. Geospatial analysis of job locations."),
          p("3. Salary distribution and comparison across different job roles."),
          h4("Scope", class = "section-title"),
          p("The scope of this project encompasses the analysis of job listings in the data science field, with a focus on understanding the current job market, the requirements for different job roles, and the distribution of these roles across various locations. Specifically, the scope includes:"),
          tags$ul(
            tags$li("Data Collection and Preprocessing: Aggregation of job listings from various sources and cleaning and preprocessing of data."),
            tags$li("Job Titles Analysis: Frequency analysis of different job titles and identification of the most common titles."),
            tags$li("Geospatial Analysis: Mapping job locations and analyzing job density in various regions and countries."),
            tags$li("Salary Analysis: Comparison of salaries across different job titles and examination of salary trends based on experience levels."),
            tags$li("Experience Levels Analysis: Distribution of required experience levels across various job categories."),
            tags$li("Employment Types Analysis: Analysis of employment types across different job categories and locations."),
            tags$li("Documentation and Reporting: Comprehensive documentation of the research with interactive graphs and detailed explanations.")
          ),
        ),
        mainPanel(
          div(
            class = "summary",
            h3("About This Research", class = "title"),
            p("This research is focused on analyzing job listings in the data science field. The goal is to identify key trends and requirements for data science roles across different locations and experience levels."),
            h4("Why This Research", class = "section-title"),
            p("With the growing demand for data scientists, it is crucial to understand the job market dynamics. This research helps job seekers and employers alike to understand the key skills and qualifications required in the industry."),
            h4("Scope of the Project", class = "section-title"),
            p("The scope of this project includes analyzing job titles, salaries, experience levels, and geographic distribution of data science jobs."),
            h4("Summary of Findings", class = "section-title"),
            div(
              class = "findings",
              tags$ul(
                lapply(findings, function(finding) {
                  tags$li(finding)
                })
              )
            ),
            h4("Prediction Models and Rationales", class = "section-title"),
            div(class = "model-section",
                h4("Linear Regression Model"),
                h5("Rationale for Choosing Linear Regression"),
                p("Linear regression is chosen for its simplicity and interpretability. It helps in understanding the relationship between a dependent variable (salary) and independent variables (job title, experience level). Linear regression is particularly useful for identifying trends and making straightforward predictions."),
                
                h5("Research Article"),
                p("Tee, Zhen & Raheem, Mafas. (2022). Salary Prediction in Data Science Field Using Specialized Skills and Job Benefits -A Literature Review. 70-74."),
                
                p(" Summary - The study analyzed IT industry data to predict salaries using linear regression. It demonstrated that job title and experience level are significant predictors of salary. The results align with the current project's goal to understand how job titles and experience levels affect salaries in data science jobs."),
                
                h4("Random Forest Model"),
                h5("Rationale for Choosing Random Forest"),
                p("Random Forest is selected for its ability to handle complex interactions and non-linear relationships. It is robust and provides higher accuracy compared to simpler models, especially when dealing with high-dimensional data like job market data."),
                
                h5("Research Article"),
                p("Tee, Zhen & Raheem, Mafas. (2022). Salary Prediction in Data Science Field Using Specialized Skills and Job Benefits -A Literature Review. 70-74."),
                
                p(" Summary - The study focused on predicting salaries using various machine learning models, with Random Forest showing the best performance. It highlighted the model's ability to manage non-linear relationships and interactions between features, which is relevant to the current project where job titles and experience levels can interact in complex ways.")
            ),
            )
          )
        )
      )
    ),
  tabPanel(
    "Graphs",
    fluidPage(
      tabsetPanel(
        tabPanel(
          "Job Titles Frequency", 
          plotOutput("titleFreqPlot", height = "600px"),
          div(class = "plot-summary", "Summary: Most job listings are for data scientists, followed by data analysts and machine learning engineers.")
        ),
        tabPanel(
          "Salary Comparison by Job Title", 
          plotOutput("salaryByTitlePlot", height = "600px"),
          div(class = "plot-summary", "Summary: Senior-level positions offer the highest salaries on average, particularly in the United States.")
        ),
        tabPanel(
          "Salary Comparison by Experience Level", 
          plotOutput("salaryByExperiencePlot", height = "600px"),
          div(class = "plot-summary", "Summary: Experience level significantly impacts salary, with senior-level positions commanding the highest salaries.")
        ),
        tabPanel(
          "Geospatial Analysis by Country", 
          plotOutput("geoPlot", height = "600px"),
          div(class = "plot-summary", "Summary: The highest density of job listings is found in the United States, with significant opportunities also available in Europe and India.")
        ),
        tabPanel(
          "Experience Levels by Job Category", 
          plotOutput("experienceByCategoryPlot", height = "600px"),
          div(class = "plot-summary", "Summary: Most job listings are targeted towards mid-level professionals, followed by senior-level and entry-level positions.")
        ),
        tabPanel(
          "Employment Types by Job Category and Location", 
          plotOutput("employmentByCategoryPlot", height = "600px"),
          div(class = "plot-summary", "Summary: Full-time positions dominate the job market, with contract positions being the second most common.")
          )
        )
      )
    ),
  
  tabPanel(
  "Prediction Models",
  fluidPage(
    h3("Linear Regression Model"),
    verbatimTextOutput("linearModelSummary"),
    plotOutput("linearModelPlot"),
    div(class = "model-summary", "Summary: The linear regression model shows a positive correlation between experience level and salary."),
    h3("Random Forest Model"),
    verbatimTextOutput("randomForestSummary"),
    plotOutput("randomForestPlot"),
    div(class = "model-summary", "Summary: The random forest model captures non-linear relationships in the data, providing a robust prediction of salaries.")
    )
  )
)

server <- function(input, output) {
  
  # Merge data with country coordinates
  data <- merge(data, country_coords, by.x = "company_location", by.y = "country", all.x = TRUE)
  
  # Job Titles Frequency
  output$titleFreqPlot <- renderPlot({
    job_titles <- data %>%
      group_by(job_title) %>%
      summarise(count = n()) %>%
      arrange(desc(count)) %>%
      head(20)  # Limit to top 20 job titles
    
    ggplot(job_titles, aes(x = reorder(job_title, count), y = count, fill = job_title)) +
      geom_bar(stat = "identity") +
      coord_flip() +
      labs(title = "Top 20 Job Titles Frequency", x = "Job Title", y = "Frequency") +
      theme(legend.position = "none", 
            axis.text.y = element_text(size = 8))  # Adjust text size
  })
  
  # Salary Comparison by Job Title (Violin Plot)
  output$salaryByTitlePlot <- renderPlot({
    top_job_titles <- data %>%
      group_by(job_title) %>%
      summarise(count = n()) %>%
      arrange(desc(count)) %>%
      head(20) %>%
      pull(job_title)  # Get the top 20 job titles
    
    filtered_data <- data %>% filter(job_title %in% top_job_titles)
    
    ggplot(filtered_data, aes(x = job_title, y = salary_in_usd, fill = job_title)) +
      geom_violin(trim = FALSE) +
      coord_flip() +
      labs(title = "Salary Comparison by Job Title (Top 20)", x = "Job Title", y = "Salary (USD)") +
      theme(legend.position = "none",
            axis.text.y = element_text(size = 8))  # Adjust text size
  })
  
  # Salary Comparison by Experience Level
  output$salaryByExperiencePlot <- renderPlot({
    ggplot(data, aes(x = experience_level, y = salary_in_usd, fill = experience_level)) +
      geom_boxplot() +
      labs(title = "Salary Comparison by Experience Level", x = "Experience Level", y = "Salary (USD)")
  })
  
  # Geospatial Analysis by Country
  output$geoPlot <- renderPlot({
    world <- map_data("world")
    job_location <- data %>%
      group_by(company_location) %>%
      summarise(count = n(), longitude = mean(longitude, na.rm = TRUE), latitude = mean(latitude, na.rm = TRUE))
    
    ggplot() +
      geom_map(data = world, map = world,
               aes(x = long, y = lat, group = group, map_id = region),
               fill = "white", color = "black") +
      geom_point(data = job_location, aes(x = longitude, y = latitude, size = count, color = count), alpha = 0.7) +
      scale_size_continuous(range = c(3, 10)) +
      labs(title = "Job Locations by Country", x = "Longitude", y = "Latitude")
  })
  
  # Experience Levels by Job Category
  output$experienceByCategoryPlot <- renderPlot({
    experience_category <- data %>%
      group_by(job_category, experience_level) %>%
      summarise(count = n())
    
    ggplot(experience_category, aes(x = job_category, y = count, fill = experience_level)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Experience Levels by Job Category", x = "Job Category", y = "Count")
  })
  
  # Employment Types by Job Category and Location
  output$employmentByCategoryPlot <- renderPlot({
    employment_category <- data %>%
      group_by(job_category, employment_type) %>%
      summarise(count = n())
    
    ggplot(employment_category, aes(x = job_category, y = count, fill = employment_type)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Employment Types by Job Category and Location", x = "Job Category", y = "Count")
  })

# Linear Regression Model
output$linearModelSummary <- renderPrint({
  lm_model <- lm(salary_in_usd ~ job_title + experience_level, data = data)
  summary(lm_model)
})

output$linearModelPlot <- renderPlot({
  lm_model <- lm(salary_in_usd ~ job_title + experience_level, data = data)
  data$predicted_salary <- predict(lm_model, data)
  ggplot(data, aes(x = salary_in_usd, y = predicted_salary)) +
    geom_point() +
    geom_abline(slope = 1, intercept = 0, color = "red") +
    labs(title = "Linear Regression: Actual vs Predicted Salaries", x = "Actual Salary (USD)", y = "Predicted Salary (USD)")
})

# Random Forest Model
output$randomForestSummary <- renderPrint({
  rf_model <- randomForest(salary_in_usd ~ job_title + experience_level, data = data)
  rf_model
})

output$randomForestPlot <- renderPlot({
  rf_model <- randomForest(salary_in_usd ~ job_title + experience_level, data = data)
  data$predicted_salary_rf <- predict(rf_model, data)
  ggplot(data, aes(x = salary_in_usd, y = predicted_salary_rf)) +
    geom_point() +
    geom_abline(slope = 1, intercept = 0, color = "blue") +
    labs(title = "Random Forest: Actual vs Predicted Salaries", x = "Actual Salary (USD)", y = "Predicted Salary (USD)")
})
}

# Run the application
shinyApp(ui = ui, server = server)