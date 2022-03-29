test_that("translate_status works on endemic variants", {
  expect_equal(translate_status("endemic"), "endemic")
  expect_equal(translate_status("Endemic"), "endemic")
})

test_that("translate_status works on nonendemic variants", {
  expect_equal(translate_status("nonendemic"), "nonendemic")
  expect_equal(translate_status("Non_endemic"), "nonendemic")
  expect_equal(translate_status("Non_Endemic"), "nonendemic")
  expect_equal(translate_status("NonEndemic"), "nonendemic")
  expect_equal(translate_status("Nonendemic"), "nonendemic")
  expect_equal(translate_status("non_endemic"), "nonendemic")
  expect_equal(translate_status("Non-endemic"), "nonendemic")
  expect_equal(translate_status("Non-Endemic"), "nonendemic")
  expect_equal(translate_status("non-endemic"), "nonendemic")
})

test_that("translate_status works on endemic_max_age variants", {
  expect_equal(translate_status("Endemic_MaxAge"), "endemic_max_age")
  expect_equal(translate_status("Endemic_maxage"), "endemic_max_age")
  expect_equal(translate_status("Endemic_Max_Age"), "endemic_max_age")
  expect_equal(translate_status("EndemicMaxAge"), "endemic_max_age")
  expect_equal(translate_status("Endemicmaxage"), "endemic_max_age")
  expect_equal(translate_status("endemicMaxage"), "endemic_max_age")
  expect_equal(translate_status("Endemic_Maxage"), "endemic_max_age")
  expect_equal(translate_status("EndemicMaxage"), "endemic_max_age")
  expect_equal(translate_status("endemic_maxage"), "endemic_max_age")
  expect_equal(translate_status("endemicmaxage"), "endemic_max_age")
  expect_equal(translate_status("endemic_Maxage"), "endemic_max_age")
  expect_equal(translate_status("endemic_MaxAge"), "endemic_max_age")
  expect_equal(translate_status("endemic_maxAge"), "endemic_max_age")
  expect_equal(translate_status("Endemic-MaxAge"), "endemic_max_age")
  expect_equal(translate_status("Endemic-maxage"), "endemic_max_age")
  expect_equal(translate_status("Endemic-Max-Age"), "endemic_max_age")
  expect_equal(translate_status("Endemic-Maxage"), "endemic_max_age")
  expect_equal(translate_status("endemic-maxage"), "endemic_max_age")
  expect_equal(translate_status("endemic-Maxage"), "endemic_max_age")
  expect_equal(translate_status("endemic-MaxAge"), "endemic_max_age")
  expect_equal(translate_status("endemic-maxAge"), "endemic_max_age")
})

test_that("translate_status works on nonendemic_max_age variants", {
  expect_equal(translate_status("Non_endemic_MaxAge"), "nonendemic_max_age")
  expect_equal(translate_status("Non_Endemic_MaxAge"), "nonendemic_max_age")
  expect_equal(translate_status("Non_Endemic_Max_Age"), "nonendemic_max_age")
  expect_equal(translate_status("Non_endemic_maxage"), "nonendemic_max_age")
  expect_equal(translate_status("Non_Endemic_Maxage"), "nonendemic_max_age")
  expect_equal(translate_status("Non_Endemic_maxage"), "nonendemic_max_age")
  expect_equal(translate_status("Non_endemic_Maxage"), "nonendemic_max_age")
  expect_equal(translate_status("NonEndemic_MaxAge"), "nonendemic_max_age")
  expect_equal(translate_status("Non-endemic-MaxAge"), "nonendemic_max_age")
  expect_equal(translate_status("Non-Endemic-MaxAge"), "nonendemic_max_age")
  expect_equal(translate_status("Non-Endemic-Max_Age"), "nonendemic_max_age")
  expect_equal(translate_status("Non-endemic-maxage"), "nonendemic_max_age")
  expect_equal(translate_status("Non-Endemic-Maxage"), "nonendemic_max_age")
  expect_equal(translate_status("Non-Endemic-maxage"), "nonendemic_max_age")
  expect_equal(translate_status("Non-endemic-Maxage"), "nonendemic_max_age")
  expect_equal(translate_status("NonEndemic-MaxAge"), "nonendemic_max_age")
})

test_that("translate_status works on endemic&nonendemic variants", {
  expect_equal(translate_status("Endemic&Non_endemic"), "endemic&nonendemic")
  expect_equal(translate_status("Endemic&NonEndemic"), "endemic&nonendemic")
  expect_equal(translate_status("Endemic&Non_Endemic"), "endemic&nonendemic")
  expect_equal(translate_status("Endemic&Non-endemic"), "endemic&nonendemic")
  expect_equal(translate_status("Endemic&Non-Endemic"), "endemic&nonendemic")
})

test_that("translate_status works on endemic_max_age_min_age variants", {
  expect_equal(
    translate_status("Endemic_MaxAgeMinAge"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("endemic_MaxAgeMinAge"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic_MaxAge_MinAge"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic_Maxage_Minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic_Max_Age_Min_Age"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("endemic_maxage_minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("endemic_Maxage_minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("endemic_Maxage_Minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic_Maxage_minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("endemic_maxage_Minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic_MaxageMinage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic_Maxageminage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic_MaxAge_Minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic_maxageminage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic_maxageMinage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic-MaxAgeMinAge"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("endemic-MaxAgeMinAge"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic-MaxAge-MinAge"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic-Maxage-Minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic-Max-Age-Min-Age"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("endemic-maxage-minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("endemic-Maxage-minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("endemic-Maxage-Minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic-Maxage-minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("endemic-maxage-Minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic-MaxageMinage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic-Maxageminage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic-MaxAge-Minage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic-maxageminage"),
    "endemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Endemic-maxageMinage"),
    "endemic_max_age_min_age"
  )
})

test_that("translate_status works on nonendemic_max_age_min_age variants", {
  expect_equal(
    translate_status("Non_endemic_MaxAgeMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non_Endemic_MaxAgeMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non_endemic_MaxAge_MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non_Endemic_MaxAge_MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non_Endemic_Max_AgeMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non_endemic_maxage_minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non_Endemic_MaxageminAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non_Endemic_maxage_minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non_endemic_MaxageMinage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic_MaxageMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Nonendemic_MaxageMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Nonendemic_Maxage_MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Nonendemic_maxage_minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Nonendemic_Maxage_minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Nonendemic_Maxage_Minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic_MaxAge_MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic_Maxage_MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic_Maxage_Minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic_maxage_minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic_Maxage_minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non_Endemic_maxAgeMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic_MaxAge_Minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non_Endemic_MaxAge_Minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic_maxage_MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-endemic-MaxAgeMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-Endemic-MaxAgeMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-endemic-MaxAge-MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-Endemic-MaxAge-MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-Endemic-Max-AgeMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-endemic-maxage-minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-Endemic-MaxageminAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-Endemic-maxage-minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-endemic-MaxageMinage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic-MaxageMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Nonendemic-MaxageMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Nonendemic-Maxage_MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Nonendemic-maxage-minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Nonendemic-Maxage-minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Nonendemic-Maxage-Minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic-MaxAge-MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic-Maxage-MinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic-Maxage-Minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic-maxage-minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic-Maxage-minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-Endemic-maxAgeMinAge"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic-MaxAge-Minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("Non-Endemic-MaxAge-Minage"),
    "nonendemic_max_age_min_age"
  )
  expect_equal(
    translate_status("NonEndemic-maxage-MinAge"),
    "nonendemic_max_age_min_age"
  )
})
