# 7 데이터 정제
# 결측치 제거
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))

# 결측치 확인
is.na(df)
table(is.na(df))
table(is.na(df$sex))
table(is.na(df$score))

library(dplyr)
df %>% filter(is.na(score))
df %>% filter(!is.na(score))

df %>% filter(is.na(sex))
df %>% filter(!is.na(sex))

df_nomiss <- df %>% filter(!is.na(score))
df_nomiss
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss

df_nomiss2 <- na.omit(df)
df_nomiss2

mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

exam <- read.csv("R/data/csv_exam.csv")
View(exam)

#행 3, 8, 15의 math컬럼에 NA값 할당
exam[c(3, 8, 5), "math"] <- NA
exam %>% 
  summarise(mean_math = mean(math))

# math 결측치 제외하고 평균 산출
exam %>% 
  summarise(mean_math = mean(math, na.rm = T))

exam %>% 
  summarise(mean_math = mean(math, na.rm = T), sum(math, na.rm = T), median(math, na.rm = T))

# 평균값으로 대체하기
mean(exam$math, na.rm = T)
table(is.na(exam$math))
exam$math <- ifelse(is.na(exam$math), 58, exam$math)
table(is.na(exam$math))
mean(exam$math)

# 혼자서 해보기
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA

# Q1
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# Q2
mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))


mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))


# 이상치 정제하기
outlier <- data.frame(sex = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))
table(outlier$sex)
table(outlier$score)

# sex = 3 이면 NA 할당
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
table(is.na(outlier$sex))

# score < 5 이면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
table(is.na(outlier$score))
outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))


boxplot(mpg$hwy)
# 12~37을 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)

# 결측치 확인
table(is.na(mpg$hwy))
mpg %>% group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))


# 혼자서 해보기
mpg[c(10, 14, 58, 93), "drv"] <- "k" # drv 이상치 할당
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42) # cty 이상치 할당

# Q1
table(mpg$drv)
mpg$drv <- ifelse(mpg$drv == "k", NA, mpg$drv)
table(mpg$drv)

mpg$drv <- ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)
table(mpg$drv)

# Q2
boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
boxplot(mpg$cty)

# Q3
mpg %>% 
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(cty_mean = mean(cty))
