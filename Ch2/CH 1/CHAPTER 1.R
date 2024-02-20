
1+1
100:130

5- + +1
2*3

10+2
12*3
36-6
30/3

1:6

a<-1
a+2

die <- 1:6
die

Name <- 1
name <- 0
Name + 1
my_number <- 1
my_number <- 999
ls()

die-1
die/2
die * die

1:2
die
die + 1:2
die + 1:4

die %*% die
die %o% die

#functions
round(3.1415)
factorial(3)
mean(1:6)
mean(die)
round(mean(die))
sample(x = 1:4, size = 2)

sample(x = die, size = 1)
sample(die, size = 1)

round(3.1415, corners = 2)

args(round)

round(3.1415, digits = 2)
sample(die, 1)

sample(size = 1, x = die)
sample(die, size = 2)

sample(die, size = 2, replace = TRUE)
sample(die, size = 2, replace = TRUE)
dice <- sample(die, size = 2, replace = TRUE)
sum(dice)

dice

#writing your own functions
die <- 1:6
dice <- sample(die, size = 2, replace = TRUE)
sum(dice)

#the function constructor
my_function <- function() {}
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE) 
  sum(dice)
}

roll()

dice
1+1 
sqrt(2)

dice <- sample(die, size = 2, replace = TRUE) 
two<-1+1
a <- sqrt(2)

#arguments
roll2 <- function() {
  dice <- sample(bones, size = 2, replace = TRUE) 
  sum(dice)
}

#roll2()
roll2 <- function(bones) {
  dice <- sample(bones, size = 2, replace = TRUE) 
  sum(dice)
}

roll2(bones = 1:4)
roll2(1:20)

roll2 <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE) 
  sum(dice)
}
