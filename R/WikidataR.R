#' @title API client library for Wikidata
#' @description This package serves as an API client for \href{Wikidata}{https://www.wikidata.org}.
#' See the accompanying vignette for more details.
#' 
#' @name WikidataR
#' @docType package
#'@seealso \code{\link{get_random}} for selecting a random item or property,
#'\code{\link{get_item}} for a /specific/ item or property, or \code{\link{find_item}}
#'for using search functionality to pull out item or property IDs where the descriptions
#'or aliases match a particular search term.
#' @importFrom WikipediR page_content random_page query
#' @importFrom httr user_agent
#' @importFrom jsonlite fromJSON
#' @aliases WikidataR WikidataR-package
NULL