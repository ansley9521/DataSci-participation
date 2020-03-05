#Installing and loading packages
library(tidyverse)
library(gapminder)
library(here)
install.packages("scales")
library(scales)
install.packages("tsibble")
library(tsibble)

#Reading and Writing Data

(gap_asia_2007 <- gapminder %>% filter(year == 2007, continent == "Asia"))
write_csv(gap_asia_2007, here::here("data", "s008_data", "exported_file.csv"))
#This creates a new file (exported...) in the folder s008_data in the folder data.

read_csv(here::here("data", "s008_data", "exported_file.csv"))
#This shows what the data actually is

