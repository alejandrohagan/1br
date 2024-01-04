
fp <- here::here("data","measurements.csv")


measurement_tbl <- data.table::fread(fp) |> as_tibble()

con <- DBI::dbConnect(duckdb::duckdb())

duckdb::duckdb_register(con,name = "measurement_db",measurement_tbl)

measurement_db <- dplyr::tbl(con,"measurement_db")

beepr::beep(sound=8)

duckdb <- function(){
  out <-  measurement_db |> 
    group_by(state) |> 
    summarize(
      min=min(measurement)
      ,max=max(measurement)
      ,mean=mean(measurement)
    ) |> ungroup()
  
  return(out)
}

bmarks <- microbenchmark(

  duckdb=duckdb()
  ,times = 2
  , unit = "s")

write.csv(bmarks,"duckdb_bmarks.csv")

BRRR::skrrrahh(23)

