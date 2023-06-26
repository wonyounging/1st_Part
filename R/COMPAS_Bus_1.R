# 데이터 전처리 1 : 지역 정보
## 1단계_집계구 만들기
### 화성시 경계 데이터 불러오기
library(sp)

install.packages("geojsonio")
library(geojsonio)

dir.create("./01_save")

# 행정동 geojson 불러오기
admin <- geojsonio::geojson_read("./SBJ_1910_001/tl_scco_emd.geojson", what = 'sp')
save(admin, file="./01_save/01_001_admin.rdata")
plot(admin)


### 집계구 외곽 경계 만들기
library(sp)
library(raster)
library(leaflet)

# 외곽 경계 만들기
fishnet <- as(raster::extent(126.50625, 127.42245, 36.99653, 37.483419), "SpatialPolygons")
proj4string(fishnet) <-  "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +tow-gs84=0,0,0"

plot(fishnet,border="red")
plot(admin, add=T)


### 집계구 만들기
# 래스터 변환
fishnet <- raster(fishnet)
# 0.1도 단위로 분할
res(fishnet) <- .01
# 좌표계 투영
crs(fishnet) <- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
# 폴리곤으로 변환
fishnet <- rasterToPolygons(fishnet)
# 지도 시각화
leaflet() %>%  addTiles() %>% 
  addPolygons(data = fishnet, weight = 0.4, fillOpacity = 0) %>% 
  addPolygons(data = admin, color = "red")


### 셀별 일련번호 부여하기
fishnet$id
fishnet@data <- data.frame(id = 1:nrow(fishnet))
save(fishnet, file="./01_save/01_002_fishnet.rdata")
head(fishnet$id, 10)


## 2단계_버스노선 매핑 테이블 생성
### 정류장 정보 불러오기
sta_table