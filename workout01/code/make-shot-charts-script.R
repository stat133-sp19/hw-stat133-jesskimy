#title: Shot Charts
#description: This script contains code that uses our data of the players and creates charts of their shots from it.
#inputs: The inputs are code chunks that produce individual charts for each player, and code that puts them together.
#outputs: The outputs are individual charts in pdf format for each player, and a combined pdf and png file, for a total of 7 outputs.

install.packages('jpeg')
library(jpeg)
library(grid)
library(ggplot2)

imageurl <- "https://raw.githubusercontent.com/ucb-stat133/stat133-hws/master/images/nba-court.jpg"
imagedestination <- "Desktop/workout01/images/nba-court.jpg"
download.file(imageurl, imagedestination)

#court image (to be used as background of plot)
court_file <- "Desktop/workout01/images/nba-court.jpg"

#create raste object
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))

#4.1
iguodala_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()
pdf(file = 'Desktop/workout01/images/andre-iguodala-shot-chart.pdf', width = 6.5, height = 5)
iguodala_shot_chart
dev.off()

green_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()
pdf(file = 'Desktop/workout01/images/draymond-green-shot-chart.pdf', width = 6.5, height = 5)
green_shot_chart
dev.off()

durant_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()
pdf(file = 'Desktop/workout01/images/kevin-durant-shot-chart.pdf', width = 6.5, height = 5)
durant_shot_chart
dev.off()

thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
pdf(file = 'Desktop/workout01/images/klay-thompson-shot-chart.pdf', width = 6.5, height = 5)
thompson_shot_chart
dev.off()

curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()
pdf(file = 'Desktop/workout01/images/stephen-curry-shot-chart.pdf', width = 6.5, height = 5)
curry_shot_chart
dev.off()

#4.2
combined_charts <- ggplot(data = combined) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Charts: GSW (2016 season)') +
  theme_minimal()+
  facet_wrap(~ name)
pdf(file = "Desktop/workout01/images/gsw-shot-charts.pdf", width = 8, height = 7)
combined_charts
dev.off()
png(file = "Desktop/workout01/images/gsw-shot-charts.png", width = 8, height = 7, units="in", res = 120)
combined_charts
dev.off()