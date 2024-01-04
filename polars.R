
rm(list=ls())
fp <- here::here("data","measurements.csv")

measurement_tbl <- data.table::fread(fp)

measurement_pl <- measurement_tbl |> as_tibble() |> 
  as_polars() 

beepr::beep(sound=8)

rm(measurement_tbl)



polars <- function(){
  
  out <- 
    measurement_pl |> 
    group_by(state) |> 
    summarise(
      min=min(measurement)
      ,max=max(measurement)
      ,mean=mean(measurement)
    ) |> ungroup()
  
  return(out)
}

bmarks <- microbenchmark(
  
  polars=polars()
  ,times = 2
  , unit = "s"
  )

BRRR::skrrrahh(23)

write.csv(bmarks,"polars_bmarks.csv")