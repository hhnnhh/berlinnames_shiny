library(shiny)
library(wordcloud)
library(RColorBrewer)

# YEAR CHOICE Funktioniert nicht - warum? In welcher Reihenfolge werden die Filter angewendet?


server <- function(input, output,session) {
  #df <- read.csv("D:/Dropbox/R_wissen/berlin_names_year/data/berlin_with_year.csv")
  
  # observeEvent(D0(),{
  # updateSelectInput(session, "yearId", "Year",  choices = unique(df$year),selected = unique(df$year)[1])
  # })
 
  observeEvent(D1(),{
  #updateSelectInput(session, "yearId", "Year",  choices = unique(D1()$year),selected = unique(D1()$year)[1])
  updateSelectInput(session, "selectinputid", "Kiez to Select:",  choices = unique(D1()$kiez),selected = unique(D1()$kiez)[1])
  })
    
  D1 <-reactive({
    #df[df$year %in% input$yearId]
    df[df$gender %in% input$genderId]
   })
  
  #  D1 <-reactive({
  #    D0()[D0()$year %in% input$yearId]
  #    D0()[D0()$geschlecht %in% input$genderId]
  # })
  
  # D1  <- reactive({
  #   #df[df$year %in% input$yearId,]
  #   D0()[D0()$geschlecht %in% input$genderId,]
  # })
  
  D2 <- eventReactive(input$goButton1,{
   # D1()[D1()$geschlecht %in% input$genderId,] 
    D1()[D1()$kiez %in% input$selectinputid]
  })
  

   output$plot <- renderPlot({
     if (input$genderId == 'w')
       colors=brewer.pal(8,"BrBG")
       if (input$genderId == 'm')
      colors=brewer.pal(8, "PRGn")

     #ggplot(D2(),aes(x=vorname,y=anzahl, label=vorname)) + geom_text_interactive(stat = "identity")
     #treemap(D2(),index = c("vorname"),vSize ="anzahl")
     p<-wordcloud(words = D2()$vorname, freq = D2()$anzahl, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35,colors=colors,scale=c(3.5,0.25))
     print(p)
 })
  
  #ploting results as table
  # output$result <- renderTable({
  #   D2()
  # })
}