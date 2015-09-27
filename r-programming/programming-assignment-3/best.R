best <- function(state, outcome) {

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

  ## subset data based on state
  new_data <- subset(data, State == state, select = c("Hospital.Name", outcome_colname))

  # order by hospital name
  ordered_new_data <- new_data[order(new_data$"Hospital.Name"),]

  # row index with min outcome_colname value
  min_outcome_colname_row_index <- which.min(as.numeric(new_data[, outcome_colname]))

  # best hospital name
  new_data[min_outcome_colname_row_index, "Hospital.Name"]
}