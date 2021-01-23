
#Hannah Bohle, 11.01. 2021
library(shiny)
#library(shinythemes)
library(dplyr)
library(wordcloud)
#library(DT)
#library(here)

#df <- read.csv("data/Berlin_with_year.csv")
#df <- read.csv("D:/Dropbox/R_wissen/berlin_name_year/data/Berlin_with_year.csv")


server <- function(input, output) {
  df <- read.csv("data/Berlin_with_year_final.csv")
  filtered_kiez <- reactive({
    df %>%
        filter(Kiez == input$kiezId)
  })
  
  filtered_gender <- reactive({
      filtered_kiez() %>% 
        filter(geschlecht == input$genderId)
  })
  

  filtered_year <- reactive({
    filtered_gender() %>% 
      filter(year == input$yearId) 
  })
  
   one_filtered <- reactive({
     filtered_year() %>% 
       filter(filtered_year()$anzahl == 1)
   })
  
  fully_filtered <- eventReactive(input$select, {
    filtered_year()
  })

  output$plot <- renderPlot({
    p<-wordcloud(words = fully_filtered()$vorname, freq = fully_filtered()$anzahl, colors=brewer.pal(8,"BrBG"),min.freq = 10, max.words=200, random.order=FALSE, rot.per=0.35,scale=c(3.5,0.25))
    print(p)
  })
  
  output$result <-renderTable({
    one_filtered()
  })
  
  # output$plot2 <- renderPlot({
  #   p<-wordcloud(words = fully_filtered()$vorname, freq = fully_filtered()$anzahl, colors=brewer.pal(8,"BrBG"),min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35,scale=c(3.5,0.25))
  #   print(p)
  #})
}

# Run the application 
#shinyApp(ui = ui, server = server)
