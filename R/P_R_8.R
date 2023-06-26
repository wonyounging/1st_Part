# 8. 그래프 만들기
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)

# x축 displ, y축 hwy
ggplot(data = mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)

# 혼자서 해보기
# Q1
ggplot(data = mpg, aes(x=cty, y=hwy)) + geom_point()

# Q2
midwest <- as.data.frame(ggplot2::midwest)
ggplot(data = midwest, aes(x=poptotal, y=popasian)) + geom_point() + xlim(0,500000) + ylim(0,10000)

library(dplyr)
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

ggplot(data = df_mpg, aes(x=reorder(drv, -mean_hwy), y=mean_hwy)) + geom_col()
ggplot(data = df_mpg, aes(x=reorder(drv, mean_hwy), y=mean_hwy)) + geom_col()

ggplot(data = mpg, aes(x = drv)) + geom_bar()
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

# 혼자서 해보기
# Q1
df <- mpg %>% 
  filter(mpg$class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(suv_mean = mean(cty)) %>% 
  arrange(desc(suv_mean)) %>% 
  head(5)
df  

ggplot(data = df, aes(x = reorder(manufacturer, -suv_mean), y = suv_mean)) + geom_col()

# Q2
ggplot(data = mpg, aes(x = class)) + geom_bar()

economics <- as.data.frame(ggplot2::economics)
head(economics,3)
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()

ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

class_mpg <- mpg %>%
  filter(class %in% c("compact", "subcompact", "suv"))
ggplot(data = class_mpg, aes(x = class, y = cty)) + geom_boxplot()
