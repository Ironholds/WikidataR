format_claim <- function(property, item = NULL, is_string = FALSE){
  if(is.null(item)){
    return(paste0("[",property,"]"))
  } else {
    if(is_string){
      return(paste0("[",property,":\"",item,"\"]"))
    } else {
      return(paste0("[",property,":",item,"]"))
    }
  }
}

items_with_claims <- function(claims = list(), parse_response = FALSE, ...){
  
  #Check and format the claims, dispatching them to Magnus's
  #service when they're a single, AND separated string.
  if(length(claims) == 0){
    stop("No claims have been provided")
  }
  claims <- paste0(" AND claim", unlist(claims))
  claims[1] <- substr(claims[1],6,nchar(claims[1]))
  claims <- paste(claims, collapse = "")
  result <- magnus_query(claims, ...)  
  
  #If we want to simplify, simplify. Return either way.
  if(parse_response){
    result <- unlist(result$items)
  }
  return(result)
}
###items_with_claims(claims = list(format_claim("138","676555"), format_claim("31","515")))
items_in_tree <- function(claims = list(), ...){
  
  
}

items_in_web <- function(claims = list(), ...){
  
}