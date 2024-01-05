#library

library(DBI)
library(duckdb)
library(dplyr)
library(microbenchmark)
library(data.table)
library(arrow)

#load data and create duckdb connection



measurement_tbl <- data.table::fread("measurements.csv")

con <- DBI::dbConnect(duckdb::duckdb())

duckdb::duckdb_register(con,name = "measurement_db",measurement_tbl)

measurement_db <- dplyr::tbl(con,"measurement_db")

measurements_ar <- measurement_db |> arrow::to_arrow()


# create function to simulate results

duckdb <- function(){
  out <-  measurement_db |> 
    group_by(state) |> 
    summarize(
      min=min(measurement,na.rm=TRUE)
      ,max=max(measurement,na.rm=TRUE)
      ,mean=mean(measurement,na.rm=TRUE)
    ) |> ungroup() |> 
    collect()
  
  return(out)
}


arrow <- function(){

out <- measurements_ar |> 
  group_by(state) |> 
  summarize(
    min=min(measurement,na.rm=TRUE)
    ,max=max(measurement,na.rm=TRUE)
    ,mean=mean(measurement,na.rm=TRUE)
  ) |> ungroup() |> 
  collect()

return(out)

}

#micro benchmarks


bmarks <- microbenchmark(
  
  duckdb=duckdb()
  ,arrow=arrow()
  ,times = 10
  , unit = "s"
  )


write.csv(bmarks,"duckdb_and_arrow_bmarks.csv")


