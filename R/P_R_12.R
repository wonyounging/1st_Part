install.packages("plotly")
library(plotly)
library(ggplot2)
ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()

p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()
ggplotly(p)

d <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) + geom_bar(position = "dodge")

ggplotly(d)

# 인터렉티브 시계열 그래프 만들기
install.packages("dygraphs")
library(dygraphs)
eco <- ggplot2::economics
head(eco)
library(xts)
eco1 <- xts(eco$unemploy, order.by = eco$date)
dygraph(eco1)

dygraph(eco1) %>% dyRangeSelector()

# 저축률
eco_a <- xts(eco$psavert, order.by = eco$date)

# 실업자수
eco_b <- xts(eco$unemploy / 1000, order.by = eco$date)

eco2 <- cbind(eco_a, eco_b) # 서로 다른 열 합치기

# 컬럼명 바꾸기
# rename은 xts 타입에서 사용이 불가능
colnames(eco2) <- c("psavert", "unemploy")
dygraph(eco2) %>% dyRangeSelector()
