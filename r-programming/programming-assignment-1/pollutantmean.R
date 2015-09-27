pollutantmean <- function(directory, pollutant, id = 1:332) {
  data <- c()
  for(monitor_id in id) {
    filename <- sprintf("%s/%03d.csv", directory, monitor_id)
    file <- read.csv(filename)
    data <- c(data, c(file[[pollutant]]))
  }
  clean_data <- data[!is.na(data)]
  mean(clean_data)
}