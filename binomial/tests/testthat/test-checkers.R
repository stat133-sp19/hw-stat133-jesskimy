context("Checker Functions")

test_that("check_prob with valid prob of numeric value between 0 and 1 and of length 1 returns TRUE", {

  expect_true(check_prob(0.6))
  expect_true(check_prob(1/2))
  expect_that(length(prob), is(1))
})

test_that("check_prob fails with invalid prob", {

  expect_error(check_prob(1.2), "prob has to be a number (of length 1) between 0 and 1")
  expect_error(check_prob(c(1, 1/2)), "prob has to be a number (of length 1) between 0 and 1")
})

test_that("check_trials with valid trials of positive integer value returns TRUE", {

  expect_true(check_trials(500))
  expect_that(length(trials), is(1))
})

test_that("check_trials fails with invalid trials", {

  expect_error(check_trials(0), 'invalid trials value')
  expect_error(check_trials(3.5), 'invalid trials value')
  expect_error(check_trials(-2), 'invalid trials value')
})

test_that("check_success with valid success and trials values returns TRUE (success nust be less than or equal to trials)", {

  expect_true(check_success(c(10, 5), 20))
  expect_true(check_success(c(0), 2))
  expect_that(length(check_success(c(10), 2)), is(1))
})

test_that("check_success fails with invalid success and/or trials", {
  expect_error(check_success(c(10), 5), 'success cannot be greater than trials')
  expect_error(check_success(c(-2), 5), 'invalid success value')
})
