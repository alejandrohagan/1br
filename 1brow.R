library(tidyverse)
library(collapse)
library(microbenchmark)

rm(list=ls())
set.seed(2024)

measurement_vec=rnorm(1e9)


state_vec <- sample(state.abb,size = 1e9,replace = TRUE)

measurement_tbl <- tibble(
  measurement=measurement_vec
  ,state=state_vec
)

rm(state_vec,measurement_vec)
rm(measurement_tbl)

con <- DBI::dbConnect(duckdb::duckdb())

duckdb::duckdb_register(con,name = "measurement_db",measurement_tbl)

measurement_db <- dplyr::tbl(con,"measurement_db")


measurement_dt <-   measurement_tbl |> data.table::setDT()

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

dt <- function(){
  
  out <- measurement_dt[ ,.(mean=mean(measurement),min=min(measurement),max=max(measurement)),by=state]
  
  return(out)
  
}



bmarks <- microbenchmark(
  # collapse=collapse()
  # duckdb=duckdb()
  # ,dplyr=dplyr()
  dt=dt()
  ,times = 5
  , unit = "s")

bmarks |> write.csv("dt.csv")

bmarks |> as_tibble()
results <- c("dt.csv","duckdb.csv","dplyr_collapse.csv")


read_csv(results) |> 
  ggplot(aes(y=expr,x=time))+
  geom_point()
microbenchmark:::boxplot.microbenchmark(bmarks)
