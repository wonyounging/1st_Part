library(dplyr)
exam <- read.csv("R/data/csv_exam.csv")
head(exam)

# 데이터 합치기
test1 <- data.frame(id=c(1, 2, 3, 4, 5),
                    midterm=c(60, 80, 70, 90, 85))
test2 <- data.frame(id=c(1, 2, 3, 4, 5),
                    final=c(70, 83, 65, 95, 80))
total <- left_join(test1, test2, by="id")
total

# 담임선생님 명단
# 열 합치기
name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c('Kim', 'Lee', 'Park', 'Choi', 'Jung'))
name

exam_new <- left_join(exam, name, by="class")
head(exam_new)

# 행 합치기
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 70, 80, 90 ,85))
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(63, 73, 83, 93, 83))
group_c <- data.frame(id = c(6, 7, 8, 9, 10),
                      test1 = c(66, 77, 88, 99, 88))

View(group_a)
View(group_b)
group_all <- bind_rows(group_a, group_b)
group_all

group_call <- bind_rows(group_a, group_c)
group_call

# 혼자하기
mpg <- as.data.frame(ggplot2::mpg)
head(mpg,2)
mpg_new <- mpg

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel

# Q1
mpg_new <- left_join(mpg_new, fuel, by="fl")

# Q2
head(mpg_new,5)
mpg_new %>% 
  select(model, fl, price_fl) %>% 
  head(5)


# 분석 도전
midwest <- as.data.frame(ggplot2::midwest)
head(midwest,3)

midwest_child <- ((midwest$poptotal - midwest$popadults) / midwest$poptotal) * 100
head(midwest_child,2)

#Q1
midwest <- midwest %>% 
  mutate(midwest_child)
head(midwest,2)

#Q2
midwest %>% 
  arrange(desc(midwest_child)) %>% 
  select(county, midwest_child) %>% 
  head(5)

#Q3
midwest <- midwest %>% 
  mutate(grade = ifelse(midwest_child >= 40, "large", ifelse(midwest_child >=30, "middle", "small")))
table(midwest$grade)

#Q4
midwest <- midwest %>% 
  mutate(ais = (popasian / poptotal) * 100)
head(midwest,1)
midwest %>% 
  arrange(ais) %>% 
  select(state, county, ais) %>% 
  head(10)


