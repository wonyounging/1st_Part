# 4장
# 데이터 프레임 만들기
english <- c(90, 80, 60, 70)
math <- c(50, 60, 100, 20)
df_midterm <- data.frame(english, math)
df_midterm
class <- c(1, 1, 2, 2)
df_midterm <- data.frame(english, math, class)
df_midterm

df_midterm2 <- data.frame(english = c(90, 80, 70), math = c(20, 30, 40), class = c(1, 2, 3))
df_midterm2

# 외부 데이터 이용하기
install.packages("readxl")
library(readxl)
df_exam <- read_excel("R/data/excel_exam.xlsx")
df_exam

mean(df_exam$english)  
mean(df_exam$science)

df_exam_novar <- read_excel("R/data/excel_exam_novar.xlsx", col_names = F)
df_exam_novar

df_exam_sheet <- read_excel("R/data/excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet

write.csv(df_midterm, file = "R/data/df_midterm.csv")

saveRDS(df_midterm, file='R/df_midterm2.rds')

rm(df_midterm)
rm(df_midterm2)

df_midterm <- readRDS('R/df_midterm2.rds')

exam <- read.csv("R/data/csv_exam.csv")
head(exam) # 6행
head(exam, 10) # 10행
tail(exam) # 뒤에서 6행
tail(exam, 10) # 뒤에서 10행
View(exam) # 뷰창에서 데이터 확인
dim(exam) # 행, 열 출력
str(exam) # 데이터 속성 확인
summary(exam) # 컬럼 정보 요약 출력


#ggplot mpg데이터 데이터 프레임 형태로 불러오기
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)
tail(mpg, 2)
View(mpg)
dim(mpg)
summary(mpg)


# 변수명 바꾸기
install.packages("dplyr")
library(dplyr)
df_raw <- data.frame(var1 = c(1,2,3), var2 = c(2,3,4))
df_raw
df_new <- df_raw
df_new <- rename(df_new, v2 = var2)
df_new

mpg_new <- mpg
mpg_new <- rename(mpg_new, city = cty, highway = hwy)
head(mpg_new, 2)


# 파생변수 만들기
df <- data.frame(var1 = c(4, 3, 8), var2 = c(2, 6, 1))
df
df$var1
df$var2
df$var1 + df$var2
df$var_sum <-  df$var1 + df$var2
df
df$var_mean <-  (df$var1 + df$var2) / 2
df

head(mpg,2)
mpg$total <-  (mpg$cty + mpg$hwy) / 2
head(mpg, 2)
summary(mpg$total)
hist(mpg$total)

# total을 기준으로 A~C 등급 부여
mpg$grade <- ifelse(mpg$total >= 30, 'A', ifesle(mpg$total >= 20, 'B', 'C'))

head(mpg, 20)
table(mpg$grade)
qplot(mpg$grade)

mpg(mpg,2)
mpg$grade2 <- ifelse(mpg$total >= 30, 'A',
                     mpg$total >= 25, 'B',
                     mpg$total >= 20, 'C', 'D')
table(mpg$grade2)
qplot(mpg$grade2)

