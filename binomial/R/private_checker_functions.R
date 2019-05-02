#Private Checker Functions

#private auxiliary function check_prob() tests if an input prob is a valid probability
#i.e. 0 <= p <= 1
check_prob <- function(prob) {
  if(0 <= prob && prob <= 1 && length(prob) == 1) {
    return(TRUE)
  } else {
    stop('prob has to be a number (of length 1) between 0 and 1')
  }
}
check_prob(0.6)
check_prob(1/2)
check_prob(1.2)
check_prob(c(1, 1/2))

#private auxiliary function check_trials() tests if an input trials is a valid value for the number of trials
#trials(n) should be a non-negative integer
check_trials <- function(trials) {
  if(trials > 0 && trials%%1 == 0) {
    return(TRUE)
  } else {
    stop('invalid trials value')
  }
}

check_trials(0)
check_trials(3.5)
check_trials(500)
check_trials(-2)

#private auxiliary function check_success() tests if an input success is a valid value for number of successes
#success(k) should be between 0 and trials(n)
check_success <- function(success, trials) {
  if(min(success) >= 0 && max(success) <= trials) {
    return(TRUE)
  } else if (max(success) > trials) {
    stop('success cannot be greater than trials')
  } else {
    stop('invalid success value')
  }
}

check_success(c(10, 5), 20)
check_success(c(10), 5)
check_success(c(0), 2)

