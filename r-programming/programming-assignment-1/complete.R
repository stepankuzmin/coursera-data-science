complete <- function(directory, id = 1:332) {
  nobs <- c()
  for(monitor_id in id) {
    filename <- sprintf("%s/%03d.csv", directory, monitor_id)
    file <- read.csv(filename)
    nobs_vector <- file$sulfate & file$nitrate
    nobs <- c(nobs, length(nobs_vector[!is.na(nobs_vector)]))
  }
  data.frame(id = id, nobs = nobs)
}