library(play)

setwd("~/Desktop/DATA - 332/CH 8")
DECK <- read.csv('deck.csv')

play()

# to display symbols (we call print from within play)
one_play <- play()
one_play

#the S3 system
num <- 1000000000 
print(num)

#give that number the S3 class POSIXct followed by POSIXt, print will display a time
class(num) <- c("POSIXct", "POSIXt")
print(num)

#attributes
attributes(DECK)

#to retrieve an attribute’s value
row.names(DECK)

#to change an attribute’s value
row.names(DECK) <- 101:152

#to give an object a new attribute altogether
levels(DECK) <- c("level 1", "level 2", "level 3")

attributes(DECK)

#one_play, the result of playing our slot machine one time
one_play <- play() 
one_play

attributes(one_play)

#give one_play an attribute named symbols that contains a vector of character strings
attr(one_play, "symbols") <- c("B", "0", "B")
attributes(one_play)

#give attr an R object and the name of the attribute you would like to look up
attr(one_play, "symbols")

#exercise
play <- function() {
  symbols <- get_symbols()
  prize <- score(symbols) 
  attr(prize, "symbols") <- symbols 
  prize
}

#structure will add the attributes to the object under the names that you provide as argument names
play <- function() {
  symbols <- get_symbols() 
  structure(score(symbols), symbols = symbols)
}

three_play <- play() 
three_play

#to display our slot results
slot_display <- function(prize){
  
  ## extract symbols
  symbols <- attr(prize, "symbols")
  
  ## collapse symbols into single string
  symbols <- paste(symbols, collapse = " ")
  
  ## combine symbol with prize as a regular expression
  # \n is regular expression for new line (i.e. return or enter)
  string <- paste(symbols, prize, sep = "\n$")
  
  # display regular expression in console without quotes
  cat(string)
}

slot_display(one_play)

#one_play’s symbols attribute to do the job. symbols will be a vector of three-character strings
symbols <- attr(one_play, "symbols")
symbols

#symbols becomes B 0 B the three strings separated by a space
symbols <- paste(symbols, collapse = " ")
symbols

#value is \n$, so our result will look like "B 0 B\n$0
prize <- one_play
string <- paste(symbols, prize, sep = "\n$")
string

cat(string)

# use slot_display to manually clean up the output of play
slot_display(play())

#generic functions
print(pi)

print(head(DECK))

head(DECK)
print(play())

play()

#print did one thing when we looked at the unclassed version of num
num <- 1000000000 
print(num)

#a different thing when we gave num a class
class(num) <- c("POSIXct", "POSIXt") 
print(num)

#METHODS
print

#run print.POSIXct and return the results
print.POSIXct

#UseMethod will pass all of print’s arguments to print.factor. R will then run print.factor and return the results
print.factor

#print has almost 200 methods (which gives you an idea of how many classes exist in R)
methods(print)

#Method Dispatch
class(one_play) <- "slots"

args(print)

print.slots <- function(x, ...) { 
  cat("I'm using the print.slots method")
}

#exercise
print.slots <- function(x, ...) { 
  slot_display(x)
}

play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols, class = "slots")
}

#each of our slot machine plays will have the class slots
class(play())

#R will display them in the correct slot-machine format
play()

#classes
methods(class = "factor")

#R drops attributes (like class) when it combines objects into a vector
play1 <- play() 
play1

c(play1, play2)

