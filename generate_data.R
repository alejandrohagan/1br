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

print("dataset created, creating directory")

base::dir.create("data", showWarnings = FALSE)

setwd("data")

wd <- getwd()

info <- wd |> base::list.files() |> base::file.info()

info <- (info$size[1])/1e6

print("saving dataset")
  
data.table::fwrite(measurement_tbl, "measurements.csv")

closing_message <- paste0("finished saving database (",info,"MB), available in ",wd)

print(closing_message)
