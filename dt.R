
rm(list=ls())
fp <- here::here("data","measurements.csv")


measurement_tbl <- data.table::fread(fp)


measurement_dt <-   measurement_tbl |> data.table::setDT()
beepr::beep(sound=8)

rm(measurement_tbl)
dt <- function(){
  
  out <- measurement_dt[ ,.(mean=mean(measurement),min=min(measurement),max=max(measurement)),by=state]
  
  return(out)
  
}


bmarks <- microbenchmark(
  
  dt=dt()
  ,times = 1
  , unit = "s")

BRRR::skrrrahh(23)



write.csv(bmarks,"dt_bmarks.csv")

