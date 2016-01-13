#Generic queryin' function for direct Wikidata calls. Wraps around WikipediR::page_content.
wd_query <- function(title, ...){
  result <- page_content(domain = "wikidata.org", page_name = title, as_wikitext = TRUE,
                         user_agent("WikidataR - https://github.com/Ironholds/WikidataR"),
                         ...)
  result <- result$parse$wikitext[[1]]
  result <- jsonlite::fromJSON(result)
  return(result)
}

#Query for a random item in "namespace" (ns). Essentially a wrapper around WikipediR::random_page.
wd_rand_query <- function(ns, ...){
  result <- random_page(domain = "wikidata.org", as_wikitext = TRUE, namespaces = ns,
                        httr::user_agent("WikidataR - https://github.com/Ironholds/WikidataR"),
                        ...)
  result <- result$parse$wikitext[[1]]
  result <- jsonlite::fromJSON(result)
  return(result)
  
}

#Generic input checker. Needs additional stuff for property-based querying
#because namespaces are weird, yo.
check_input <- function(input, substitution){
  if(grepl("^\\d+$",input)){
    input <- paste0(substitution,input)
  }
  return(input)
}

#Generic, direct access to Wikidata's search functionality.
searcher <- function(search_term, language, limit, type, ...){
  url <- paste0("wikidata.org/w/api.php?action=wbsearchentities&format=json&type=",type)
  url <- paste0(url, "&language=", language, "&limit=", limit, "&search=", search_term)
  result <- query(url, "list", FALSE, ...)
  result <- result$search
  return(result)
}