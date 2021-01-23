
#Hannah Bohle, 11.01. 2021
library(shiny)
#library(shinythemes)
library(dplyr)
library(wordcloud)
#library(DT)
#library(here)

#load(here::here('apps', 'df', 'df.RData'))
df <- read.csv("data/Berlin_with_year_position_filtered.csv")
#df <- read.csv("D:/Dropbox/R_wissen/berlin_name_year/data/Berlin_with_year.csv")



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
        helpText("Position data only available since 2017"),
        conditionalPanel(condition="input.yearId>2016",
                         selectInput(
                           inputId = "position", 
                           label = "Choose position of name:",
                           choices = c("1","2","3","4","5","6","7"),
                           selected ="1")
        ),
                 
                 br(), 
                 
                 actionButton('select', 'Select'),
                 
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
      #tableOutput("result")
      tabPanel("Frequent names", plotOutput("plot")),
      tabPanel("Unique names", verbatimTextOutput("result"))
      #  plotOutput('plot'),
       # plotOutput('plot2')
      )
    )
  )
)


