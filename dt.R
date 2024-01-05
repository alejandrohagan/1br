
# load libraries
library(data.table)
library(microbenchmark)

# clear name space to help with memory management
rm(list=ls())

# load data in DT format


measurement_dt <- data.table::fread("measurements.csv")


# create function to simulate results

dt <- function(){
  
  out <- measurement_dt[ ,.(mean=mean(measurement),min=min(measurement),max=max(measurement)),by=state]
  
  return(out)
  
}



#micro benchmarks

bmarks <- microbenchmark::microbenchmark(
  
  dt=dt()
  ,times = 10
  , unit = "s")

# save results

write.csv(bmarks,"dt_bmarks.csv")

