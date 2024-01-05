library(dplyr)
library(data.table)
library(microbenchmark)
library(collapse)

# free up memory to help with memory mgmt
rm(list=ls())

# load data and convert to tbl

measurement_tbl <- data.table::fread("measurements.csv")

# write collapse and dplyr functions

collapse <- function() {
  out <-   measurement_tbl |> 
    fgroup_by(state) |> 
    fsummarise(
      min=fmin(measurement)
      ,max=fmax(measurement)
      ,mean=fmean(measurement)
    ) |> collapse::fungroup()
  return(out)
}

dplyr <- function(){
  out <-   measurement_tbl |> 
    group_by(state) |> 
    summarise(
      min=min(measurement)
      ,max=max(measurement)
      ,mean=mean(measurement)
    ) |> ungroup()
  return(out)
}


#micro benchmarks

bmarks <- microbenchmark(
  
  dplyr=dplyr()
  ,collapse=collapse()
  ,times = 10
  ,unit = "s"
  )


write.csv(bmarks,"dplyr_and_collapse_bmarks.csv")
