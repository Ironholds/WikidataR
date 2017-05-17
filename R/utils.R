#Generic queryin' function for direct Wikidata calls. Wraps around WikipediR::page_content.
wd_query <- function(title, ...){
  result <- WikipediR::page_content(domain = "wikidata.org", page_name = title, as_wikitext = TRUE,
                                    httr::user_agent("WikidataR - https://github.com/Ironholds/WikidataR"),
                                    ...)
  output <- jsonlite::fromJSON(result$parse$wikitext[[1]])
  return(output)
}

#Query for a random item in "namespace" (ns). Essentially a wrapper around WikipediR::random_page.
wd_rand_query <- function(ns, limit, ...){
  result <- WikipediR::random_page(domain = "wikidata.org", as_wikitext = TRUE, namespaces = ns,
                                   httr::user_agent("WikidataR - https://github.com/Ironholds/WikidataR"),
                                   limit = limit, ...)
  output <- lapply(result, function(x){jsonlite::fromJSON(x$wikitext[[1]])})
  class(output) <- "wikidata"
  return(output)
  
}

#Generic input checker. Needs additional stuff for property-based querying
#because namespaces are weird, yo.
check_input <- function(input, substitution){
  in_fit <- grepl("^\\d+$",input)
  if(any(in_fit)){
    input[in_fit] <- paste0(substitution, input[in_fit])
  }
  return(input)
}

#Generic, direct access to Wikidata's search functionality.
searcher <- function(search_term, language, limit, type, ...){
  result <- WikipediR::query(url = "https://www.wikidata.org/w/api.php", out_class = "list", clean_response = FALSE,
                             query_param = list(
                               action   = "wbsearchentities", 
                               type     = type,
                               language = language,
                               limit    = limit,
                               search   = search_term
                             ),
                             ...)
  result <- result$search
  return(result)
}

sparql_query <- function(params, ...){
  result <- httr::GET("https://query.wikidata.org/bigdata/namespace/wdq/sparql",
                      query = list(query = params),
                      httr::user_agent("WikidataR - https://github.com/Ironholds/WikidataR"),
                      ...)
  httr::stop_for_status(result)
  return(httr::content(result, as = "parsed", type = "application/json"))
}

#'@title Extract Claims from Returned Item Data
#'@description extract claim information from data returned using
#'\code{\link{get_item}}.
#'
#'@param items a list of one or more Wikidata items returned with
#'\code{\link{get_item}}.
#'
#'@param claims a vector of claims (in the form "P321", "P12") to look for
#'and extract.
#'
#'@return a list containing one sub-list for each entry in \code{items},
#'and (below that) the found data for each claim. In the event a claim
#'cannot be found for an item, an \code{NA} will be returned
#'instead.
#'
#'@examples
#'# Get item data
#'adams_data <- get_item("42")
#'
#'# Get claim data
#'claims <- extract_claims(adams_data, "P31")
#'
#'@export
extract_claims <- function(items, claims){
  output <- lapply(items, function(x, claims){
    return(lapply(claims, function(claim, obj){
      which_match <- which(names(obj$claims) == claim)
      if(!length(which_match)){
        return(NA)
      }
      return(obj$claims[[which_match[1]]])
    }, obj = x))
  }, claims = claims)
  
  return(output)
}
