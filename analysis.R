setwd("~/Coursera/datascience/Data Products/Week4/DataProductsWeek4")

# "https://www.kaggle.com/joniarroba/noshowappointments/downloads/noshowappointments.zip"

data <- read.csv("emission.csv")

library(dplyr)
library(caret)

set.seed(4682)

cleaned <- data %>% select(Engine.Capacity, Fuel.Type, Co2 = CO2.g.km) %>% filter(!is.na(Engine.Capacity))
write.csv(cleaned, "data.csv")

ggplot(cleaned, aes(Engine.Capacity,Co2)) + geom_point(aes(col = Fuel.Type), show.legend = TRUE) + geom_smooth(method = "lm")

data <- read.csv("data.csv")
qplot(Engine.Capacity, Co2, data = data, color = Fuel.Type) + geom_smooth(method = "lm")
mod <- lm(Co2 ~ ., data = data)