library(dplyr)
exam <- read.csv('R/data/csv_exam.csv')
head(exam,2)

# exam에서 class가 1인 경우 추출
exam %>% filter(class == 1) # %>% 단축키 ctrl + shift + m

# class가 2인 경우 추출
exam %>% filter(class == 2)

# 1반이 아닌경우 !=
exam %>% filter(class != 1)

# 3반이 아닌경우 !=
exam %>% filter(class != 3)

# 수학점수가 50점 초과한 경우
exam %>% filter(math > 50)

# 수학점수가 50점 미만인 경우
exam %>% filter(math <50)

# 영어점수가 80점 이상인 경우
exam %>% filter(english >= 80)

# 영어점수가 80점 이하인 경우
exam %>% filter(english <= 80)

# &
# 1반이면서 수학점수가 50점 이상
exam %>% filter(class == 1 & math >= 50)

# 2반이면서 영어점수가 80점 이상
exam %>% filter(class == 2 & math >= 80)

# |
# 수학점수가 90점 이상이거나 영어점수가 90점 이상인 경우
exam %>%  filter(math >= 90 | english >= 90)

# 영어점수가 50점 미만이거나 과학점수가 90점 미만인 경우
exam %>% filter(english < 50 | science < 90)

# 1, 3 5반의 해당되면 추출
exam %>% filter(class == 1 | class == 3 | class == 5)
exam %>% filter(class %in% c(1,3,5))

# class가 1인 행을 추출해서 1반의 수학 평균 구하기
# class가 2인 행을 추출해서 2반의 수학 평균 구하기
class1 <- exam %>% filter(class == 1)
mean(class1$math)

class2 <- exam %>% filter(class == 2)
mean(class2$math)

# 혼자서 해보기
# Q1
mpg <- as.data.frame(ggplot2::mpg)
head(mpg,2)
di4 <- mpg %>% filter(mpg$displ <= 4)
di4_avg <- (di4$cty + di4$hwy) / 2
mean(di4_avg)
di5 <- mpg %>% filter(mpg$displ >= 5)
di5_avg <- (di5$cty + di5$hwy) / 2
mean(di5_avg)

# Q2
audi_model <- mpg %>% filter(mpg$manufacturer == 'audi')
audi_cty_avg <- mean(audi_model$cty)
audi_cty_avg
toyota_model <- mpg %>% filter(mpg$manufacturer == 'toyota')
toyota_cty_avg <- mean(toyota_model$cty)
toyota_cty_avg

# Q3
mpg_new <- mpg %>% filter(mpg$manufacturer %in% c('chevolet','ford','honda'))

chevo_model <- mpg %>% filter(mpg$manufacturer == 'chevolet')
ford_model <- mpg %>% filter(mpg$manufacturer == 'ford')
honda_model <- mpg %>% filter(mpg$manufacturer == 'honda')
chevo_hwy <- mean(chevo_model$hwy)
ford_hwy <- mean(ford_model$hwy)
honda_hwy <- mean(honda_model$hwy)

mean(chevo_hwy + ford_hwy + honda_hwy)


# select()
exam %>% select(math)
exam %>% select(english)
exam %>% select(class, math, english)
exam %>% select(-math)
exam %>% select(-math, -english)



# class가 1반이면서 english만 추출
exam %>%  filter(class == 1) %>%  select(english)

exam %>%
  filter(class == 1) %>%
  select(english)

# id, math 추출 앞에 6개만 추출
head(exam %>% select(id, math))
exam %>% select(id, math) %>% head

# id, math 추출 앞에 10개만 추출
exam %>% select(id, math) %>% head(10)


# 혼자서 해보기
# Q1
mpg_clct <- mpg %>% select(class, cty)
mpg_clct

# Q2
mpg_clct_suv <- mpg_clct %>% filter(class == 'suv')
mpg_clct_compact <- mpg_clct %>% filter(class == 'compact')
mean(mpg_clct_compact$cty); mean(mpg_clct_suv$cty)


# 정렬
exam %>% arrange(math)        # 오름차순
exam %>% arrange(desc(math)) # 내림차순
exam %>% arrange(class, math)


# 혼자서 해보기
mpg_audi <- mpg %>% filter(manufacturer == 'audi')
head(mpg_audi %>% arrange(desc(hwy)),5)


# 파생변수 추가하기
exam %>% mutate(total = math + english + science)

exam %>% mutate(total = math + english + science,
                mean = (math + english + science) / 3) %>% head

exam %>%
  mutate(total = math + english + science) %>%
  arrange(desc(total)) %>%
  head

exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head


# 혼자하기
# Q1
new_mpg <- mpg
new_mpg %>% mutate(tot = mean(hwy + cty)) %>% 
  arrange(desc(tot)) %>% 
  head(3)


exam %>% summarise(mean_math = mean(math))

exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math), sum_math = sum(math),
            median_math = median(math), n = n())


mpg %>%
  group_by(manufacturer) %>% 
  filter(class == 'suv') %>% 
  mutate(tot = (cty + hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)


head(mpg,2)
mpg %>% 
  group_by(class) %>% 
  summarise(mean_city = mean(cty)) %>% 
  arrange(desc(mean_city))

mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

mpg %>% 
  filter(class == "compact") %>% 
  group_by(manufacturer) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))