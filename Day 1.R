#Basic
2+2

#Saving to Object
number <- 3
number
2*number
number <- 5
number*2

#Creating Vectors
c(1,2,3,4)

#Saving Vectors to Object
times <- c(17, 30, 25, 35, 25, 30, 40, 20)

#Minutes to Hours
times/60
times_hours<-times/60

#Various functions
mean(times)
range(times)
sqrt(times)

#Comparisons
#times > < == >= <= !=
#"NOT" is '!'
times>30
times == 17
which(times > 30)
#which() asks, 'Which of these is true?,' 'Which of 'times' are greater than 30?'
all(times > 30)
#all() asks 'Are these all true?,' 'Are all times greater than 30?'
any(times > 30)
#any() asks, "Are any true?,' 'Are there any 'times' greater than 30?'

#Getting help
help()
#same as ?, e.g. help(any)
?any()
?mean()

#Subsetting!!
times[times>30]
times[3]
#Gives us third value
times[-3]
#Gives us everything except for third value
#Minus sign means 'everything but __'
times[3:5]
#Gives third through fifth values
times[c(2,4)]
#Gives second and fourth value but not third value
times[-c(2,4)]
#Gives everything EXCEPT for second and fourth value

#Assign subset to object
#useful for values that aren't valid, outliers, etc.
times[1] <- 47
times
#Changes first value to 47!
times[times>30] <- NA
times
times[times > 30] <- c(0,1)
#This alternates replacing values greater than 30 with 0 or 1. If it replaces an odd number, 
#it will give you an error bc it did two 0s and only one 1.

#Start over
times <- c(17, 30, 25, 35, 25, 30, 40, 20)
times[1] <- 47
times[times>30] <- NA
mean(times)
#Gives NA because some are missing. Boooooo
mean(times, na.rm = TRUE)#if you press 'tab' it will show you additional possible arguments
#It's a good idea to name your arguments after one or two. Otherwise it gets confusing.
times[times > 20 & times < 35]
#Gives us times within range of 20-35. & function means both.
mean(times[times > 20 & times < 35], na.rm = TRUE)
# OR is | (vertical bar above enter key)
mean(times, trim = .2, TRUE)
#Trim cuts off top and bottom percentages (e.g. remove top and bottom 20%)

#dataframes and useful functions
mtcars
#^^ a dataframe
?mtcars
#^^ will give more info on the data
#head(), tail(), str(), nrow(), ncol(), summary(), row.names() (yuck), names()
#Some useful functions
head(mtcars)
tail(mtcars)
str(mtcars)
#Structure. Gives you information about the columns. Tells # of Ps and variables, etc.
names(mtcars)
#Tells column names (i.e. variables)
#Output in quotes tells you that it's a character, not a number. E.g. "1"

