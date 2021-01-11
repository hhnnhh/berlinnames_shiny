library(shiny)
library(wordcloud)
library(RColorBrewer)
getwd()


options(shiny.maxRequestSize=30*1024^2) 

server <- function(input, output,session) {
  #df <- read.csv("D:/Dropbox/R_wissen/berlin_names_year/berlinnames_shiny/Berlin_2019_with_new_columnname.csv")
  #df_check <- read.csv("data/berlin_with_year_final.csv")
  df <- read.csv("data/Berlin_with_year.csv")
  
  #observeEvent(input$yearId, {
  #observeEvent(D1(),{
   # updateSelectInput(session, "yearId", "Year",  choices = unique(D1()$year),selected = unique(D1()$year)[1])
  #})
  
  observeEvent(D1(),{
    updateSelectInput(session, "selectinputid", "Kiez to Select:",  choices = unique(D1()$Kiez),selected = unique(D1()$Kiez)[1])
  })
  
  D0  <- reactive({
    df[df$year %in% input$yearId,]
  })
  
  D1  <- reactive({
    D0()[D0()$geschlecht %in% input$genderId,]
  })
  
  D2 <- eventReactive(input$goButton1,{
    D1()[D1()$Kiez %in% input$selectinputid,]
   #D1()[D1()$year %in% input$yearId,]
  })


   output$plot <- renderPlot({
     # if (input$genderId == 'w'){
     #   color=brewer.pal(8,"BrBG")
     # } 
     # else{
     #   color=brewer.pal(8, "PRGn")
     # }

     #ggplot(D2(),aes(x=vorname,y=anzahl, label=vorname)) + geom_text_interactive(stat = "identity")
     #treemap(D2(),index = c("vorname"),vSize ="anzahl")
     p<-wordcloud(words = D2()$vorname, freq = D2()$anzahl, colors=brewer.pal(8, "PRGn"),min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35,scale=c(3.5,0.25))
  print(p)
 })
  
  #ploting results as table
  # output$result <- renderTable({
  #   D2()
  # })
}