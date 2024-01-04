
# load libraries
library(data.table)
library(tidyverse)

# clear name space to help with memory management
rm(list=ls())

# load data in DT format

fp <- here::here("data","measurements.csv")

measurement_dt <- data.table::fread(fp)


# create function to simulate results

dt <- function(){
  
  out <- measurement_dt[ ,.(mean=mean(measurement),min=min(measurement),max=max(measurement)),by=state]
  
  return(out)
  
}



#micro benchmarks

bmarks <- microbenchmark(
  
  dt=dt()
  ,times = 10
  , unit = "s")

# save results

write.csv(bmarks,"dt_bmarks.csv")

