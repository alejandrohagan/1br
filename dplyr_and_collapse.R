rm(list=ls())

fp <- here::here("data","measurements.csv")


measurement_tbl <- data.table::fread(fp) |> as_tibble()

measurement_tbl |> 
  collapse::fgroup_by(state) |> 
  collapse::qsu()

beepr::beep(sound=8)

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


collapse2 <- function(){
   out <-  measurement_tbl |> 
      collapse::fgroup_by(state) |> 
      collapse::qsu()
   
   return(out)
}

bmarks <- microbenchmark(
  
  dplyr=dplyr()
  ,collapse=collapse()
  ,collapse2=collapse2()
  ,times = 2
  ,unit = "s"
  )

BRRR::skrrrahh(23)

write.csv(bmarks,"dplyr_and_collapse_bmarks.csv")
