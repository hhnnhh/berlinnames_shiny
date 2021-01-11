

library(dplyr)

#change new strange column name "ï..vorname" back to "vorname"
rename(df$ï..vorname = df$vorname)
df = rename(df, vorname = ï..vorname)
#change kiez back to Kiez because of script
df = rename(df, Kiez = kiez)
#check if its okay now
names(df)

#save changes for later
write.csv(df,"./data/Berlin_with_year_final.csv", row.names =FALSE)
