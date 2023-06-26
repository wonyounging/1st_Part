install.packages("foreign") # spss 사용하는 파일을 로드하기 위한 패키지
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

# 데이터 불러오기
raw_welfare <- read.spss(file = "R/data/Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
View(raw_welfare)
welfare <- raw_welfare # 복사본 만들기

# 데이터 탐색
head(welfare, 2)
tail(welfare, 2)
str(welfare)
summary(welfare)

# 변수명 바꿔보기
welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_region = h10_reg7)
View(welfare)

# 전처리
table(welfare$sex)
class(welfare$sex)

# 이상치 결측치 처리
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)

# 결측치 확인
table(is.na(welfare$sex))

# 성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, "Male", "Female")
table(welfare$sex )
qplot(welfare$sex)

# 월급 정보
class(welfare$income)
summary(welfare$income)
qplot(welfare$income)
qplot(welfare$income) + xlim(0,1000)

# 이상치 결측처리
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)

# 결측치 확인
table(is.na(welfare$income))

# 성별 월급 평균표 만들기
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))
sex_income
ggplot(data = sex_income, aes(x=sex, y=mean_income)) + geom_col()

# 생일 정보
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

# 나이 이상치 결측처리
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

# 나이 추출
welfare$age <- 2015 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)


# 필터 !na 그룹 age summa~income
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))

head(age_income)

ggplot(data = age_income, aes(x=age, y=mean_income)) + geom_line()

# 연령대 별로
welfare <- welfare %>% 
  mutate(ageg = ifelse(age < 30, "Young", ifelse(age <= 59, "Middle", "Old")))
table(welfare$ageg)
qplot(welfare$ageg)

# 연령대에 따른 월급 차이 분석
ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ggplot(data = ageg_income, aes(x=ageg, y=mean_income)) + geom_col() + scale_x_discrete(limits = c("Young", "Middle", "Old"))

# 연령대별 성별 월급의 차이
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))

sex_income

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) + geom_col() + scale_x_discrete(limits = c("Young", "Middle", "Old"))

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) + geom_col(position = "dodge") + scale_x_discrete(limits = c("Young", "Middle", "Old"))

# 성별 연령별 월급 평균표
sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))

ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + geom_line()


# 직업별 월급 차이
list_job <- read_excel("R/data/Koweps_Codebook.xlsx", col_names = T, sheet = 2)

head(list_job)
dim(list_job)
class(list_job)
table(list_job)
welfare <- left_join(welfare, list_job, by = "code_job")
welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)

job_income <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))
head(job_income)

top10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)
top10

bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)
bottom10

ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) + geom_col() + coord_flip()

ggplot(data = bottom10, aes(x = reorder(job, mean_income), y = mean_income)) + geom_col() + coord_flip() + ylim(0, 120)


# 남성 직업빈도 상위 10개
job_male <- welfare %>%
  filter(!is.na(job) & sex == "Male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)
job_male

# 여성 직업빈도 상위 10개
job_female <- welfare %>% 
  filter(!is.na(job) & sex == "Female") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)
job_female

# 종교에 따른 이혼율
class(welfare$religion)
table(welfare$religion)

# 종교 유무에 이름 부여
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")
table(welfare$religion)
qplot(welfare$religion)

# 이혼변수 만들기
class(welfare$marriage)
table(welfare$marriage)

welfare$group_marriage <- ifelse(welfare$marriage == 1, 'marriage', ifelse(welfare$marriage == 3, 'divorce', NA))
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

# 종교여부에 따른 이혼율 분석
religion_marriage <-welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n), pct = round(n / tot_group * 100), 1)
religion_marriage

# 이혼 추출
divorce <- religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(religion, pct)
divorce
ggplot(data = divorce, aes(x = religion, y = pct)) + geom_col()

# 연령대별 이혼율
ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  count(ageg, group_marriage) %>% 
  group_by(ageg) %>% 
  mutate(pct = round(n / sum(n) * 100, 1))
ageg_marriage

# 초년 제외, 이혼 추출
ageg_divorce <- ageg_marriage %>% 
  filter(ageg != "Young" & group_marriage == "divorce") %>% 
  select(ageg, pct)
ageg_divorce
ggplot(data = ageg_divorce, aes(x = ageg, y = pct)) + geom_col()

# 연령대, 종교 유무, 결혼 상태별 비율표 만들기
ageg_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & ageg != "Young") %>% 
  group_by(ageg, religion, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n), pct = round(n / tot_group * 100, 1))
ageg_religion_marriage

# 연령대 및 종교 유무별 이혼율 표 만들기
df_divorce <- ageg_religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(ageg, religion, pct)
df_divorce
ggplot(data = df_divorce, aes(x = ageg, y = pct, fill=religion)) + geom_col(position = "dodge")


# 지역별 연령대 비율
table(welfare$code_region)

# 지역코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울", "수도권(인천/경기)", "부산/경남/울산", "대구/경북",
                                     "대전/충남", "강원/충북", "광주/전남/전북/제주도"))
list_region

head(welfare,1)
# 지역명 변수를 추가
welfare <- left_join(welfare, list_region, by = "code_region")
welfare %>% 
  select(code_region, region) %>% 
  head()

region_ageg <- welfare %>% 
  group_by(region, ageg) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n), pct = round(n / tot_group * 100, 1))
head(region_ageg)

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) + geom_col() + coord_flip()

# 노년층 비율을 내림차순
list_order_old <- region_ageg %>% 
  filter(ageg == "Old") %>% 
  arrange(pct)
list_order_old

# 지역명 순서 변수 만들기
order <- list_order_old$region
order

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) + geom_col() + coord_flip() + scale_x_discrete(limits = order)
