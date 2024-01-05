library(dplyr)
library(ggplot2)
library(forcats)
library(stringr)
library(readr)
library(here)


# import custom ggplot theme (bbc plot)
## https://bbc.github.io/rcookbook/
dt_fp <- here::here("dt.R")

# create file paths to script locations
dplyr_and_collapse_fp <- here::here("dplyr_and_collapse.R")

dudckdb_and_arrow_fp <- here::here("duckdb_and_arrow.R")

polars_fp <- here::here("polars.R")

#load bbcplot

source("bbc_plot.R")

# source scripts from terminal to avoid changes to the environment

system2(dt_fp)
Sys.sleep(2)
system2(dplyr_and_collapse_fp)
Sys.sleep(2)
system2(dudckdb_and_arrow_fp)
Sys.sleep(2)
system2(polars_fp)

#import results

files <- list.files(pattern = "_bmarks.csv")

res <- readr::read_csv(files)

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


