library(tictoc)

benchmark <- function(test_fn){
  tic(log=TRUE,quiet = TRUE) 
  test_fn
  toc(log = TRUE,quiet=TRUE)
}