# load libraries

library(tidypolars)
library(tidyverse)

# clear name space to hlep with memory management
rm(list=ls())

# load data and convert to polars tbl
fp <- here::here("data","measurements.csv")

measurement_pl <- data.table::fread(fp) |> 
  as_tibble() |> 
  as_polars()  




# create function to simulate results

polars <- function(){
  
  out <- measurement_pl |> 
    group_by(state) |> 
    summarise(
      min=min(measurement)
      ,max=max(measurement)
      ,mean=mean(measurement)
    ) |> ungroup()
  
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