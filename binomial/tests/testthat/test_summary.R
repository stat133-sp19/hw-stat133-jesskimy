context("Summary Measures")

test_that("aux_mean with valid trials and prob gives the correct numeric output", {

  expect_equal(aux_mean(10, 0.4), 4)
  expec_is(aux_mean(10, 0.2), "numeric")
})

test_that("aux_variance with valid trials and prob gives the correct numeric output for variance", {

  expect_equal(aux_variance(10, 0.4), 2.4)
  expect_is(aux_variance(10, 0.2), "numeric")
})

test_that("aux_mode with valid trials and prob gives the correct numeric output(s) for mode", {

  expect_equal(aux_mode(10, 0.3), 3)
  expect_that(length(aux_mode(3, 0.5)), equals(2))
  expect_that(length(aux_mode(10, 0.3)), equals(1))
  expect_is(aux_mode(10, 0.2), "numeric")
})

test_that("aux_skewness with valid trials and prob gives the correct numeric output for skewness", {

  expect_equal(aux_skewness(10, 0.3), (1-2*0.3)/sqrt(10*0.3*0.7))
  expect_is(aux_skewness(10, 0.2), "numeric")
})

test_that("aux_kurtosis with valid trials and prob gives correct numeric output for kurtosis", {

  expect_equal(aux_kurtosis(10, 0.3), (1-(6*0.3)*(1-0.3))/(10*0.3*0.7))
  expect_is(aux_kurtosis(10, 0.2), "numeric")
})
