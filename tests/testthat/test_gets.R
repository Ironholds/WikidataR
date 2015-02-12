context("Direct Wikidata get functions")

test_that("A specific item can be retrieved with an entire item code", {
  expect_true({get_item("Q100");TRUE})
})

test_that("A specific item can be retrieved with a partial entire item code", {
  expect_true({get_item("100");TRUE})
})

test_that("A specific property can be retrieved with an entire prop code + namespace", {
  expect_true({get_property("Property:P10");TRUE})
})

test_that("A specific property can be retrieved with an entire prop code + namespace", {
  expect_true({get_property("P10");TRUE})
})


test_that("A specific property can be retrieved with a partial prop code", {
  expect_true({get_property("10");TRUE})
})

test_that("A randomly-selected item can be retrieved",{
  expect_true({get_random_item();TRUE})
})

test_that("A randomly-selected property can be retriveed",{
  expect_true({get_random_property();TRUE})
})