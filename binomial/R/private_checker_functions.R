#Private Checker Functions

#private auxiliary function check_prob() tests if an input prob is a valid probability
#i.e. 0 <= p <= 1
# Input: numeric value prob (probability)
# Output: logical value TRUE if valid input or an error message if invalid
check_prob <- function(prob) {
  if(0 <= prob && prob <= 1 && length(prob) == 1) {
    return(TRUE)
  } else {
    stop('prob has to be a number (of length 1) between 0 and 1')
  }
}

#private auxiliary function check_trials() tests if an input trials is a valid value for the number of trials
#trials(n) should be a non-negative integer
# Input: trials (number of trials)
# Output: logical value TRUE if valid input or an error message if invalid
check_trials <- function(trials) {
  if(trials > 0 && trials%%1 == 0) {
    return(TRUE)
  } else {
    stop('invalid trials value')
  }
}

#private auxiliary function check_success() tests if an input success is a valid value for number of successes
#success(k) should be between 0 and trials(n)
# Inputs: success (number of successes), trial (number of trials)
# Output: a logical value TRUE if valid inputs or an error message if invalid
check_success <- function(success, trials) {
  if(min(success) >= 0 && max(success) <= trials) {
    return(TRUE)
  } else if (max(success) > trials) {
    stop('success cannot be greater than trials')
  } else {
    stop('invalid success value')
  }
}
