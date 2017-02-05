testthat::context("Geographic queries")

testthat::test_that("Simple entity-based geo lookups work", {
  field_names <- c("item", "name", "latitutde", "longitude", "entity")
  sf_locations <- get_geo_entity("Q62")
  testthat::expect_true(is.data.frame(sf_locations))
  testthat::expect_true(all(field_names == names(sf_locations)))
  testthat::expect_true(unique(sf_locations$entity) == "Q62")
})

testthat::test_that("Language-variant entity-based geo lookups work", {
  field_names <- c("item", "name", "latitutde", "longitude", "entity")
  sf_locations <- get_geo_entity("Q62", language = "fr")
  testthat::expect_true(is.data.frame(sf_locations))
  testthat::expect_true(all(field_names == names(sf_locations)))
  testthat::expect_true(unique(sf_locations$entity) == "Q62")
})

testthat::test_that("Radius restricted entity-based geo lookups work", {
  field_names <- c("item", "name", "latitutde", "longitude", "entity")
  sf_locations <- get_geo_entity("Q62", radius = 1)
  testthat::expect_true(is.data.frame(sf_locations))
  testthat::expect_true(all(field_names == names(sf_locations)))
  testthat::expect_true(unique(sf_locations$entity) == "Q62")
})

testthat::test_that("multi-entity geo lookups work", {
  field_names <- c("item", "name", "latitutde", "longitude", "entity")
  sf_locations <- get_geo_entity(c("Q62", "Q64"), radius = 1)
  testthat::expect_true(is.data.frame(sf_locations))
  testthat::expect_true(all(field_names == names(sf_locations)))
  testthat::expect_equal(length(unique(sf_locations$entity)), 2)
})

testthat::test_that("Simple bounding lookups work", {
  field_names <- c("item", "name", "latitutde", "longitude")
  bruges_box <- get_geo_box("Q12988", "NorthEast", "Q184287", "SouthWest")
  testthat::expect_true(is.data.frame(bruges_box))
  testthat::expect_true(all(field_names == names(bruges_box)))
})

testthat::test_that("Language-variant bounding lookups work", {
  field_names <- c("item", "name", "latitutde", "longitude")
  bruges_box <- get_geo_box("Q12988", "NorthEast", "Q184287", "SouthWest",
                            language = "fr")
  testthat::expect_true(is.data.frame(bruges_box))
  testthat::expect_true(all(field_names == names(bruges_box)))
})