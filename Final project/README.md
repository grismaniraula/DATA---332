### Jobs and salaries in data field based on location, experience level, job title and job category 📈


## Introduction 
This project involves the analysis of job listings in the data science field using various data science techniques. The aim is to identify trends and patterns in job requirements, locations, and salaries. 📈

![Job-Market-Volitality-](https://github.com/grismaniraula/DATA-332/assets/118494102/c20f2c56-c1ce-405d-9d56-cbae8f65fe5e)

## Data Dictionary 📖

Columns that we used to analyze the data:

Job category: Different types of job category within the data field
Job title: Different job titles within the job category
Salary: Salary for the respective job title and category
Employee residence: Residence of employees
Experience level: Experience level of employees
Employment type: Full time, part time, contract

## Data Preprocessing 📊

### Predefined Coordinates for Countries

To enhance the geospatial analysis of job listings, we predefined the coordinates for key countries. This allows us to map job locations effectively even when specific longitude and latitude data are not available in the dataset. This step involves creating a data frame with country names and their corresponding geographic coordinates (longitude and latitude).

<img width="988" alt="Screenshot 2024-05-22 at 5 47 46 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/e798775c-6e37-4941-ba0e-35874d9e4ab1">

## Shiny App 💻

### User Interface (UI)
The UI is structured using navbarPage to create a multi-tab layout, enhancing user experience by separating documentation, visualizations, and prediction models into distinct sections.

### 1. First tab of my the shiny application includes:

* Research overview
* Research requirements
* Scope of the project
* Why did I choose to do this research
* Summary of my findings

### 2. Second tab has all of the plots and graphs for my findings. Below are 3 of 6 examples of my plots:

* Job Titles Frequency Plot: This plot displays the frequency of the top 20 job titles in the dataset.
  
<img width="672" alt="Screenshot 2024-05-22 at 5 54 35 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/b41e785c-9871-4490-828d-ea846e79be42">


 * Salary Comparison by Job Title: This violin plot compares salary distributions for the top 20 job titles.
   
<img width="748" alt="Screenshot 2024-05-22 at 5 55 31 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/f8f5d024-ce9d-4461-847b-03b658476ee6">

* Geospatial Analysis by Country: This geospatial plot is to visualize the distribution of job listings by country. The code uses the ggplot2 and maps packages to create a world map and overlay the job location data.

<img width="842" alt="Screenshot 2024-05-22 at 5 59 16 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/c44a5384-da9b-45aa-89da-6b65700d09c8">

### 3. Third tab of my shiny application has 2 prediction models: Linear regression and Random forest

* Linear Regression Model: The Linear Regression model predicts salaries based on job title and experience level.
  
<img width="910" alt="Screenshot 2024-05-22 at 6 01 25 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/34302337-e8cd-482e-a797-e74089daeed2">

* Random Forest Model: The Random Forest model is used for its robustness and ability to handle non-linear relationships in the data.

<img width="909" alt="Screenshot 2024-05-22 at 6 03 10 PM" src="https://github.com/grismaniraula/DATA-332/assets/118494102/220881f5-cb3c-4a02-aa67-5e48e6e9e669">

# Research 🔍
This article (Tee, Zhen & Raheem, Mafas, (2022), Salary Prediction in Data Science Field Using Specialized Skills and Job Benefits - A Literature Review. Pages 70-74) reviews the impact of specialized skills and job benefits on salary prediction in the data science field. It highlights the effectiveness of Linear Regression for identifying clear trends and Random Forest for handling complex interactions and non-linear relationships. These insights align with our project's use of these models to predict salaries based on job titles and experience levels, emphasizing the importance of considering various factors in salary analysis.

https://grismaniraula.shinyapps.io/final_project/

# Conclusion 🫧

This project successfully analyzes job listings in the data science field, providing insights into job titles, salaries, experience levels, and job locations. The Shiny application allows users to interact with the data and view predictions from both Linear Regression and Random Forest models.



   
