context("Binomial Functions")

test_that("bin_choose with valid n and k", {

  expect
})

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
