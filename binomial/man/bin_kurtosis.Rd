% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/binomial_functions.R
\name{bin_kurtosis}
\alias{bin_kurtosis}
\title{Binomial Kurtosis}
\usage{
bin_kurtosis(trials, prob)
}
\arguments{
\item{prob}{numeric, probability of success}
}
\value{
kurtosis of the binomial distribution
}
\description{
computes the measure of the "tailedness" of the probability distribution of a random variable
}
\examples{
bin_kurtosis(10, 0.3)


}
