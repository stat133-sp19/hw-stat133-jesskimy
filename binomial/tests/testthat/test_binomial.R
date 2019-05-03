context("Binomial Functions")

test_that("bin_choose with valid n and k returns the correct number of comnbinations in which k successes can occur in n trials; error message shows otherwise", {

  expect_equal(bin_choose(n = 5, k = 2), choose(5,2))
  expect_equal(bin_choose(5, 0), choose(5,0))
  expect_equal(bin_choose(5, 1:3), c(choose(5,1), choose(5,2), choose(5,3)))
  expect_equal(length(bin_choose(5, 1:3)), 3)
  expect_error(bin_choose(5, 10), "k cannot be greater than n")
})

test_that("bin_probability with valid success, trials, and prob returns the correct probability of success; errors if value(s) are invalid", {
  expect_equal(bin_probability(success = 2, trials = 5, prob = 0.5), 0.3125)
  expect_equal(bin_probability(success = 55, trials = 100, prob = 0.45), choose(100, 55) * 0.45^55 * 0.55^45)
  expect_equal(length(bin_probability(success = 0:2, trials = 5, prob = 0.5)), 3)
  expect_error(bin_probability(success = 0:2, trials = -2, prob = 0.5), "invalid trials value")
  expect_error(bin_probability(success = 10, trials = 5, prob = 0.5), "success cannot be greater than trials")
  expect_error(bin_probability(success = 0:2, trials = 5, prob = 1.9), "prob has to be a number (of length 1) between 0 and 1")
})

test_that("bin_distribution with valid trials and prob returns a data frame with class bindis and with success in the first column and probability is in the second column",{
  expect_s3_class(bin_distribution(trials = 5, prob = 0.5), "bindis")
  expect_is((bin_distribution(trials = 5, prob = 0.5)), "data.frame")
  expect_equal(ncol(bin_distribution(trials = 5, prob = 0.5)), 2)
  expect_equal(nrow(bin_distribution(trials = 5, prob = 0.5)), 6)
})

test_that("bin_cumulative with valid trials and prob returns a data frame of class bincum with success in the first column, probability is in the second, and cumulative probability is in the third", {
  expect_s3_class(bin_cumulative(trials = 5, prob = 0.5), "bincum")
  expect_is(bin_cumulative(trials = 5, prob = 0.5), "data.frame")
  expect_equal(ncol(bin_cumulative(trials = 5, prob = 0.5)), 3)
  expect_equal(nrow(bin_cumulative(trials = 5, prob = 0.5)), 6)
})

test_that("bin_variable with valid trials and prob returns a list of class binvar with trials and prob", {
  expect_s3_class(bin_variable(trials = 5, prob = 0.5), "binvar")
  expect_is(bin_variable(trials = 5, prob = 0.5), "list")
  expect_error(bin_variable(-10, 0.4), "invalid trials value")
  expect_error(bin_variable(10, 1.2), "invalid probability value")
})
