#Installing and loading packages
library(tidyverse)
library(gapminder)
library(here)
install.packages("scales")
library(scales)
install.packages("tsibble")
library(tsibble)
library(ggplot2)


#Reading and Writing Data


(gap_asia_2007 <- gapminder %>% filter(year == 2007, continent == "Asia"))
write_csv(gap_asia_2007, here::here("data", "s008_data", "exported_file.csv"))
#This creates a new file (exported...) in the folder s008_data in the folder data.
read_csv(here::here("data", "s008_data", "exported_file.csv"))
#This shows what the data actually is
#read_csv(na = c("", "NA", "<N/A>", "-999"))
?read_csv


#From the web/cloud


url <- "http://gattonweb.uky.edu/sheather/book/docs/datasets/magazines.csv"
read_csv(url)


#Excel


#First you must download locally
library(readxl)
dir.create(here::here("data", "s008_data"), recursive = TRUE)
#This can be used to create a folder within your working directory!!
#Then you must download the file
xls_url <- "http://gattonweb.uky.edu/sheather/book/docs/datasets/GreatestGivers.xls"
download.file(xls_url, here::here("data", "s008_data", "some_file.xls"), mode = "wb")
#naming file- chunks "_", spaces "-"
#Or just pull name from source
file_name <- basename(xls_url)
download.file(xls_url, here::here("data", "s008_data", file_name), mode = "wb")
read_excel(here::here("data", "s008_data", file_name))
#install.packages("‘qualtRics’")


#clevel SPSS


#Read in
(clevel <- haven::read_spss(here::here("data", "s008_data", "clevel.sav")))
#When importing from SPSS, you often get a *labeled* vector 
#(e.g. you get "1" *and* "Male")
#Clean
clevel_cleaned <-
  clevel %>% 
  mutate(language = as_factor(language),
         gender = as_factor(gender),
         isClevel = factor(isClevel, 
                           levels = c(0, 1), 
                           labels = c("No", "Yes"))
  ) %>% 
  print()
#saving dataframe
write_csv(clevel_cleaned, here::here("data", "s008_data", "clevel_cleaned.csv"))
#Plotty Plots
library(ggthemes)
clevel_plot <-
  clevel_cleaned %>% 
  mutate(isClevel = recode(isClevel, 
                           No = "Below C-level", 
                           Yes = "C-level"),
         gender = recode(gender,
                         Female = "Women",
                         Male = "Men")) %>% 
  ggplot(aes(paste(isClevel, gender, sep = "\n"), Extraversion, color = gender)) +
  geom_boxplot() +
  geom_jitter(height = .2) +
  scale_color_manual(values = c("#1b9e77", "#7570b3")) +
  ggtitle("Extraversion Stan Scores") +
  scale_y_continuous(breaks = 1:9) +
  ggthemes::theme_fivethirtyeight() %>% 
  print()
#save plot
dir.create(here::here("output", "figures"), recursive = TRUE)
#Bitmap format-- this is worse, use below
ggsave(here::here("output", "figures", "clevel_extraversion.jpg"), clevel_plot)
#Vector Format-- This is better!!
ggsave(here::here("output", "figures", "clevel_extraversion.svg"), clevel_plot)
ggsave(here::here("output", "figures", "clevel_extraversion.pdf"), clevel_plot)
ggsave(here::here("output", "figures", "clevel_extraversion.eps"), clevel_plot)

install.packages("svglite")
library(svglite)
##Had to install Quartz!