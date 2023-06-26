load("./06_geodataframe/06_apt_price.rdata") # 실거 데이터 불러오기
library(sf)
apt_price <- st_drop_geometry(apt_price) # 공간 정보 제거
apt_price$py_area <- round(apt_price$area / 3.3, 0) # 크기 변환 (m^2 -> 평)
head(apt_price$py_area)

library(shiny)
ui <- fluidPage(
  titlePanel("아파트 가격 상관관계 분석"),
  sidebarPanel(
    # 선택 메뉴 1: 지역
    selectInput(
      inputId = "sel_gu",
      label = "지역을 선택하세요",
      choices = unique(apt_price$addr_1),
      selected = unique(apt_price$addr_1)[1]),
    
    # 선택 메뉴 2: 크기(평)
    sliderInput(
      inputId = "range_py",
      label = "평수",
      min = 0,
      max = max(apt_price$py_area),
      value = c(0,30)),
    
    # 선택 메뉴 3: X축 변수
    selectInput(
      inputId = "var_x",
      label = "X축 변수를 선택하시오",
      choices = list(
        "매매가(평당)"="py",
        "크기(평"="py_area",
        "건축 연도"="con_year",
        "층수"="floor"),
      selected = "py_area"),
      
      # 선택 메뉴 4: Y축 변수
      selectInput(
        inputId = "var_y",
        label = "Y축 변수를 선택하시오",
        choices = list(
          "매매가(평당)"="py",
          "크기(평"="py_area",
          "건축 연도"="con_year",
          "층수"="floor"),
        selected = "py"), # 기본 선택
      
      # 체크박스 1: 상관 계수
      checkboxInput(
        inputId = "corr_checked",
        label = strong("상관 계수"),
        value = TRUE),
      
      # 체크박스 2: 회귀 계수
      checkboxInput(
        inputId = "reg_checked",
        label = strong("회귀 계수"),
        value = TRUE)
      ),
    
    # main 패널
    mainPanel(
      h4("플로팅"),
      plotOutput("scatterPlot"),
      
      h4("상관 계수"),
      verbatimTextOutput("corr_coef"),
      
      h4("회귀 계수"),
      verbatimTextOutput("reg_fit")
    )
)

server <- function(input, output, session){
  apt_sel = reactive({
    apt_sel = subset(apt_price,
                     addr_1 == input$sel_gu &
                       py_area >= input$range_py[1] &
                       py_area <= input$range_py[2])
    return(apt_sel)
    })
  
  output$scatterPlot <- renderPlot({
    var_name_x <- as.character(input$var_x)
    var_name_y <- as.character(input$var_y)
    
    plot(
      apt_sel()[, input$var_x],
      apt_sel()[, input$var_y],
      xlab = var_name_x,
      ylab = var_name_y,
      main = "플로팅")
      fit <- lm(apt_sel()[, input$var_y] ~ apt_sel()[, input$var_x])
      abline(fit, col="red")
  })
  
  output$corr_coef <- renderText({
    if(input$corr_checked){
      cor(apt_sel()[, input$var_x],
          apt_sel()[, input$var_y])
    }
  })
  
  output$reg_fit <- renderPrint({
    if(input$reg_checked){
      fit <- lm(apt_sel()[, input$var_y] ~ apt_sel()[,input$var_x])
      names(fit$coefficients) <- c("Intercept", input$var_x)
      summary(fit)$coefficients
    }
  })
}

shinyApp(ui, server)
