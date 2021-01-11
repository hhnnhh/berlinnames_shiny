library(shiny)
library(ggplot2)


#https://stackoverflow.com/questions/46348193/shiny-automatic-selectinput-value-update-based-on-previous-filter
#df <- read.csv("D:/Dropbox/R_wissen/berlin_names_year/berlinnames_shiny/Berlin_2019_with_new_columnname.csv")


shinyUI(
  fluidPage(
    titlePanel("Name Selection"),
    sidebarLayout(
      sidebarPanel(
        helpText("Display first names of each Kiez."),
        
        selectInput("yearId", "Year", choices = unique(df$year)),
        
        helpText("Sorry, data was only available for binary gender :("),
        selectInput("genderId", "Gender", choices = unique(df$geschlecht)),
        helpText("Based on the gender, now select Kiez below to display the first names in the main panel."),
        
        selectInput("selectinputid", "Kiez to Select:", choices = unique(df$Kiez)),
        #checkboxInput("positionid", "Only first names?", value = FALSE, width = NULL),
        actionButton("goButton1", "Submit Choice")),
      
      mainPanel(
        #tableOutput("result")
        plotOutput('plot')
        )
        
      )
    )
  )
#)
  

#   mainPanel(
#   #  tabsetPanel(
#    #   tabPanel('girl', dataTableOutput(dataset$geschlecht == "w")),
#     #  tabPanel('boy', dataTableOutput(dataset$geschlecht == "m")),
#     plotOutput('plot')
#   )
# )