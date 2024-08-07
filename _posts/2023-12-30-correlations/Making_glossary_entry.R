library(tidyverse)
setwd("/media/chris/Clevo_SSD2/Data/MyR/R/distill_blog/test2/_posts/2023-12-30-correlations")

read_csv(file = "tibDat1N4.csv") -> tibDat1N4 

tibDat1N4 %>%
  mutate(ID = as.character(ID)) %>%
  select(ID : y) -> tmpTib

tmpTib %>%
  summarise(across(x : y, sd)) %>%
  mutate(ID = "SD") %>%
  select(ID, x, y) %>%
  bind_rows(tmpTib) %>%
  arrange(ID) -> tmpTib2

tmpTib %>%
  summarise(across(x : y, mean)) %>%
  mutate(ID = "Mean") %>%
  bind_rows(tmpTib2) %>%
  arrange(ID) %>%
  select(ID, x, y) -> tmpTib3

write_csv(tmpTib3, "~/tmpTib3.csv")

tibDat1N4 %>%
  select(ID : stdY) %>%
  rename(stdDevX = stdX,
         stdDevY = stdY) %>%
  mutate(minus = "-",
         divide_by = "÷",
         equals1 = "=",
         equals2 = "=") %>%
  select(ID : y, minus, meanX, meanY, equals1, devX, devY, divide_by, sdX, sdY, equals2, everything()) %>%
  write_csv("~/tmpTib5.csv")


tibDat1N4 %>%
  mutate(ID = as.character(ID)) %>%
  select(ID : y, devX, devY, productStdXStdY) -> tmpTib2

tmpTib2 %>% 
  summarise(across(x : y, sd))
  

tmpTib2 %>% 
  summarise(productStdXStdY = sum(productStdXStdY)) %>%
  mutate(ID = "Sum") %>%
  bind_rows(tmpTib2) %>%
  arrange(ID) %>%
  select(ID, x, y, stdDevX, stdDevY, productStdXStdY)
  write_csv("~/tmpTib6.csv")
  
