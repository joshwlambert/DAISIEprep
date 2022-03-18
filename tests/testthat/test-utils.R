test_that("round_up works for positive numbers", {
  expect_equal(round_up(1.4), 1.0)
  expect_equal(round_up(1.5), 2.0)
  expect_equal(round_up(1.6), 2.0)
})

test_that("round_up works for negative numbers", {
  expect_equal(round_up(-1.4), -1.0)
  expect_equal(round_up(-1.5), -2.0)
  expect_equal(round_up(-1.6), -2.0)
})
