#'@title Print method for find_item
#'
#'@description print found items.
#'
#'@param x find_item object with search results
#'@param \dots Arguments to be passed to methods
#'
#'@method print find_item
#'@export
print.find_item <- function(x, ...) {
  cat("\n\tWikidata item search\n\n")
	
  # number of results
  num_results <- length(x)
  cat("Number of results:\t", num_results, "\n\n")
		
  # results
  if(num_results > 0) {
    cat("Results:\n")
    for(i in 1:num_results) {
      if(is.null(x[[i]]$description)){
        desc <- "\n"
      }
      else {
        desc <- paste("-", x[[i]]$description, "\n")
      }
      cat(i, "\t", x[[i]]$label, paste0("(", x[[i]]$id, ")"), desc)
    }
  }
}

#'@title Print method for find_property
#'
#'@description print found properties.
#'
#'@param x find_property object with search results
#'@param \dots Arguments to be passed to methods
#'
#'@method print find_property
#'@export
print.find_property <- function(x, ...) {
  cat("\n\tWikidata property search\n\n")
	
  # number of results
  num_results <- length(x)
  cat("Number of results:\t", num_results, "\n\n")
		
  # results
  if(num_results > 0) {
    cat("Results:\n")
    for(i in seq_len(num_results)) {
      if(is.null(x[[i]]$description)){
        desc <- "\n"
      }
      else {
        desc <- paste("-", x[[i]]$description, "\n")
      }
      cat(i, "\t", x[[i]]$label, paste0("(", x[[i]]$id, ")"), desc)
    }
  }
}

#'@title Print method for Wikidata objects
#'
#'@description print found objects generally.
#'
#'@param x wikidata object from get_item, get_random_item, get_property or get_random_property
#'@param \dots Arguments to be passed to methods
#'@seealso get_item, get_random_item, get_property or get_random_property
#'@method print wikidata
#'@export
print.wikidata <- function(x, ...){
  cat("\n\tWikidata", x$type, x$id, "\n\n")
  
  # labels
  num.labels <- length(x$labels)
  if(num.labels>0) {
    lbl <- x$labels[[1]]$value
    if(num.labels==1) cat("Label:\t\t", lbl, "\n")
    else {
      if(!is.null(x$labels$en)) lbl <- x$labels$en$value
      cat("Label:\t\t", lbl, paste0("\t[", num.labels-1, " other languages available]\n"))
    }
  }
  
  # aliases
  num_aliases <- length(x$aliases)
  if(num_aliases > 0) {
    al <- unique(unlist(lapply(x$aliases, function(xl){return(xl$value)})))
    cat("Aliases:\t", paste(al, collapse = ", "), "\n")
  }
  
  # descriptions
  num_desc <- length(x$descriptions)
  if(num_desc > 0) {
    desc <- x$descriptions[[1]]$value
    if(num_desc == 1){
      cat("Description:", desc, "\n")
    }
    else {
      if(!is.null(x$descriptions$en)){
        desc <- x$descriptions$en$value
      }
      cat("Description:", desc, paste0("\t[", (num_desc - 1), " other languages available]\n"))
    }
  }
  
  # num claims
  num_claims <- length(x$claims)
  if(num_claims > 0){
    cat("Claims:\t\t", num_claims, "\n")
  }
  
  # num sitelinks
  num_links <- length(x$sitelinks)
  if(num_links > 0){
    cat("Sitelinks:\t", num_links, "\n")
  }
}