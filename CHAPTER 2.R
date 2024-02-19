setwd("~/Desktop/DATA - 332")
write.csv(deck, file = "cards.csv", row.names = FALSE)

die<-c(1,2,3,4,5,6)
five <- 5
is.vector(five)

#length returns the length of an atomic vector.
length(five)

length(die)

#create an integer vector by including a capital L with input.
int <- 1L
text <- "ace"

#make atomic vectors that have more than one element in them, you can combine an element with the c function
int <- c(1L, 5L)
text <- c("ace", "hearts")

#R will do math with atomic vectors that contain numbers
#sum(num)
sum(6)

#R won't do maths with atomic vectors that contain character strings
sum(text)

#R will save any number that you type in R as a double
die<-c(1,2,3,4,5,6)

#you can also ask R what type of object an object is with typeof
typeof(die)

#create an integer in R by typing a number followed by an uppercase L
int <- c(-1L, 2L, 4L)
typeof(int)

#square root of two cannot be expressed exactly in 16 significant digits. As a result, R has to round the quantity
#floating-point arithmetic
sqrt(2)^2 - 2

#create a character vector in R by typing a character or string of characters surrounded by quotes
text <- c("Hello", "World")
typeof("Hello")

#Logical vectors store TRUEs and FALSEs, R’s form of Boolean data
3>4

#Any time you type TRUE or FALSE in capital letters (without quotation marks), R will treat your input as logical data
logic <- c(TRUE, FALSE, TRUE)

#create a complex vector, add an imaginary term to a number with i:
comp<-c(1+1i,1+2i,1+3i)

#Raw vectors store raw bytes of data
raw(3)

#create character vector with the c function if you surround each name with quotation marks
#to create an atomic vector that stores just the face names of the cards in a royal flush
hand <- c("ace", "king", "queen", "jack", "ten")

#attributes will return NULL if an object has no attributes
attributes(die)

#if a die does not have a names attribute, it gives NULL
names(die)

#give a name to die by as‐ signing a character vector to the output of names
names(die) <- c("one", "two", "three", "four", "five", "six")

#now die has a names attribute:
names(die)

# use names to change the names attribute or remove it all together

#to change the names, assign a new set of labels to names:
names(die) <- c("uno", "dos", "tres", "quatro", "cinco", "seis")

#to remove the names attribute, set it to NULL:
names(die) <- NULL

#each dimension will have as many rows (or columns, etc.) as the nth value of the dim vector
dim(die) <- c(2, 3)
dim(die) <- c(1, 2, 3)

#matrices store values in a two-dimensional array, just like a matrix from linear algebra
m <- matrix(die, nrow = 2)

#matrix will fill up the matrix column by column by default, but you can fill the matrix row by row if you include the argument byrow = TRUE:
m <- matrix(die, nrow = 2, byrow = TRUE)

#stores the name and suit of every card in a royal flush.
hand1 <- c("ace", "king", "queen", "jack", "ten", "spades", "spades",
           "spades", "spades", "spades")
matrix(hand1, nrow = 5)
matrix(hand1, ncol = 2)
dim(hand1) <- c(5, 2)

#to fill the matrix row by row instead of column by column
hand2 <- c("ace", "spades", "king", "spades", "queen", "spades", "jack",
           "spades", "ten", "spades")
matrix(hand2, nrow = 5, byrow = TRUE) 
matrix(hand2, ncol = 2, byrow = TRUE)

#the array function creates an n-dimensional array
ar <- array(c(11:14, 21:24, 31:34), dim = c(2, 2, 3))

#changing the dimensions of your object will not change the type of the object, but it will change the object’s class attribute
dim(die) <- c(2, 3) 
typeof(die)
class(die)

#returns the current time on your computer
now <- Sys.time()

#POSIXct is a widely used framework for representing dates and times
mil <- 1000000
class(mil) <- c("POSIXct", "POSIXt")

#add a levels attribute to the integer, which contains a set of labels for displaying the factor values, and a class attribute, 
#which contains the class factor
gender <- factor(c("male", "female", "female", "male"))

#each atomic vector can only store one type of data. As a result, R coerces all of your values to character strings
#virtual playing card by combining “ace,” “heart,” and 1 into a vector
card <- c("ace", "hearts", 1)

#R uses the same coercion rules when you try to do math with logical values
#So the following code:
sum(c(TRUE, TRUE, FALSE, FALSE))

#will become
sum(c(1, 1, 0, 0))

#to convert data from one type to another with the as functions
as.character(1)
as.numeric(FALSE)

#list creates a list the same way c creates a vector 
#Separate each element in the list with a comma
list1 <- list(100:130, "R", list(TRUE, FALSE))

#Use a list to store a single playing card, like the ace of hearts, which has a point value of one
card <- list("ace", "hearts", 1)

#data frame will turn each vector into a column of the new data frame
df <- data.frame(face = c("ace", "two", "six"),
                 suit = c("clubs", "clubs", "clubs"), value = c(1, 2, 3))

#to give names to a list or vector when you create one of these objects
list(face = "ace", suit = "hearts", value = 1) 
c(face = "ace", suit = "hearts", value = "one")

#to prevent R to save characteer strings as factors
df <- data.frame(face = c("ace", "two", "six"),
                 suit = c("clubs", "clubs", "clubs"), value = c(1, 2, 3), 
                 stringsAsFactors = FALSE)

#
