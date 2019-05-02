library(ggplot2)
dev.off()

#' @title Combination
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n numeric, number of trials
#' @param k numeric, number of successes
#' @return the number of combinations of possible k successes in n trials
#' @export
#' @examples
#' bin_choose(n = 5, k = 2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)
#'
#'

bin_choose <- function(n, k) {
  if(any(k > n)) {
    stop("k cannot be greater than n")
  } else {
    return(factorial(n)/(factorial(k)*factorial(n-k)))
  }
}

bin_choose(n = 5, k = 2)
bin_choose(5, 0)
bin_choose(5, 1:3)

#' @title Binomial Probability
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param success numeric, number of successes
#' @param trials numeric, number of trials
#' @param prob numeric, probability of success
#' @return the binomial probability
#' @export
#' @examples
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#' bin_probability(success = 55, trials = 100, prob = 0.45)
#'
#'
source("R/privatecheckerfunctions.R")
bin_probability <- function(success, trials, prob) {
  if(check_trials(trials) == TRUE && check_success(success, trials) == TRUE && check_prob(prob) == TRUE) {
    bin_choose(trials, success) * (prob^success) * (1-prob)^(trials - success)
  } else if (check_trials(trials) != TRUE) {
    check_trials(trials)
  } else if (check_success(success, trials) != TRUE) {
    check_success(success, trials)
  } else if (check_prob(prob) != TRUE) {
    check_prob(prob)
  }
}

bin_probability(success = 2, trials = 5, prob = 0.5)
bin_probability(success = 0:2, trials = 5, prob = 0.5)
bin_probability(success = 55, trials = 100, prob = 0.45)
bin_probability(success = 0:2, trials = -2, prob = 0.5)
bin_probability(success = 10, trials = 5, prob = 0.5)
bin_probability(success = 0:2, trials = 5, prob = 1.9)

#' @title Binomial Distribution
#' @description calculates the probability of success for each of the possible number of successes given the number of trials
#' @param trials numeric, number of trials
#' @param prob numeric, probability of success
#' @return a data frame with the probability distribution of two classes-bindis and data.frame
#' @export
#' @examples
#' bin_distribution(trials = 5, prob = 0.5)
#'
#'
bin_distribution <- function(trials, prob, class = c("bindis", "data.frame")) {
  probs <- rep(1, length(trials))
  success <- 0:trials
  for(i in 0:trials) {
    probs[i+1] <- bin_probability(i, trials, prob)
  }
  dist_df <- data.frame(success, probs)
  class(dist_df) <- c("bindis", "data.frame")
  return(dist_df)
}

bin_distribution(trials = 5, prob = 0.5)

#' @export
plot.bindis <- function(dist_df, ...) {
  ggplot(data = dist_df, aes(x = success, y = probs)) + geom_col()
}

dis1 <- bin_distribution(trials = 5, prob = 0.5)
plot(dis1)

#' @title Binomial Cumulative Distribution
#' @description calculates the probability of success for each of the possible number of successes given the number of trials,
#' as well as the cumulative probability, which adds the current probability to the past ones
#' @param trials numeric, number of trials
#' @param prob numeric, probability of success
#' @return a data frame with both the probability distribution and the cumulative probabilities, of two classes-bincum and data.frame
#' @export
#' @examples
#' bin_cumulative(trials = 5, prob = 0.5)
#'
#'
bin_cumulative <- function(trials, prob, class = c("bincum", "data.frame")) {
  probs <- rep(1, length(trials))
  cumulative <- rep(0, length(trials))
  success <- 0:trials
  for(i in 0:trials) {
    probs[i+1] <- bin_probability(i, trials, prob)
    if(i == 0) {
      cumulative[i+1] <- probs[i+1]
    } else {
      cumulative[i+1] <- cumulative[i] + probs[i+1]
    }
  }
  cum_df <- data.frame(success, probs, cumulative)
  class(cum_df) <- c("bincum", "data.frame")
  return(cum_df)
}

bin_cumulative(trials = 5, prob = 0.5)

#' @export
plot.bincum <- function(cum_df, ...) {
  ggplot(data = cum_df, aes(x = success, y = cumulative)) + geom_line() + geom_point()
}

dis2 <- bin_cumulative(trials = 5, prob = 0.5)
plot(dis2)

#' @title Binomial Variable
#' @description gets us a list with named elements (number of trials and probability of success)
#' @param trials numeric, number of trials
#' @param prob numeric, probability of success
#' @return a list of class binvar
#' @export
#' @examples
#' bin_variable(trials = 10, prob = 0.3)
#'
#'
source("R/privatecheckerfunctions.R")
bin_variable <- function(trials, prob, class = "binvar") {
  if(check_trials(trials) != TRUE) {
    stop("invalid trials value")
  } else if(check_prob(prob) != TRUE) {
    stop("invalid probability value")
  } else {
    x <- list(trials = trials, prob = prob)
    class(x) <- c("binvar")
    return(x)
  }
}

#' @export
print.binvar <- function(x, ...) {
  cat("'Binomial variable'", "\n")
  cat("\n")
  cat("Parameters", "\n")
  cat(paste("- number of trials: ", x$trials), "\n")
  cat(paste("- prob of success : ", x$prob), "\n")
}

bin1 <- bin_variable(trials = 10, p = 0.3)
bin1

#' @export
summary.binvar <- function(x, ...) {
  y <- list(trials = x$trials, prob = x$prob, mean = aux_mean(x$trial, x$prob), variance = aux_variance(x$trial, x$prob),
            mode = aux_mode(x$trial, x$prob), skewness = aux_skewness(x$trial, x$prob), kurtosis = aux_kurtosis(x$trial, x$prob))
  class(y) <- c("summary.binvar")
  return(y)
}

#' @export
print.summary.binvar <- function(y, ...) {
  cat("'Summary Binomial'", "\n")
  cat("\n")
  cat("Parameters", "\n")
  cat(paste("- number of trials: ", y$trials), "\n")
  cat(paste("- prob of success : ", y$prob), "\n")
  cat("\n")
  cat("Measures", "\n")
  cat(paste("- mean    : ", y$mean), "\n")
  cat(paste("- variance: ", y$variance), "\n")
  cat(paste("- mode    : ", y$mode), "\n")
  cat(paste("- skewness: ", y$skewness), "\n")
  cat(paste("- kurtosis: ", y$kurtosis), "\n")
}

bin1 <- bin_variable(trials = 10, p = 0.3)
binsum1 <- summary(bin1)
binsum1

#MAIN FUNCTIONS
#' @title Binomial Mean
#' @description computes the expected number of successes in the given number of trials
#' @param trials numeric, number of trials
#' @param prob numeric, probability of success
#' @return Expected number of successes
#' @export
#' @examples
#' bin_mean(10, 0.3)
#'
#'
bin_mean <- function(trials, prob) {
  return(aux_mean(trials, prob))
}

bin_mean(10, 0.3)

#' @title Binomial Variance
#' @description computes the variance of the binomial distribution
#' @param trials numeric, number of trials
#' @param prob numeric, probability of success
#' @return variance of the binomial distribution
#' @export
#' @examples
#' bin_variance(10, 0.3)
#'
#'
bin_variance <- function(trials, prob) {
  return(aux_variance(trials, prob))
}

bin_variance(10, 0.3)

#' @title Binomial Mode
#' @description computes the most likely number of successes in "trials" independent trials with probaility of success "prob" on each trial
#' @param trials numeric, number of trials
#' @param prob numeric, probability of success
#' @return mode of the binomial distribution
#' @export
#' @examples
#' bin_mode(10, 0.3)
#'
#'
bin_mode <- function(trials, prob) {
  return(aux_mode(trials, prob))
}

bin_mode(10, 0.3)

#' @title Binomial Skewness
#' @description computes the measure of the asymmetry of the probability distribution of a random variable about its mean
#' @param prob numeric, probability of success
#' @return skewness of the binomial distribution
#' @export
#' @examples
#' bin_skewness(10, 0.3)
#'
#'
bin_skewness <- function(trials, prob) {
  return(aux_skewness(trials, prob))
}

bin_skewness(10, 0.3)

#' @title Binomial Kurtosis
#' @description computes the measure of the "tailedness" of the probability distribution of a random variable
#' @param prob numeric, probability of success
#' @return kurtosis of the binomial distribution
#' @export
#' @examples
#' bin_kurtosis(10, 0.3)
#'
#'
bin_kurtosis <- function(trials, prob) {
  return(aux_kurtosis(trials, prob))
}

bin_kurtosis(10, 0.3)
