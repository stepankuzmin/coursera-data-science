corr <- function(directory, threshold = 0) {
  nobs_table <- complete(directory)
  filtered_nobs_table <- subset(nobs_table, nobs >= threshold)

  if (length(filtered_nobs_table$id) > 0) {
    data <- c()
    for(monitor_id in filtered_nobs_table$id) {
      filename <- sprintf("%s/%03d.csv", directory, monitor_id)
      file <- read.csv(filename)
      correlation <- cor(file$sulfate, file$nitrate, use = "na.or.complete")
      data <- c(data, correlation)
    }
    data <- data[!is.na(data)]
  }
  else {
    data <- vector("numeric", length = 0)
  }
  data
}