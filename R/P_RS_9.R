install.packages("shiny")
library(shiny)
ui <- fluidPage("사용자 인터페이스!")
server <- function(input, output, session){ }
shinyApp(ui, server)

# 샤이니 샘플 확인
runExample()

runExample("01_hello")
runExample("02_text")
runExample("03_reactivity")
runExample("04_mpg")
runExample("05_sliders")
runExample("06_tabsets")
runExample("07_widgets")
runExample("08_html")
runExample("09_upload")
runExample("10_download")
runExample("11_timer")


faithful <- faithful
head(faithful)

ui <- fluidPage(
  titlePanel("샤이니 1번 샘플"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "bins",
                    label = "막대(bins) 개수:",
                    min = 1, max = 50, value=30)),
    mainPanel(
      plotOutput(outputId = "distPlot"))
))
server <- function(input, output, session){
  output$distPlot <- renderPlot({
    x <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "다음 분출 때까지 대기 시간(분)",
         main = "대기 시간 히스토그햄")
  })
}
shinyApp(ui, server)

# 9-2 입력과 출력하기
ui <- fluidPage(
  sliderInput("range", "연비", min = 0, max = 35, value = c(0, 10)),
  textOutput("value"))

server <- function(input, output, session) {
  output$value <- renderText((input$range[1] + input$range[2]))}

shinyApp(ui, server)

# 9-3 반응형 웹 애플리이션
# install.packages("DT")
library(DT)
library(ggplot2)
mpg <- mpg
head(mpg,2)

ui <- fluidPage(
  sliderInput("range", "연비", min = 0, max = 35, value = c(0, 10)),
  DT::dataTableOutput("table"))

server <- function(input, output, session){
  cty_sel = reactive({
    cty_sel = subset(mpg, cty = input$range[1] & cty <= input$range[2])
    return(cty_sel)})
  output$table <- DT::renderDataTable(cty_sel())}

shinyApp(ui, server)

# 9-4 레이아웃 정의하기
ui <- fluidPage(
  fluidRow(
    column(9, div(style = "height:450px;border: 4px solid red;", "폭 9")),
    column(3, div(style = "height:450px;border: 4px solid purple;", "폭 3")),
    column(12, div(style = "height:400px;border: 4px solid blue;", "폭 12"))))

server <- function(input, output, session) {}

shinyApp(ui, server)


ui <- fluidPage(
  fluidRow(
    column(9, div(style = "height:450px;border: 4px solid red;", "폭 9")),
    column(3, div(style = "height:450px;border: 4px solid purple;", "폭 3")),
  tabsetPanel(
    tabPanel("탭1",
             column(4, div(style = "height:300px;border: 4px solid red;", "폭 4")),
             column(4, div(style = "height:300px;border: 4px solid red;", "폭 4")),
             column(4, div(style = "height:300px;border: 4px solid red;", "폭 4"))),
    tabPanel("탭2,", div(style = "height:300px;border: 4px solid blue;", "폭 12")))))

server <- function(input, output, session) {}

shinyApp(ui, server)