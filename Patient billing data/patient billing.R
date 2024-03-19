library(readxl)
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(geosphere)

rm(list = ls())
setwd("~/Desktop/DATA - 332/Patient billing data")

df_billing <- read_excel("Billing.xlsx")
df_patient <- read_excel("Patient.xlsx")
df_visit <- read_excel("Visit.xlsx")

df_join <- left_join(df_billing, df_visit, by = c('VisitID'))
df <- left_join(df_join,df_patient, by = c('PatientID'))

df_visit$VisitDate <- month(df_visit$VisitDate)

#reason for visit by month of the year
#plot1
ggplot(data = df_visit, aes(x = Reason, y = VisitDate, fill = WalkIn)) +
  coord_flip() + scale_y_continuous(name="Visit Date") +
  geom_col(position = position_stack()) +
  scale_x_discrete(name="Reason for visit") +
  ggtitle("Reason for visit by month of year") 

#Reason for visit based on walk in or not. 
df_visitbywalkin <- df %>%
  group_by(WalkIn, Reason) %>%
  summarize(count = n())

#plot2
ggplot(df_visitbywalkin, aes(x = Reason, y = count, fill = WalkIn)) +
  coord_flip() + scale_y_continuous(name="WalkIn Status") +
  geom_col(position = position_dodge(width = 0.01)) +
  scale_x_discrete(name="Reason for visit") + 
  ggtitle("Reason for visit based on Walk-In Status") 

#reason to visit based on City
df_visitbylocation <- df %>%             
  dplyr::select(Reason, City) %>%
  count(Reason, City) %>%
  dplyr::rename(Count = n)

#plot3
ggplot(data = df_visitbylocation, aes(x = Reason, y = Count, fill = City)) +
  coord_flip() + scale_y_continuous(name="Count") +
  geom_col(position = position_stack()) +
  scale_x_discrete(name="Reason") +
  ggtitle("Reason to visit based on City") 

#Total invoice amount based on reason for visit
df_invoiceamount <- df %>%
  group_by(InvoiceAmt, Reason, InvoicePaid) %>%
  summarize(count = n())

#plot4
ggplot(data = df_invoiceamount, aes(x = Reason, y = InvoiceAmt, fill = InvoicePaid)) +
  coord_flip() + scale_y_continuous(name="Invoice Amount") +
  geom_col(position = position_stack()) +
  scale_x_discrete(name="Reason for visit") +
  ggtitle("Total invoice amount based on reason for visit") 

#visit based on year born
df$BirthDate <- year(df$BirthDate)

df_visitbyyear <- df %>%
  group_by(LastName, FirstName, BirthDate) %>%
  summarize(count = n())

#plot5
ggplot(df_visitbyyear, aes(x = BirthDate, y = count, fill = factor(BirthDate))) +
  geom_bar(stat = "identity", position = "stack") +
  labs(x = "Birth Year", y = "Count", fill = "Birth Date") +
  ggtitle(" Visit based on year born") +
  theme(axis.text = element_text(angle = 65, vjust = .5, hjust = 1)) 

