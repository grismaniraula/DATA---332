library(readxl)
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)

rm(list = ls())
setwd("~/Desktop/DATA - 332/Student data")

df_course <- read_excel("Course.xlsx",.name_repair = "universal")
df_registration <- read_excel("Registration.xlsx",.name_repair = "universal")
df_student <- read_excel("Student.xlsx",.name_repair = "universal")

df <- left_join(df_course, df_registration, by = c('Instance.ID'))
df1 <- left_join(df,df_student, by = c('Student.ID'))


#number of majors
df_major_pivot <- df1 %>%
  group_by(Title) %>%
  summarize(count = n())

#plot1
ggplot(df_major_pivot,aes(x = Title, y = count, fill = factor (Title))) +
  geom_col()+
  scale_fill_viridis_d() +
  labs(title = "Number of Majors",x = "Title", y = "Count") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

#birth year of the student
df1$Birth.Date <- year(df1$Birth.Date)

df_birthyear_pivot <- df1 %>%
  group_by(Birth.Date) %>%
  summarize(count = n())

#plot2
ggplot(df_birthyear_pivot,aes(x = Birth.Date, y = count)) +
  geom_col()+
  scale_fill_viridis_d() +
  labs(title = "Birth Year Of Students",x = "Birth Year", y = "Count") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))


#total cost by major
df1$Total.Cost[is.na(df1$Total.Cost)] <- 0

AllPaymentPlanStudents <- df1 %>%
  dplyr::filter(Payment.Plan == "TRUE" )

TotalCostByMajor <- df1 %>%
  dplyr::group_by(Title) %>%
  dplyr::summarise(Total.Cost = sum(Total.Cost))

#plot3
ggplot(TotalCostByMajor, aes(x = Total.Cost, y= Title, group=1)) +
  geom_point() +
  geom_line()+
  scale_x_continuous(labels = label_comma())+
  labs(title = "Total Cost By Major",x = "Total Cost", y = "Title") 

#total balance due by major

df1$Balance.Due[is.na(df1$Balance.Due)] <- 0

TotalBalanceByMajor <- df1%>%
  dplyr::group_by(Title) %>%
  dplyr::summarise(Balance.Due = sum(Balance.Due))

#plot4          
ggplot(TotalBalanceByMajor, aes(x = Title, y = Balance.Due, fill = factor (Title))) +
  geom_col()+
  scale_fill_viridis_d() +
  labs(title = "Total Balance By Major",x = "Title", y = "Balance Due") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

