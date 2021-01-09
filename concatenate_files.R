
library(tidyverse)
library(dplyr)
library(readr)
library(purrr)

# concatenating names-files
setwd("D://Dropbox/R_wissen/berlinnames/data")
getwd()
setwd("namen_berlin_2019")
setwd("D://Dropbox/R_wissen/berlinnames/data")
setwd("namen_berlin_2017")
setwd("D://Dropbox/R_wissen/berlinnames/data")
setwd("namen_berlin_2016")
setwd("D://Dropbox/R_wissen/berlinnames/data")
setwd("namen_berlin_2012")
getwd()


#get table with source name (e.g. charlottenburg.csv)
read_plus <- function(flnm) {
  read_csv(flnm) %>% 
    mutate(kiez = flnm)
}

tbl_with_sources <-
  list.files(pattern = "*.csv", 
             full.names = T) %>% 
  map_df(~read_plus(.))

names(tbl_with_sources)
tbl_with_sources$kiez <- gsub(".csv", "", tbl_with_sources$kiez)
tbl_with_sources$kiez <- gsub("./", "", tbl_with_sources$kiez)
#tbl_with_sources$filename <- NULL
write.csv(tbl_with_sources, "newdata/2019.csv", row.names = FALSE)

##concatenate by year

setwd("D://Dropbox/R_wissen/berlin_names_year/")
setwd("data")
getwd()


#get table with source name (e.g. charlottenburg.csv)
read_plus <- function(flnm) {
  read_csv(flnm) %>% 
    mutate(year = flnm)
}

tbl_with_sources <-
  list.files(pattern = "*.csv", 
             full.names = T) %>% 
  map_df(~read_plus(.))

names(tbl_with_sources)
tbl_with_sources$year <- gsub(".csv", "", tbl_with_sources$year)
tbl_with_sources$year <- gsub("./", "", tbl_with_sources$year)
tbl_with_sources$kiez <- gsub(".csv", "", tbl_with_sources$kiez)
#tbl_with_sources$filename <- NULL
write.csv(tbl_with_sources, "berlin_with_year.csv", row.names = FALSE)

#clean
tbl_with_sources$kiez<-as.factor(tbl_with_sources$kiez)
is.factor(tbl_with_sources$kiez)
levels(tbl_with_sources$kiez)

table<-subset(tbl_with_sources,kiez!="standesamt-i")
table<-droplevels(table) # must be used to finally get rid of standesamt-i (WTF?)
levels(table$kiez)


levels(table$kiez)[levels(table$kiez)=='mitte'] <- 'Mitte'
levels(table$kiez)[levels(table$kiez)=='pankow'] <- 'Pankow'
levels(table$kiez)[levels(table$kiez)=='spandau'] <- 'Spandau'
levels(table$kiez)[levels(table$kiez)=='tempelhof-schoeneberg'] <- 'Tempelhof-Schöneberg'
levels(table$kiez)[levels(table$kiez)=='treptow-koepenick'] <- 'Treptow-Köpenick'
levels(table$kiez)[levels(table$kiez)=='lichtenberg'] <- 'Lichtenberg'
levels(table$kiez)[levels(table$kiez)== 'friedrichshain-kreuzberg'] <- 'Friedrichshain-Kreuzberg'
levels(table$kiez)[levels(table$kiez)=='charlottenburg-wilmersdorf'] <- 'Charlottenburg-Wilmersdorf'
levels(table$kiez)[levels(table$kiez)=='steglitz-zehlendorf'] <- 'Steglitz-Zehlendorf'
levels(table$kiez)[levels(table$kiez)=='neukoelln'] <- 'Neukölln'
levels(table$kiez)[levels(table$kiez)=='marzahn-hellersdorf'] <- 'Marzahn-Hellersdorf'
levels(table$kiez)[levels(table$kiez)=='reinickendorf'] <- 'Reinickendorf'
levels(table$kiez)

write.csv(table, "berlin_with_year_clean.csv", row.names = FALSE)

