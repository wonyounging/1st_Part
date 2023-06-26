library(ggplot2)
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)

# compact, suv 도시연비(cty)가 차이가 있는지 검증 추론통계(t-test 검정)
mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))
head(mpg_diff)
table(mpg_diff$class)

# t-test
t.test(data = mpg_diff, cty ~ class, var.equal = T)

# 일반 휘발유, 고급 휘발유 도시연비 t-test 검정
mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c('r', 'p')) # regular, premium
table(mpg_diff2$fl)
t.test(data = mpg_diff2, cty ~ fl, var.equal = T)

# 상관관계 분석(correlation)
eco <- as.data.frame(ggplot2::economics)
cor.test(eco$unemploy, eco$pce)

# 상관관계 행렬 히트맵 만들기
head(mtcars)
car_cor <- cor(mtcars)

install.packages("corrplot")
library(corrplot)

corrplot(car_cor)
corrplot(car_cor, method = "number")

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(car_cor, method = 'color', col = col(200),
         type = "lower", order = "hclust", addCoef.col = "black",
         tl.col = "black", tl.srt = 45, diag = F)
