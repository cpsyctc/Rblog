library(tidyverse)
setwd("/media/chris/Clevo_SSD2/Data/MyR/R/distill_blog/test2/_posts/2023-12-30-correlations")

read_csv(file = "tibDat1N4.csv") -> tibDat1N4 

tibDat1N4 %>%
  mutate(productDevXDevY = devX * devY) %>% summarise(mean = mean(productDevXDevY))
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
  select(ID : productStdXStdY) %>%
  rename(sqDevX = stdX,
         sqDevY = stdY) %>%
  mutate(ID = as.character(ID),
         minus = "-",
         equals1 = "=",
         sqDevX = sqDevX^2,
         sqDevY = sqDevY^2) %>%
  select(ID : y, minus, meanX, meanY, equals1, devX, devY, productStdXStdY, sqDevX, sqDevY) -> tmpTib

tmpTib %>%
  select(-c(minus, equals1)) %>%
  summarise(across(x : sqDevY, sum)) %>%
  mutate(minus = "",
         equals1 = "") %>%
  ### deal with the tiny rounding error in devX
  mutate(devX = if_else(devX < .0001, 0, devX)) %>%
  ### get sensible ID value!
  mutate(ID = "Sum") -> tmpTibSums

bind_rows(tmpTib,
          tmpTibSums) %>%
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
  
#### Oh fuck all this, I AM dementing
  
tibDat1N4 %>%
  select(x, y) %>% 
  ### get means
  mutate(meanX = mean(x),
         meanY = mean(y)) %>%
  ### get deviations from means
  mutate(devX = x - meanX,
         devY = y - meanY) %>%
  ### get crossproduct
  mutate(devXproduct = devX * devY) %>%
  ### get sum of crossproducts
  mutate(sumXproduct = sum(devXproduct)) %>%
  ### get ssq deviations 
  mutate(ssqX = sum(devX^2),
         ssqY = sum(devY^2)) %>%
  ### get sqrts of ssqs
  mutate(sqrtSsqX = sqrt(ssqX),
         sqrtSsqY = sqrt(ssqY)) -> tmpTib

tmpTib

tmpTib %>%
  ### so ...
  filter(row_number() == 1) %>%
  summarise(Pearson = sumXproduct / (sqrtSsqX * sqrtSsqY))

### So that shows that the formula in Wikipedia is correct and I can, if I plod through it like a four year old painting by numbers, compute it