# Load necessary packages
library(tidyverse)
library(tidytext)
library(reshape2)
library(wordcloud)
library(shiny)
library(tm)
library(slam)

rm(list = ls())
setwd("~/Desktop/Spring 2024/DATAA-332/data for sentiment analysis")
complaints <- read.csv("Consumer_Complaints.csv")

get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")


complaints <- complaints %>%
  select(Consumer.complaint.narrative, Product) %>%  # Keep only relevant columns
  filter(Consumer.complaint.narrative != "")  %>%   # Remove rows with missing values
  distinct() %>%                                    # Remove duplicates
  mutate(Product = factor(Product))                 # Convert product to factor

ggplot(complaints, aes(x = Product, fill = Product)) +
  geom_bar() +
  ggtitle("Number of complaints by product") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

# Perform sentiment analysis using Bing lexicon
bing_sentiment <- get_sentiments("bing")
complaints_bing <- complaints %>%
  unnest_tokens(word, Consumer.complaint.narrative) %>%
  inner_join(bing_sentiment) %>%
  group_by(Product) 

ggplot(complaints_bing, aes(x = Product, y = sentiment, fill = Product)) +
  geom_bar(stat = "identity") +
  ggtitle("Sentiment analysis using Bing lexicon") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

# Perform sentiment analysis using NRC lexicon
nrc_sentiment <- get_sentiments("nrc")
complaints_nrc <- complaints %>%
  unnest_tokens(word, Consumer.complaint.narrative) %>%
  inner_join(nrc_sentiment) %>%
  group_by(Product, sentiment) %>%
  summarise(count = n()) %>%
  dcast(Product ~ sentiment, value.var = "count", fill = 0)
  
# Plot sentiment analysis using NRC lexicon
ggplot(melt(complaints_nrc, id.vars = "Product"), aes(x = Product, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  ggtitle("Sentiment analysis using NRC lexicon") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))


# Create a word cloud
complaints_wordcloud <- complaints %>%
  unnest_tokens(word, Consumer.complaint.narrative) %>%
  anti_join(stop_words) %>%                       # Remove stop words
  count(word, sort = TRUE) %>%                    # Count word frequency
  with(wordcloud(word, n = 50, max.words = 50, colors = brewer.pal(8, "Dark2")))
  
