#EXPECTED VALUES

die <- c(1, 2, 3, 4, 5, 6)

#expand.grid
rolls <- expand.grid(die, die)

rolls$value <- rolls$Var1 + rolls$Var2 
head(rolls, 3)

#exercise
wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")

combos <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)
combos

#probability of getting each combination
get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE)
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52)
}

#exercise
prob <- c("DD" = 0.03, "7" = 0.03, "BBB" = 0.06,
          "BB" = 0.1, "B" = 0.25, "C" = 0.01, "0" = 0.52)

combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]

head(combos, 3)

combos$prob <- combos$prob1 * combos$prob2 * combos$prob3
head(combos, 3)

sum(combos$prob)

# calculate the prize for the first row of combos
symbols <- c(combos[1, 1], combos[1, 2], combos[1, 3])
score(symbols)

#for Loops
for (value in that) {
  this
}

#for loop below runs print("one run") once for each element in a vector of character strings
for (value in c("My", "first", "for", "loop")) {
  print("one run")
}

for (value in c("My", "second", "for", "loop")) {
  print(value)
}

#still contains the value of the last element in the set
value

#rewrite the previous loop with any of the following
for (word in c("My", "second", "for", "loop")) {
  print(word)
}

for (string in c("My", "second", "for", "loop")) {
  print(string)
}

for (i in c("My", "second", "for", "loop")) {
  print(i)
}

#loops won’t return anything if you remove the print call
for (value in c("My", "third", "for", "loop")) {
  value
}

#creates an empty vector of length 4
chars <- vector(length = 4)

#fill it with strings
words <- c("My", "fourth", "for", "loop")
for (i in 1:4) {
  chars[i] <- words[i]
}
chars

#create a new column in combos to store the results of the for loop
combos$prize <- NA
head(combos, 3)

#exercise
for (i in 1:nrow(combos)) {
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}

head(combos, 3)

#payout rate for the slot
sum(combos$prize * combos$prob)

#challenge
score <- function(symbols) 
diamonds <- sum(symbols == "DD")
cherries <- sum(symbols == "C")
  
# identify case
# since diamonds are wild, only non diamonds 
# matter for three of a kind and all bars
slots <- symbols[symbols != "DD"]
same <- length(unique(slots)) == 1
bars <- slots %in% c("B", "BB", "BBB")
  
# assign prize
if (diamonds == 3) { 
    prize <- 100
  } else if (same) {
    payouts <- c("7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[slots[1]])
  } else if (all(bars)) {
    prize <- 5
  } else if (cherries > 0) {
    # diamonds count as cherries
    # so long as there is one real cherry
    prize <- c(0, 2, 5)[cherries + diamonds + 1]
  } else {
    prize <- 0
}

#exercise
for (i in 1:nrow(combos)) {
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3]) 
  combos$prize[i] <- score(symbols)
}

#while loops
while (condition) {
  code
}

plays_till_broke <- function(start_with) {
  cash <- start_with
  n <- 0
  while (cash > 0) {
    cash <- cash - 1 + play()
    n <- n + 1
  }
  n
}

plays_till_broke(100)

#repeat loops
plays_till_broke <- function(start_with) { 
  cash <- start_with
  n <- 0
  repeat {
    cash <- cash - 1 + play() 
    n <- n + 1
    if (cash <= 0) {
      break
    } 
  }
  n
}

  
  
