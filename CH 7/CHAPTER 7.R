#PROGRAMS
library(play)

play()

#The symbols are selected randomly, and each symbol appears with a different probability

get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0") 
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

#get_symbols to generate the symbols used in your slot machine
get_symbols()

#to create the full slot machine
play <- function() { 
  symbols <- get_symbols() 
  print(symbols) 
  score(symbols)
}

#sequential steps
play <- function() {
  symbols <- get_symbols()
  print(symbols)
  score(symbols)
}

#if Statements

if (this) { 
  that
}

if (num < 0) { 
  num <- num * -1
}

#If num < 0 is TRUE, R will multiply num by negative one, which will make num positive
num <- -2
if (num < 0) { 
  num <- num * -1
}
num

#If num < 0 is FALSE, R will do nothing and num will remain as it is—positive (or zero)
num <- 4
if (num < 0) { 
  num <- num * -1
}
num

#if num begins as a negative number. R will skip the entire code block
num <- -1

if (num < 0) {
  print("num is negative.") 
  print("Don't worry, I'll fix it.") 
  num <- num * -1
  print("Now num is positive.")
}
num

#else statements
if (this) { 
  Plan A
} else { 
  Plan B
}

a <- 3.14

dec <- a - trunc(a) 
dec

#if else tree to round the number
if (dec >= 0.5) {
  a <- trunc(a) + 1
} else {
  a <- trunc(a)
}
a

#two mutually exclusive cases, to string multiple if and else statements together

a <- 1 
b <- 1

if (a > b) { 
  print("A wins!")
} else if (a < b) { 
  print("B wins!")
} else { 
  print("Tie.")
}

score <- function(symbols) {
  
  prize
}

#to run the code for many of your subtasks on the vector as you go
symbols <- c("7", "7", "7")
symbols <- c("B", "BB", "BBB")
symbols <- c("C", "DD", "0")

symbols
symbols[1] == symbols[2] & symbols[2] == symbols[3]  
symbols[1] == symbols[2] & symbols[1] == symbols[3]
all(symbols == symbols[1])

#checking three of a kind
length(unique(symbols) == 1)

#add it to your slot-machine script
same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]

#exercise
symbols[1] == "B" | symbols[1] == "BB" | symbols[1] == "BBB" &
  symbols[2] == "B" | symbols[2] == "BB" | symbols[2] == "BBB" &
  symbols[3] == "B" | symbols[3] == "BB" | symbols[3] == "BBB"

#a test is true for each element in a vector with all
all(symbols %in% c("B", "BB", "BBB"))

same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
bars <- symbols %in% c("B", "BB", "BBB")

symbols <- c("B", "B", "B") 
all(symbols %in% c("B", "BB", "BBB"))

if (same) 
  symbol <- symbols[1]
  if (symbol == "DD") {
    prize <- 800
  } else if (symbol == "7") {
    prize <- 80
  } else if (symbol == "BBB") {
    prize <- 40
  } else if (symbol == "BB") {
    prize <- 5
  } else if (symbol == "B") {
    prize <- 10
  } else if (symbol == "C") {
    prize <- 10
  } else if (symbol == "0") 
    prize <- 0

#lookup tables
payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
             "B" = 10, "C" = 10, "0" = 0)
payouts

payouts["DD"]

symbols <- c("7", "7", "7")
symbols[1]

#inefficient
same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
bars <- symbols %in% c("B", "BB", "BBB")

cherries <- sum(symbols == "C")
if (cherries == 2) { 
  prize <- 5
} else if (cherries == 1) { 
  prize <- 2
} else {} 
prize <- 0

c(0, 2, 5)

cherries + 1
c(0, 2, 5)[cherries + 1]
cherries + 1
c(0, 2, 5)[cherries + 1]

#when cherries equals three
cherries + 1
c(0, 2, 5)[cherries + 1]

#return the correct prize for each number of cherries
same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
bars <- symbols %in% c("B", "BB", "BBB")

if (same) {
  payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
               "B" = 10, "C" = 10, "0" = 0)
  prize <- unname(payouts[symbols[1]])
} else if (all(bars)) { prize <- 5
} else {
  cherries <- sum(symbols == "C") 
  prize <- c(0, 2, 5)[cherries + 1]
}
diamonds <- sum(symbols == "DD")

#to double the prize once for every diamond present

#f no diamonds are present
prize * 1

#If one diamond is present
prize * 2

#If two diamonds are present
prize * 4

# if three diamonds are present
prize * 8

#exercise
prize * 2 ^ diamonds

same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
bars <- symbols %in% c("B", "BB", "BBB")

if (same) 
  payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
               "B" = 10, "C" = 10, "0" = 0)
  prize <- unname(payouts[symbols[1]])
if (all(bars)) {
  prize <- 5
}  else {
    cherries <- sum(symbols == "C") 
    prize <- c(0, 2, 5)[cherries + 1]
  }

#code comments
# identify case
same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
bars <- symbols %in% c("B", "BB", "BBB")

# get prize
if (same) 
  payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
               "B" = 10, "C" = 10, "0" = 0)
  prize <- unname(payouts[symbols[1]])
  if (all(bars)) 
    prize <- 5
    
  

  
  