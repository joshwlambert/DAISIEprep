test_that("all_endemicity_status works as expected", {
  endemicity <- all_endemicity_status()
  expect_identical(endemicity, c("not_present", "endemic", "nonendemic"))
})

test_that("all_endemicity_status fails as expected", {
  expect_error(all_endemicity_status("fake_argument"))
})

test_that("get_sse_tip_states works as expected", {
  phylod <- create_test_phylod(test_scenario = 1)
  sse_states <- get_sse_tip_states(phylod = phylod, sse_model = "musse")
  expect_length(sse_states, 2)
  expect_identical(sse_states, c(bird_a = 1L, bird_b = 3L))
})

test_that("get_sse_tip_states works as expected", {
  phylod <- create_test_phylod(test_scenario = 2)
  sse_states <- get_sse_tip_states(phylod = phylod, sse_model = "musse")
  expect_length(sse_states, 3)
  expect_identical(sse_states, c(bird_a = 1L, bird_b = 1L, bird_c = 3L))
})

test_that("get_sse_tip_states fails as expected", {
  expect_error(get_sse_tip_states(phylod = "phylod", sse_model = "musse"))
  phylod <- create_test_phylod(test_scenario = 2)
  expect_error(
    get_sse_tip_states(phylod = phylod, sse_model = "sse"),
    regexp = 'sse_model should be either "musse" or "geosse".'
  )
})

test_that("endemicity_to_sse_states works as expected", {
  expect_identical(
    endemicity_to_sse_states(
      endemicity_status = "endemic", sse_model = "musse"
    ),
    2L
  )
  expect_identical(
    endemicity_to_sse_states(
      endemicity_status = "nonendemic", sse_model = "musse"
    ),
    3L
  )
  expect_identical(
    endemicity_to_sse_states(
      endemicity_status = "not_present", sse_model = "musse"
    ),
    1L
  )
  expect_identical(
    endemicity_to_sse_states(
      endemicity_status = "endemic", sse_model = "geosse"
    ),
    2
  )
  expect_identical(
    endemicity_to_sse_states(
      endemicity_status = "nonendemic", sse_model = "geosse"
    ),
    0
  )
  expect_identical(
    endemicity_to_sse_states(
      endemicity_status = "not_present", sse_model = "geosse"
    ),
    1
  )
})

test_that("endemicity_to_sse_states fails as expected", {
  expect_error(
    endemicity_to_sse_states(
      endemicity_status = "island_endemic", sse_model = "musse"
    ),
    regexp = 'status should only be "not_present", "endemic" or "nonendemic"'
  )

  expect_error(
    endemicity_to_sse_states(
      endemicity_status = "endemic", sse_model = "bisse"
    ),
    regexp = 'sse_model should be either "musse" or "geosse".'
  )
})

test_that("sse_states_to_endemicity works as expected", {
  expect_identical(
    sse_states_to_endemicity(states = 2, sse_model = "musse"),
    "endemic"
  )
  expect_identical(
    sse_states_to_endemicity(states = 3, sse_model = "musse"),
    "nonendemic"
  )
  expect_identical(
    sse_states_to_endemicity(states = 1, sse_model = "musse"),
    "not_present"
  )
  expect_identical(
    sse_states_to_endemicity(states = 2, sse_model = "geosse"),
    "endemic"
  )
  # TODO: check if this issue is fixed
  # expect_identical(
  #  sse_states_to_endemicity(states = 0, sse_model = "geosse"),
  #  "nonendemic"
  # )
  expect_identical(
    sse_states_to_endemicity(states = 1, sse_model = "geosse"),
    "not_present"
  )
})
