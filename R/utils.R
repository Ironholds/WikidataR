#'@importFrom WikipediR page_content
#'@importFrom httr user_agent
wd_query <- function(title, ...){
  result <- page_content(domain = "wikidata.org", page = title, as_wikitext = TRUE,
                         user_agent("WikidataR - https://github.com/Ironholds/WikidataR"),
                         ...)
  result <- result$parse$wikitext[[1]]
  result <- fromJSON(result)
}

check_input <- function(input, substitution){
  if(grepl("^\\d+$",input)){
    input <- paste0(substitution,input)
  }
  return(input)
}

