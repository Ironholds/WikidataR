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
