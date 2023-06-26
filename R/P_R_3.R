a <- 1
b <- 2
a
c <- 3
d <- 3.5
a + b + c
4 / b
5 * b


var1 <- c(1,2,5,7,8)
var1
var2 <- c(1:5)
var2
var3 <- seq(1,5)
var3
var4 <- seq(1, 10, 2)
var4
var5 <- seq(1, 10, by = 3)
var5
var1 + var2
var1
var1 + 2


str1 <- "a"
str1
str2 <- 'b'
str2
str3 <- c("hello", "world")
str3
str4 <- c('a','b','c')
str4


x <- c(1,2,3)
# ?Ô¼?????
mean(x)
max(x)
min(x)
paste(str3, collapse = ",")
paste(str3, collapse = ' ')
x_mean <- mean(x)


install.packages("ggplot2")
library(ggplot2)
  x <- c("a", "a", "b", "c")
  # ???? ?×·???
  qplot(x)

# ?????Í¿? mpg, x?? hwy ??????Á¤?Ø¼? ?×·??? ????
qplot(data = mpg, x = hwy)

# x = drv, y = hwy
qplot(data = mpg, x = drv, y = hwy)

qplot(data = mpg, x = drv, y = hwy, geom = "line")
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot")
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)

?qplot

# ???À¹?Á¦1
25+99
456-123
2*(3+4)
(3+5*6)/7
(7-4)*3
2^10+3^5
1256%%7
184%%5
1976/24
16*25+186*5-67*22

# ???À¹?Á¦2
PI <- 3.14
r1 <- 10
r2 <- 15
r3 <- 20
r1*r1*PI
r2*r2*PI
r3*r3*PI


x <- c(6,8,10)
y = 2*x^2 + 5*x + 10
y

# ???À¹?Á¦3
d <- 101:200
d
d[10]
d[seq(91,100)]
tail(d,10)
d[seq(2,101,2)]
d[d%%2 == 0]
d.20 <- d[seq(0,20)]
d.20
d.20[-5]
d.20[-seq(5,9,2)]

# ???À¹?Á¦4
d1 <- 1:50
d2 <- 51:100
d1
d2
d1+d2
d2-d1
d1*d2
d2/d1
sum(d1)
sum(d2)
max(d2)
min(d2)
mean(d2)
mean(d1)
d1
sort(d1)
sort(d1, T)
d3 <- sort(d1, T)[1,10]

# ???À¹?Á¦5
v1 <- 51:90
v1[v1<60]
sum(v1<70)
sum(v1[v1>65])
v1[v1>60 & v1<73]
v1[v1>80 | v1<65]
v1[v1%%7 == 3]
sum(v1[v1%%2 == 0])
v1[v1%%2 == 1 |v1>80]
v1[v1%%3 == 0 &v1%%5 == 0]

# 77??????
score = c(80, 60, 70, 50, 90)
mean_score = mean(score)
mean_score
