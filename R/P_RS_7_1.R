load("./06_geodataframe/06_apt_price.rdata")
library(sf)
grid <- st_read("R/seoul/seoul.shp")
apt_price <- st_join(apt_price, grid, join = st_intersects)
head(apt_price, 2)

# 2단계 그리드 + 평균 가격 결합
# 그리드별 평균 평당 계산
kde_high <- aggregate(apt_price$py, by=list(apt_price$ID), mean)
head(kde_high, 2)
colnames(kde_high) <- c("ID", "avg_price")
head(kde_high, 2)

# 3단계 결합
str(grid)
str(kde_high)

kde_high <- merge(grid, kde_high, by="ID")
head(kde_high, 2)

# 4단계 지도 그리기
library(ggplot2)
library(dplyr)
kde_high %>% ggplot(aes(fill=avg_price)) + geom_sf() +
  scale_fill_gradient(low = "white", high = "red")

# 5단계 지도의 경계
library(sp)
kde_high_sp <- as(st_geometry(kde_high), "Spatial") # sf형 -> sp형 변환 : 지도 작업을 수월하게 진행하기 위함

x <- coordinates(kde_high_sp)[,1]
y <- coordinates(kde_high_sp)[,2]

# bbox로 l1~l4까지 외곽 끝점을 나타내주는 좌표 4개를 추출하는데 약간의 여유를 주고자 0.1%를 추가함
l1 <- bbox(kde_high_sp)[1,1] - (bbox(kde_high_sp)[1,1]*0.0001)
l2 <- bbox(kde_high_sp)[1,2] + (bbox(kde_high_sp)[1,2]*0.0001)
l3 <- bbox(kde_high_sp)[2,1] - (bbox(kde_high_sp)[2,1]*0.0001)
l4 <- bbox(kde_high_sp)[2,2] + (bbox(kde_high_sp)[2,2]*0.0001)

install.packages("spatstat")
library(spatstat)
win <- owin(xrange = c(l1, l2), yrange = c(l3, l4))
plot(win)

rm(list = c("kde_high_sp", "apt_price", "l1", "l2", "l3", "l4"))
# 6단계 밀도 그래프 표시
p <- ppp(x, y, window = win) # 경계창 위에 좌표값 포인트 생성
d <- density(p, weights = kde_high$avg_price, sigma = bw.diggle(p), kernel = 'gaussian')
plot(d)
rm(list = c("x", "y", "win", "p"))

# 7단계 픽셀 이미지를 레스터 이미지로 변환
d[d < quantile(d)[4] + (quantile(d)[4]*0.1)] <- NA
# 전체 하위 75% NA처리
install.packages("raster")
library(raster)
raster_high <- raster(d)
plot(raster_high)

# 8단계 클리핑
bnd <-  st_read("R/sigun_bnd/seoul.shp") # 서울시 경계선 데이터
raster_high <- crop(raster_high, extent(bnd))

# 외곽선 자르기
crs(raster_high) <- sp::CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
# 좌표계 정의
plot(raster_high)
plot(bnd, col=NA, border = 'red', add = TRUE)

# 9단계 지돋 그리기
install.packages("rgdal")
library(rgdal)
library(leaflet)
leaflet() %>% 
  addProviderTiles(providers$CartoDB.Positron) %>% 
  addPolygons(data = bnd, weight = 3, color = "red", fill = NA) %>% 
  addRasterImage(raster_high, colors = colorNumeric(c("blue", "green", "yellow", "red"),
                                                  values(raster_high), na.color = "transparent"),
               opacity = 0.4)

dir.create("07_map")
save(raster_high, file = "./07_map/07_kde_high.rdata")

rm(list = ls()) # 메모리 정리


# 7-2 요즘 뜨는 지역은 어디일까?
load("./06_geodataframe/06_apt_price.rdata")
grid <- st_read("R/seoul/seoul.shp") # 서울시 1km 격자
apt_price <- st_join(apt_price, grid, join = st_intersects)
kde_before <- subset(apt_price, ymd < "2021-07-01")
kde_after <- subset(apt_price, ymd >= "2021-07-01")

# 전반기 ID별 가격 평균 집계
kde_before <- aggregate(kde_before$py, by=list(kde_before$ID), mean)
kde_after <- aggregate(kde_after$py, by=list(kde_after$ID), mean)
head(kde_before, 2)
colnames(kde_before) <- c("ID", "before")
head(kde_before, 2)
colnames(kde_after) <- c("ID", "after")
head(kde_after, 2)

kde_diff <- merge(kde_before, kde_after, by="ID")
kde_diff$diff <- round((((kde_diff$after - kde_diff$before) / kde_diff$before) * 100),0) # 증가율
head(kde_diff,2)

# 가격이 오른 지역 확인하기
library(sf)
kde_diff <- kde_diff[kde_diff$diff > 0, ] # 상승 지역만 추출
kde_hot <- merge(grid, kde_diff, by="ID")

library(ggplot2)
library(dplyr)
kde_hot %>% 
  ggplot(aes(fill=diff)) + geom_sf() + scale_fill_gradient(low = "white", high = "red")

kde_hot_sp <- as(st_geometry(kde_hot), "Spatial")

x <- coordinates(kde_hot_sp)[,1]
y <- coordinates(kde_hot_sp)[,2]

l1 <- bbox(kde_hot_sp)[1,1] - (bbox(kde_hot_sp)[1,1]*0.0001)
l2 <- bbox(kde_hot_sp)[1,2] + (bbox(kde_hot_sp)[1,2]*0.0001)
l3 <- bbox(kde_hot_sp)[2,1] - (bbox(kde_hot_sp)[2,1]*0.0001)
l4 <- bbox(kde_hot_sp)[2,2] + (bbox(kde_hot_sp)[2,2]*0.0001)

library(spatstat)
win <- owin(xrange = c(l1,l2), yrange=c(l3,l4)) # 외곽 좌표를 연결하는 지도 경계선 생성
plot(win) # 지도 경계선 확인

rm(list = c("kde_hot_sp","kde_diff","l1","l2","l3","l4"))

p <- ppp(x,y,window=win) # 경계선 위에 좌푯값 포인트 생성
d <- density.ppp(p, weights = kde_hot$diff, sigma=bw.diggle(p), kernel='gaussian') # 커널 밀도 함수로 변환 (kde_high$avg_price 가중치)
plot(d) # 밀도 그래프 확인

rm(list=c("x","y","win","p")) # 변수 정리

d[d<quantile(d)[4] + (quantile(d)[4]*0.1)] <- NA # 노이즈 제거(전체 하위 75% NA 처리)

raster_hot <- raster(d) # 래스터 변환
plot(raster_hot)

bnd <- st_read("R/sigun_bnd/seoul.shp") # 서울시 경계선 불러오기
raster_hot <- crop(raster_hot,extent(bnd)) # 외곽선 자르기
crs(raster_hot) <- sp::CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0") # 좌표계를 정의
plot(raster_hot) # 지도 확인
plot(bnd, col=NA, border = 'red', add=TRUE)

library(leaflet)
leaflet() %>% 
  addProviderTiles(providers$CartoDB.Positron) %>% 
  addPolygons(data = bnd, weight = 3, color = "red", fill = NA) %>% 
  addRasterImage(raster_hot, colors = colorNumeric(c("blue", "green", "yellow", "red"),
                                                    values(raster_hot), na.color = "transparent"),
                 opacity = 0.4)

save(raster_hot, file="./07_map/07_kde_hot.rdata")
rm(list = ls())
