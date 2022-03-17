test_that("Species are not conspecific", {
  descendants <- c("bird_a", "bird_b", "bird_c")
  expect_false(
    all_descendants_conspecific(descendants = descendants)
  )
})

test_that("Species are conspecific", {
  descendants <- c("bird_a_1", "bird_a_2", "bird_a_3")
  expect_true(
    all_descendants_conspecific(descendants = descendants)
  )
})


