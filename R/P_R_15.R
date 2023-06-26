exam <- read.csv("R/data/csv_exam.csv")
exam[] # [] 전체 행열
exam[1,] # 1행 추출
exam[2,] # 2행 추출

# class가 1반인 행 추출
exam[exam$class == 1, ]

# math가 80점 이상인 행 추출
exam[exam$math >= 80, ]

# 1반이면서 수학점수가 50점 이상
exam[exam$class == 1 & exam$math >= 50, ]

# 영어 점수가 90점 미만이거나 과학점수가 50점 미만
exam[exam$english < 90 | exam$science < 50, ]

# exam 열 추출
exam[ ,1] # 첫번째 열 출력
exam[ ,2] # 두번쨰 열 출력
exam[ ,"class"] # class 변수값 출력
exam[ ,"math"] # math 변수값 출력
exam[ ,c("math", "english", "science")]

# 행 변수 모두 가져오기
exam[1, 3]

# 행 인덱스 변수명(열 이름)
exam[5, "english"]
exam[exam$math >= 50, "english"]
exam[exam$math >= 50, c('english', 'science')]

exam$tot <- (exam$math + exam$science + exam$english) / 3
head(exam)

aggregate(data = exam[exam$math >= 50 & exam$english >= 80, ], tot~class, mean)

library(dplyr)
exam %>% 
  filter(math >= 50 & english >= 80) %>% 
  mutate(tot = (math + english + science) / 3) %>% 
  group_by(class) %>% 
  summarise(mean = mean(tot))

# 변수 타입
var1 <- c(1,2,3,1,2) # numeric 연속변수
var2 <- factor(c(1,2,3,1,2)) # 범주형 변수 factor

var1 + 2
var2 + 2

class(var1) # type을 확인
class(var2)

levels(var1)
levels(var2)

View(var2)

var3 <- c("a", "b", "b", "c")
var4 <- factor(c("a", "b", "b", "c"))

class(var3) # type을 확인
class(var4)

mean(var1)
mean(var2)

# 타입 변경
var2 <- as.numeric(var2)
class(var2)
mean(var2)
levels(var2)

head(mpg)
class(mpg$drv)

mpg$drv <- as.factor(mpg$drv)
class(mpg$drv)
levels(mpg$drv)

# 데이터 구조
a <- 1
a

b <- "hello"
b

class(a)
class(b)

# 데이터 프레임
x1 <- data.frame(var1 = c(1, 2, 3),
                 var2 = c("a", "b", "c"))
class(x1)

x2 <- matrix(c(1:12), ncol=2)
x2
class(x2)

x3 <- array(1:20, dim = c(2, 5, 2))
x3
class(x3)

# 리스트
x4 <- list(f1 = a, f2 = x1, f3 = x2, f4 = x3)

x <- boxplot(mpg$cty)
x$stats[,1] # 요약 통계량 추출
x$stats[,1][3] # 중앙값(median)
x$stats[,1][2] # 1분위 수
x$stats[,1][4]
