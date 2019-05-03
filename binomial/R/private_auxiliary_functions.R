#Private Auxiliary Functions
#All of the following functions will be invoked by their corresponding main functions
#Each of the following functions takes in two arguments: trials and prob

#aux_mean() is a private auxiliary function that computes the mean
#The mean of a binomial distribution is the expected number of successes in n trials
# Inputs: trials (how many trials), prob(probability of success)
# Output: a numeric value
aux_mean <- function(trials, prob) {
  return(trials*prob)
}

#aux_variance() is a private auxiliary function that computes the variance of the binomial distribution
# Inputs: trials (how many trials), prob(probability of success)
# Output: a numeric value
aux_variance <- function(trials, prob) {
  return(trials*prob*(1-prob))
}

#aux_mode() is a private auxiliary function that returns the mode
#The mode is the most likely number of successes in n independent trials with probaility prob of success on each trial
#It is the greater integer less than or equal to n*prob + prob (= m)
#The most likely numbers are m and m-1 if m is an integer
# Inputs: trials (how many trials), prob(probability of success)
# Output: a numeric value
aux_mode <- function(trials, prob) {
  m <- trials*prob + prob
  if(m%%1 == 0) {
    return(m, m-1)
  } else {
    return(m%/%1)
  }
}

#aux_skewness() is a private auxiliary function that computes the skewness
#Skewness is a measure of the asymmetry of the probability distribution of a random variable about its mean
#Can be positive or negative or undefined
# Inputs: trials (how many trials), prob(probability of success)
# Output: a numeric value
aux_skewness <- function(trials, prob) {
  return((1-2*prob)/sqrt(trials*prob*(1-prob)))
}

#aux_kurtosis() is a private auxiliary function that computes the Kurtosis
#The Kurtosis is a measure of the "tailedness" of the probability distribution of a random variable
#Descriptor of the shape of a probability distribution
# Inputs: trials (how many trials), prob(probability of success)
# Output: a numeric value
aux_kurtosis <- function(trials, prob) {
  return((1-(6*prob)*(1-prob))/(trials*prob*(1-prob)))
}
