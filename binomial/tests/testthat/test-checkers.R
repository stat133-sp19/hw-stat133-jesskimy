context("Checker Functions")

test_that("check_prob with valid prob", {

  expect_true(check_prob(0.6))
  expect_true(check_prob(1/2))
})

test_that("check_prob fails with invalid prob", {

  expect_error(check_prob(1.2))
  expect_error(check_prob(c(1, 1/2)))
})

#prob is a number between 0 and 1
#prob is of length 1
#getting an error if prob is invalid

test_that("check_trials with valid trials", {

  expect_true(check_trials(500))
})

test_that("check_trials fails with invalid trials", {

  expect_error(check_trials(0))
  expect_error(check_trials(3.5))
  expect_error(check_trials(-2))
})

