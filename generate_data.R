#!/usr/bin/env Rscript

library(data.table)

print("creating dataset")

input <-   base::commandArgs(trailingOnly = TRUE)

input <- base::as.numeric(input)

dataset_message <- paste0("dataset will be ",input," rows")

print(dataset_message)

set.seed(2024)


measurement_tbl <-data.frame(
  measurement = stats::rnorm(input)
  ,state = base::sample(state.abb, size = input, replace = TRUE)
)

print("dataset created, beginning saving dataset")


file = "measurements.csv"

data.table::fwrite(measurement_tbl, "measurements.csv")


size = structure(file.info(file)$size, class = "object_size") |> format("auto")
  


message("Finished saving dataset \"", file, "\". Its file size is: ", size, ".")

