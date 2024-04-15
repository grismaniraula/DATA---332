#Environments

library(deal)
library(devtools)

setwd("~/Desktop/DATA - 332/CH 6")

cards <- read.csv('cards.csv')
deck <- read.csv('deck.csv')

deal(deck)

#return a list of the environments that your R session is using
parenvs(all = TRUE)

#working with environments
as.environment("package:stats")

#accessor functions
globalenv()
baseenv()
emptyenv()

#an environment’s parent with parent.env
parent.env(globalenv())

#empty environment is the only R environment without a parent
parent.env(emptyenv())

#ls or ls.str. ls will return just the object names
ls(emptyenv())

ls(globalenv())

#syntax to access an object in a specific environment
head(globalenv()$deck, 3)

#to save an object into a particular environment

assign("new", "Hello Global", envir = globalenv())
globalenv()$new

#The Active Environment
environment()

#assignment
new

#object named new exists in the global environment
new <- "Hello Active"
new

#roll function from Part I saved an object named die and an object named dice
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE) 
  sum(dice)
}

#evaluation
show_env <- function(){ 
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}

#create a runtime en‐ vironment to evaluate the function in
show_env()

#you can look up a function’s origin environment by running environment on the function
environment(show_env)
environment(parenvs)

#R will store any objects created by show_env in its runtime environment
show_env <- function(){ 
  a <- 1
  b <- 2
  c <- 3
list(ran.in = environment(),
     parent = parent.env(environment()),
     objects = ls.str(environment()))
}

show_env()

# put a second type of object in a runtime environment
foo <- "take me to your runtime"

show_env <- function(x = foo){ 
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}
show_env()

# global environment is the origin environment of deal
environment(deal)
deal()

#save a prisitine copy of deck and then remove the top card
DECK <- deck
deck <- deck[-1, ]
head(deck, 3)

deal <- function() { 
  card <- deck[1, ] 
  deck <- deck[-1, ] 
  card
}

#exercise
deal <- function() {
  card <- deck[1, ]
  assign("deck", deck[-1, ], envir = globalenv())
  card
}

deal()

#shuffle function
shuffle <- function(cards) {
  random <- sample(1:52, size = 52) 
  cards[random, ]
}

head(deck, 3)

a <- shuffle(deck)
head(deck, 3)

#exercise
shuffle <- function(){
  random <- sample(1:52, size = 52)
  assign("deck", DECK[random, ], envir = globalenv())
}

#closures
shuffle()
deal()

#function that takes deck as an argument and saves a copy of deck as DECK
setup <- function(deck) { 
  DECK <- deck
  
DEAL <- function() {
  card <- deck[1, ]
  assign("deck", deck[-1, ], envir = globalenv()) 
  card
}

SHUFFLE <- function(){
  random <- sample(1:52, size = 52)
  assign("deck", DECK[random, ], envir = globalenv())
  }
}

#setup to return DEAL and SHUFFLE so we can use them
setup <- function(deck) {
  DECK <- deck
  
DEAL <- function() {
  card <- deck[1, ]
  assign("deck", deck[-1, ], envir = globalenv()) 
  card
}
SHUFFLE <- function(){
  random <- sample(1:52, size = 52)
  assign("deck", DECK[random, ], envir = globalenv())
}
list(deal = DEAL, shuffle = SHUFFLE)
}

cards <- setup(deck)

#save each of the elements of the list to a dedicated object in the global environment
deal <- cards$deal
shuffle <- cards$shuffle

deal
shuffle

environment(deal)
environment(shuffle)

#reference their parent environment at runtime
setup <- function(deck) { 
  DECK <- deck
  
DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = parent.env(environment()))
    card
}

  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = parent.env(environment()))
}
  list(deal = DEAL, shuffle = SHUFFLE)
}
cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle

rm(deck)
shuffle()
deal()

deal()

