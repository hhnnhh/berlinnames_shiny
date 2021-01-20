
#Hannah Bohle, 11.01. 2021
library(shiny)
#library(shinythemes)
library(dplyr)
library(wordcloud)
#library(DT)
#library(here)

#load(here::here('apps', 'df', 'df.RData'))
#df <- read.csv("Berlin_with_year_final.csv")



min_year <- min(df$year)
max_year <- max(df$year)


ui <- fluidPage(
  titlePanel("How are children in Berlin named?"),
  sidebarLayout(
      sidebarPanel(
        helpText("Displaying frequency of first names in Berlin by Kiez, gender, and year. source: Berlin open data."),
        
        #width = 2,
                 selectInput(
                   inputId = "kiezId",
                   label = "Kiez",
                   choices = unique(df$Kiez),
                   selected = "Charlottenburg-Wilmersdorf"
                 ),
        
        helpText("Data only available for binary gender.."),
                 selectInput(
                   inputId = "genderId",
                   label = "Gender",
                   choices = unique(df$geschlecht),
                   selected = "w"
                 ),
                 

                 sliderInput(
                   inputId = "yearId",
                   label = "Year", min = min_year, max = max_year,
                   round = 2, 
                   step = 1,
                   sep = "",
                   value = 2018
                   
                   
                 ),
                 
                 br(), 
                 
                 actionButton('select', 'Select'),
                 
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
      #tableOutput("result")
      tabPanel("Frequent names", plotOutput("plot")),
      tabPanel("Unique names", plotOutput("plot2"))
      #  plotOutput('plot'),
       # plotOutput('plot2')
      )
    )
  )
)


