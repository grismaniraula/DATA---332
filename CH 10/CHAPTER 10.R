#SPEED

#Vectorized Code
#bs_loop uses a for loop to manipulate each element of the vector one at a time
abs_loop <- function(vec){
  for (i in 1:length(vec)) {
    if (vec[i] < 0) {
      vec[i] <- -vec[i]
    }
  }
  vec
}

#a vectorized version of abs_loop
abs_sets <- function(vec){ 
  negs <- vec < 0
  vec[negs] <- vec[negs] * -1
  vec
}

#a long vector of positive and negative numbers. long will contain 10 million values
long <- rep(c(-1, 1), 5000000)

#use system.time to measure how much time it takes each function to evaluate long
system.time(abs_loop(long))
system.time(abs_sets(long))

#exercise
system.time(abs(long))

#how to write a vectorized code
# use the same logical test to extract the set of negative values with logical subsetting
vec <- c(1, -2, 3, -4, 5, -6, 7, -8, 9, -10)
vec < 0

vec[vec < 0] * -1

#exercise
change_symbols <- function(vec){
  for (i in 1:length(vec)){
    if (vec[i] == "DD") {
      vec[i] <- "joker"
    } else if (vec[i] == "C") {
      vec[i] <- "ace"
    } else if (vec[i] == "7") {
      vec[i] <- "king"
    }else if (vec[i] == "B") {
      vec[i] <- "queen"
    } else if (vec[i] == "BB") {
      vec[i] <- "jack"
    } else if (vec[i] == "BBB") {
      vec[i] <- "ten"
    } else {
      vec[i] <- "nine"
    }
  }
  vec
}

vec <- c("DD", "C", "7", "B", "BB", "BBB", "0")
change_symbols(vec)

many <- rep(vec, 1000000)
system.time(change_symbols(many))

# create a logical test that can identify each case
vec[vec == "DD"]
vec[vec == "C"]
vec[vec == "7"]
vec[vec == "BBB"]
vec[vec == "B"]
vec[vec == "0"]

#code that can change the symbols for each case
vec[vec == "DD"] <- "joker"
vec[vec == "C"] <- "ace"
vec[vec == "7"] <- "king"
vec[vec == "B"] <- "queen"
vec[vec == "BB"] <- "jack"
vec[vec == "BBB"] <- "ten"
vec[vec == "0"] <- "nine"


#vectorized version of change_symbols that runs about 14 times faster
change_vec <- function (vec) {
  vec[vec == "DD"] <- "joker" 
  vec[vec == "C"] <- "ace"
  vec[vec == "7"] <- "king" 
  vec[vec == "B"] <- "queen"
  vec[vec == "BB"] <- "jack"
  vec[vec == "BBB"] <- "ten"
  vec[vec == "0"] <- "nine"
  vec
}
system.time(change_vec(many))

# Lookup tables are a vectorized method because they rely on R’s vectorized selection operations
change_vec2 <- function(vec){
  tb <- c("DD" = "joker", "C" = "ace", "7" = "king", "B" = "queen",
          "BB" = "jack", "BBB" = "ten", "0" = "nine")
  unname(tb[vec])
}

system.time(change_vec(many))

#How to Write Fast for Loops in R
#The first loop stores its values in an object named output that begins with a length of one million
system.time({
  output <- rep(NA, 1000000)
  for (i in 1:1000000) {
    output[i] <- i + 1
  }
})

#the loop takes 37 minutes longer to run than the first loop
system.time({
  output <- NA
  for (i in 1:1000000) {
    output[i] <- i + 1
  }
})

#vectorized code in practice
winnings <- vector(length = 1000000) 
for (i in 1:1000000) {
  winnings[i] <- play()
}

mean(winnings)

# Each row of the matrix will contain one slot combination to be scored
get_many_symbols <- function(n) {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  vec <- sample(wheel, size = 3 * n, replace = TRUE,
                prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
  matrix(vec, ncol = 3)
}
get_many_symbols(5)

symbols <- matrix(
  c("DD", "DD", "DD",
    "C", "DD", "0",
    "B", "B", "B",
    "B", "BB", "BBB",
    "C", "C", "0",
    "7", "DD", "DD"), nrow = 6, byrow = TRUE)
symbols

#advanced challenge
# symbols should be a matrix with a column for each slot machine window
score_many <- function(symbols) {
  # Step 1: Assign base prize based on cherries and diamonds ---------
  ## Count the number of cherries and diamonds in each combination
  cherries <- rowSums(symbols == "C")
  diamonds <- rowSums(symbols == "DD")
  
  # Wild diamonds count as cherries
  prize <- c(0, 2, 5)[cherries + diamonds + 1]
  
  ## ...but not if there are zero real cherries
  ### (cherries is coerced to FALSE where cherries == 0)
  prize[!cherries] <- 0
  
  # Step 2: Change prize for combinations that contain three of a kind
  same <- symbols[, 1] == symbols[, 2] &
    symbols[, 2] == symbols[, 3]
  payoffs <- c("DD" = 100, "7" = 80, "BBB" = 40,
               "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
  prize[same] <- payoffs[symbols[same, 1]]
  
  # Step 3: Change prize for combinations that contain all bars ------
  bars <- symbols == "B" | symbols ==  "BB" | symbols == "BBB"
  all_bars <- bars[, 1] & bars[, 2] & bars[, 3] & !same
  prize[all_bars] <- 5
  
  # Step 4: Handle wilds ---------------------------------------------
  ## combos with two diamonds
  two_wilds <- diamonds == 2
  
  ### Identify the nonwild symbol
  one <- two_wilds & symbols[, 1] != symbols[, 2] &
    symbols[, 2] == symbols[, 3]
  two <- two_wilds & symbols[, 1] != symbols[, 2] &
    symbols[, 1] == symbols[, 3]
  three <- two_wilds & symbols[, 1] == symbols[, 2] &
    symbols[, 2] != symbols[, 3]
  
  ### Treat as three of a kind
  prize[one] <- payoffs[symbols[one, 1]]
  prize[two] <- payoffs[symbols[two, 2]]
  prize[three] <- payoffs[symbols[three, 3]]
  
  ## combos with one wild
  one_wild <- diamonds == 1
  
  ### Treat as all bars (if appropriate)
  wild_bars <- one_wild & (rowSums(bars) == 2)
  prize[wild_bars] <- 5
  
  ### Treat as three of a kind (if appropriate)
  one <- one_wild & symbols[, 1] == symbols[, 2]
  two <- one_wild & symbols[, 2] == symbols[, 3]
  three <- one_wild & symbols[, 3] == symbols[, 1]
  prize[one] <- payoffs[symbols[one, 1]]
  prize[two] <- payoffs[symbols[two, 2]]
  prize[three] <- payoffs[symbols[three, 3]]
  
  # Step 5: Double prize for every diamond in combo ------------------
  unname(prize * 2^diamonds)
}

system.time(play_many(10000000))

