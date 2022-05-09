library(ggplot2)
library(tidyverse)
as_tibble(list(x = 1,
               y = 1)) -> tibDat

png(file = "redpipe.png", type = "cairo", width = 6000, height = 4800, res = 300)
ggplot(data = tibDat,
       aes(x = x, y = y)) +
  geom_text(label = "%>%",
            size = 200,
            colour = "red") +
  xlab("") +
  ylab("") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()) 
dev.off(2)
