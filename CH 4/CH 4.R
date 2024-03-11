setwd("~/Desktop/DATA - 332/CH 4")

cards <- read.csv('cards.csv')
deck <- read.csv('deck.csv')

#positive integers
head(deck)
deck[1, 1]

#to extract more than one value
deck[1, c(1, 2, 3)]

new <- deck[1, c(1, 2, 3)] 
new

#repetition
deck[c(1, 1), c(1, 2, 3)]

#subset a vector (which has one dimension) with a single index
vec <- c(6,1,3,6,10,5) 
vec[1:3]

#drop = FALSE
deck[1:2, 1:2]
deck[1:2, 1]
deck[1:2, 1, drop = FALSE]

#negative integers
deck[-(2:52), 1:3]
deck[c(-1, 1), 1]

#zero
deck[0, 0]

#blank spaces
deck[1, ]

#logical values
deck[1, c(TRUE, TRUE, FALSE)]
rows<-c(TRUE,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F, F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F, F,F,F,F,F,F,F,F,F,F,F,F,F,F)
deck[rows, ]

#names
deck[1, c("face", "suit", "value")]
# the entire value column
deck[ , "value"]

#to make a function that returns the first row of a data frame
deal <- function(cards) { cards[1, ]
}

deal(deck)

#shuffle the deck
deck2 <- deck[1:52, ]
head(deck2)

deck3 <- deck[c(2, 1, 3:52), ]
head(deck3)

random <- sample(1:52, size = 52)
random

deck4 <- deck[random, ]
head(deck4)

#to write a shuffle function
#shuffle should take a data frame and return a shuffled copy of the data frame
shuffle <- function(cards) { 
  random <- sample(1:52, size = 52) 
  cards[random, ]
}

deal(deck)
deck2 <- shuffle(deck)
deal(deck2)

#dollar signs and double brackets
deck$value
mean(deck$value)
median(deck$value)

#to make a list
lst <- list(numbers = c(1, 2), logical = TRUE, strings = c("a", "b", "c")) 
lst

#subset it
lst[1]
sum(lst[1])

lst$numbers
sum(lst$numbers)

lst[[1]]

lst["numbers"]
lst[["numbers"]]
