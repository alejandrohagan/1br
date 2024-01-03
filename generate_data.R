#!/usr/bin/env Rscript

cli::cli_h1("creating dataset")

input <-   base::commandArgs(trailingOnly = TRUE)

input <- base::as.numeric(input)

assertthat::assert_that(assertthat::is.number(input),msg = "Please input number")

cli::cli_alert("dataset will be {prettyunits::pretty_num(input)} rows")

set.seed(2024)

measurement_vec <- stats::rnorm(input)

state_vec <- base::sample(state.abb, size = input, replace = TRUE)

measurement_tbl <-tibble::tibble(
  measurement = measurement_vec
  ,state = state_vec
)

cli::cli_h2("dataset created, creating directory")

base::dir.create("data", showWarnings = FALSE)

setwd("data")

wd <- getwd()

info <- wd |> base::list.files() |> base::file.info()

info <- prettyunits::pretty_bytes(info$size[1])

cli::cli_alert("saving dataset")
  
data.table::fwrite(measurement_tbl, "measurements.csv")

cli::cli_alert_info("finished saving dataset ({info}), available in {wd}")
