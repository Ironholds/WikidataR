#'@title Print method for find_item
#'
#'@param x find_item object with search results
#'@param \dots Arguments to be passed to methods
#'
#'@method print find_item
#'@export
print.find_item <- function(x, ...) {
  cat("\n\tWikidata item search\n\n")
	
  # number of results
  num.results <- length(x)
  cat("Number of results:\t", num.results, "\n\n")
		
  # results
  if(num.results>0) {
    cat("Results:\n")
    for(i in 1:num.results) {
      label <- x[[i]]$label
      id <- x[[i]]$id
      if(is.null(x[[i]]$description)) desc <- "\n"
      else desc <- paste("-", x[[i]]$description, "\n")
      cat(i, "\t", label, paste0("(", id, ")"), desc)
    }
  }
}

#'@title Print method for find_property
#'
#'@param x find_property object with search results
#'@param \dots Arguments to be passed to methods
#'
#'@method print find_property
#'@export
print.find_property <- function(x, ...) {
  cat("\n\tWikidata property search\n\n")
	
  # number of results
  num.results <- length(x)
  cat("Number of results:\t", num.results, "\n\n")
		
  # results
  if(num.results>0) {
    cat("Results:\n")
    for(i in 1:num.results) {
      label <- x[[i]]$label
      id <- x[[i]]$id
      if(is.null(x[[i]]$description)) desc <- "\n"
      else desc <- paste("-", x[[i]]$description, "\n")
      cat(i, "\t", label, paste0("(", id, ")"), desc)
    }
  }
}

#'@title Print method for Wikidata items
#'
#'@param x item object from get_item or get_random_item
#'@param \dots Arguments to be passed to methods
#'@method print wditem
#'@export
print.wditem <- function(x, ...) {
  
  cat("\n\tWikidata item", x$id, "\n\n")
  	
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
  num.alias <- length(x$aliases)
  if(num.alias>0) {
    al <- unique(unlist(lapply(x$aliases,function(xl) xl$value)))
    cat("Aliases:\t", paste(al, collapse=", "), "\n")
  }
  
  # description
  num.desc <- length(x$descriptions)
  if(num.desc>0) {
    desc <- x$descriptions[[1]]$value
    if(num.desc==1) cat("Description:", desc, "\n")
    else {
      if(!is.null(x$descriptions$en)) desc <- x$descriptions$en$value
      cat("Description:", desc, paste0("\t[", num.desc-1, " other languages available]\n"))
    }
  }
  	
  # num claims
  cat("Claims:\t\t", length(x$claims), "\n")

  # num sitelinks
  cat("Sitelinks:\t", length(x$sitelinks), "\n")
}
