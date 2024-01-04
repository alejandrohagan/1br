#!/usr/bin/env Rscript

library(tidyverse)
library(collapse)
library(microbenchmark)
library(tidypolars)


source("dt.R")
Sys.sleep(2)
source("duckdb.R")
Sys.sleep(2)
source("polars.R")
Sys.sleep(2)
source("dplyr_and_collapse.R")

beepr::beep()


keep_files <- list.files() |> 
  str_detect("_bmarks.csv")


all_files <- list.files()

files <- all_files[keep_files]

res <- read_csv("results.csv") 


res |> 
  mutate(
    time_in_seconds=time/1e9
  ) |> 
  ggplot(aes(y=fct_reorder(str_to_upper(expr),time_in_seconds,mean),x=time_in_seconds))+
  geom_boxplot()+
  theme_classic()+
  scale_x_continuous(labels = scales::label_comma(),n.breaks = 10)+
  labs(
    x="Seconds"
    ,y="Packages"
    ,title="Analysis times of 1 billion rows of data"
    ,subtitle="Computation (seconds) by popular packages"
  )+
  ggplot2::theme(plot.title = ggplot2::element_text(
    family = font
    ,size = 28
    ,face = "bold"
    ,color = "#222222")
    , plot.subtitle = ggplot2::element_text(family = font,
                                                                                                                                        size = 22, margin = ggplot2::margin(9, 0, 9, 0)), plot.caption = ggplot2::element_blank(),
                 legend.position = "top", legend.text.align = 0, legend.background = ggplot2::element_blank(),
                 legend.title = ggplot2::element_blank(), legend.key = ggplot2::element_blank(),
                 legend.text = ggplot2::element_text(family = font, size = 18,
                                                     color = "#222222"), axis.title = ggplot2::element_blank(),
                 axis.text = ggplot2::element_text(family = font, size = 18,
                                                   color = "#222222"), axis.text.x = ggplot2::element_text(margin = ggplot2::margin(5,
                                                                                                                                    b = 10)), axis.ticks = ggplot2::element_blank(),
                 axis.line = ggplot2::element_blank(), panel.grid.minor = ggplot2::element_blank(),
                 panel.grid.major.y = ggplot2::element_line(color = "#cbcbcb"),
                 panel.grid.major.x = ggplot2::element_blank(), panel.background = ggplot2::element_blank(),
                 strip.background = ggplot2::element_rect(fill = "white"),
                 strip.text = ggplot2::element_text(size = 22, hjust = 0))


ggplot2::ggsave("results.png")






bbc_plot <- function() 
{
  
  font <- "Helvetica"
  theme_set(

    ggplot2::theme(plot.title = ggplot2::element_text(family = font,
        size = 28, face = "bold", color = "#222222"), plot.subtitle = ggplot2::element_text(family = font,
        size = 22, margin = ggplot2::margin(9, 0, 9, 0)), plot.caption = ggplot2::element_blank(),
        legend.position = "top", legend.text.align = 0, legend.background = ggplot2::element_blank(),
        legend.title = ggplot2::element_blank(), legend.key = ggplot2::element_blank(),
        legend.text = ggplot2::element_text(family = font, size = 18,
            color = "#222222"), axis.title = ggplot2::element_blank(),
        axis.text = ggplot2::element_text(family = font, size = 18,
            color = "#222222"), axis.text.x = ggplot2::element_text(margin = ggplot2::margin(5,
            b = 10)), axis.ticks = ggplot2::element_blank(),
        axis.line = ggplot2::element_blank(), panel.grid.minor = ggplot2::element_blank(),
        panel.grid.major.y = ggplot2::element_line(color = "#cbcbcb"),
        panel.grid.major.x = ggplot2::element_blank(), panel.background = ggplot2::element_blank(),
        strip.background = ggplot2::element_rect(fill = "white"),
        strip.text = ggplot2::element_text(size = 22, hjust = 0))
  )
}
bbc_plot()
