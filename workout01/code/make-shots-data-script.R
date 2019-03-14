#title: Data Preparation 
#description: This script contains information regarding the NBA data we are preparing, and code necessary to complete the data preparation.
#inputs: The inputs we need are code chunks that change some things in columns, add columns, and combine them, etc.
#outputs: When the script is run, we will get a csv data file "shots-data.csv" that contains the required variables to be used in the visualization phase.

data_types = c("team_name"="character", "game_date"="character", "season" = "integer", "period"="integer",
               "minutes_remaining"="integer", "seconds_remaining"="integer", "shot_made_flag"="character",
               "action_type"="factor", "shot_type"="factor", "shot_distance"="integer", "opponent"="character",
               "x"="integer", "y"="integer")

iguodala <- read.csv("Desktop/workout01/data/andre-iguodala.csv", stringsAsFactors = FALSE, colClasses = data_types)
green <- read.csv("Desktop/workout01/data/draymond-green.csv", stringsAsFactors = FALSE, colClasses = data_types)
durant <- read.csv("Desktop/workout01/data/kevin-durant.csv", stringsAsFactors = FALSE, colClasses = data_types)
thompson <- read.csv("Desktop/workout01/data/klay-thompson.csv", stringsAsFactors = FALSE, colClasses = data_types)
curry <- read.csv("Desktop/workout01/data/stephen-curry.csv", stringsAsFactors = FALSE, colClasses = data_types)

iguodala$name <- "Andre Iguodala"
green$name <- "Draymond Green"
durant$name <- "Kevin Durant"
thompson$name <- "Klay Thompson"
curry$name <- "Stephen Curry"

iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"

iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"

iguodala$minute <- iguodala$period*12 - iguodala$minutes_remaining
green$minute <- green$period*12 - green$minutes_remaining
durant$minute <- durant$period*12 - durant$minutes_remaining
thompson$minute <- thompson$period*12 - thompson$minutes_remaining
curry$minute <- curry$period*12 - curry$minutes_remaining

sink(file = 'Desktop/workout01/output/andre-iguodala-summary.txt')
summary(iguodala)
sink()

sink(file = 'Desktop/workout01/output/draymond-green-summary.txt')
summary(green)
sink()

sink(file = 'Desktop/workout01/output/kevin-durant-summary.txt')
summary(durant)
sink()

sink(file = "Desktop/workout01/output/klay-thompson-summary.txt")
summary(thompson)
sink()

sink(file = "Desktop/workout01/output/stephen-curry-summary.txt")
summary(curry)
sink()

combined <- rbind(iguodala, green, durant, thompson, curry)
write.csv(combined, file = "Desktop/workout01/data/shots-data.csv")

sink(file = "Desktop/workout01/output/shots-data-summary.txt")
summary(combined)
sink()
