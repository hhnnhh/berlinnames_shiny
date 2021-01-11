library(shiny)
library(wordcloud)
library(RColorBrewer)


server <- function(input, output,session) {
  #df <- read.csv("D:/Dropbox/R_wissen/berlin_names_year/berlinnames_shiny/Berlin_2019_with_new_columnname.csv")
  #df <- read.csv("D:/Dropbox/R_wissen/berlin_names_year/berlinnames_shiny/data/berlin_with_year_clean.csv")
  
  observeEvent(input$yearId, {
    updateSelectInput(session, "yearId", "Year:",  choices = unique(df$year),selected = unique(df$year)[1])
  })
  
  observeEvent(D1(),{
    updateSelectInput(session, "selectinputid", "Kiez to Select:",  choices = unique(D1()$Kiez),selected = unique(D1()$Kiez)[1])
  })
  
  D1  <- reactive({
    df[df$geschlecht %in% input$genderId,]
  })
  
  D2 <- eventReactive(input$goButton1,{
    D1()[D1()$Kiez %in% input$selectinputid,]
   # D1()[D1()$position %in% input$positionid ==1]
  })
  

   output$plot <- renderPlot({
     if (input$genderId == 'w')
       colors=brewer.pal(8,"BrBG")
       if (input$genderId == 'm')
      colors=brewer.pal(8, "PRGn")

     #ggplot(D2(),aes(x=vorname,y=anzahl, label=vorname)) + geom_text_interactive(stat = "identity")
     #treemap(D2(),index = c("vorname"),vSize ="anzahl")
     p1<-wordcloud(words = D2()$vorname, freq = D2()$anzahl, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35,colors=colors,scale=c(3.5,0.25))
     print(p1)
 })
  
  #ploting results as table
  # output$result <- renderTable({
  #   D2()
  # })
}