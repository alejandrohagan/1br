library(tidyverse)
library(collapse)
library(microbenchmark)
library(tidypolars)

# import custom ggplot theme (bbc plot)
## https://bbc.github.io/rcookbook/

source("bbc_plot.R")

# execute respective analysis
source("dt.R")
Sys.sleep(2)
source("duckdb.R")
Sys.sleep(2)
source("polars.R")
Sys.sleep(2)
source("dplyr_and_collapse.R")

beepr::beep()

#import results

files <- list.files(pattern = "_bmarks.csv")

res <- read_csv("results.csv") 

## graph results

res |> 
  mutate(
    time_in_seconds=time/1e9 # convert from nano seconds to seconds
  ) |> 
  ggplot(aes(y=fct_reorder(str_to_upper(expr),time_in_seconds,mean),x=time_in_seconds))+
  geom_boxplot()+
  scale_x_continuous(labels = scales::label_comma(),n.breaks = 10)+
  labs(
    x="Seconds"
    ,y="Packages"
    ,title="Analysis times of 1 billion rows of data"
    ,subtitle="Computation (seconds) by popular packages"
  ) +
  bbc_plot()

## save plot png
  
ggplot2::ggsave("results.png")


