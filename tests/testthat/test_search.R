context("Search functions")

test_that("English-language search works",{
  expect_true({find_item("Wonder Girls", "en");TRUE})
})

test_that("Non-English-language search works",{
  expect_true({find_item("Wonder Girls", "es");TRUE})
})

test_that("Search with limit modding works",{
  expect_that(length(find_item("Wonder Girls", "en", 3)), equals(3))
})

test_that("Property search works",{
  expect_true({find_property("Music", "en");TRUE})
})