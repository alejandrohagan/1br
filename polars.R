# load libraries

library(tidypolars)
library(dplyr)
library(here)
library(microbenchmark)
library(data.table)

# clear name space to hlep with memory management
rm(list=ls())

# load data and convert to polars tbl
fp <- here::here("data","measurements.csv")

measurement_pl <- data.table::fread(fp) |> 
  as_polars()  




# create function to simulate results

polars <- function(){
  
  out <- measurement_pl |> 
    group_by(state) |> 
    summarise(
      min=min(measurement)
      ,max=max(measurement)
      ,mean=mean(measurement)
    ) |> 
    ungroup() |> 
    tidypolars::to_r()
  return(out)
}

# benchmark results
bmarks <- microbenchmark(
  
  polars=polars()
  ,times = 10
  , unit = "s"
  )

# save results

write.csv(bmarks,"polars_bmarks.csv")