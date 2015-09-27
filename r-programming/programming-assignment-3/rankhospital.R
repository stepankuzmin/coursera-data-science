rankhospital <- function(state, outcome, num = "best") {

  ## Read outcome data
  data <- read.csv("data/outcome-of-care-measures.csv", colClasses = "character")

  ## Check that state and outcome are valid
  if (!(state %in% unique(data$State))) {
    stop("invalid state")
  }

  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!(outcome %in% outcomes)) {
    stop("invalid outcome")
  }

  outcome_colname <- switch(outcome,
                            "heart attack"  = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                            "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                            "pneumonia"     = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")

  ## subset data
  new_data <- subset(data, State == state, select = c("Hospital.Name", outcome_colname))

  ## coerce outcome as numeric
  new_data[,outcome_colname] <- as.numeric(new_data[,outcome_colname])

  ## remove NA's
  clean_data <- new_data[complete.cases(new_data),]

  ## order by outcome desc and hospital name asc
  ordered_data <- clean_data[order(clean_data[,outcome_colname], clean_data$"Hospital.Name"),]

  ## add rank
  ordered_data$"Rank" <- seq(1, nrow(ordered_data))
  ranked_data <- ordered_data

  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if (num == "best") {
    ranked_data[1, "Hospital.Name"]
  }
  else if (num == "worst") {
    ranked_data[nrow(ranked_data), "Hospital.Name"]
  }
  else {
    ranked_data[num, "Hospital.Name"]
  }
}