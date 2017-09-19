clean_geo <- function(results){
  do.call("rbind", lapply(results, function(item){
    point <- unlist(strsplit(gsub(x = item$coord$value, pattern = "(Point\\(|\\))", replacement = ""),
                             " "))
    wd_id <- gsub(x = item$item$value, pattern = "http://www.wikidata.org/entity/",
                  replacement = "", fixed = TRUE)
    return(data.frame(item = wd_id,
                      name = ifelse(item$name$value == wd_id, NA, item$name$value),
                      latitutde = as.numeric(point[1]),
                      longitude = as.numeric(point[2]),
                      stringsAsFactors = FALSE))
  
  }))
}

#'@title Retrieve geographic information from Wikidata
#'@description \code{get_geo_entity} retrieves the item ID, latitude
#'and longitude of any object with geographic data associated with \emph{another}
#'object with geographic data (example: all the locations around/near/associated with
#'a city).
#'
#'@param entity a Wikidata item (\code{Q...}) or series of items, to check
#'for associated geo-tagged items.
#'
#'@param language the two-letter language code to use for the name
#'of the item. "en" by default, because we're imperialist
#'anglocentric westerners.
#'
#'@param radius optionally, a radius (in kilometers) around \code{entity}
#'to restrict the search to.
#'
#'@param ... further arguments to pass to httr's GET.
#'
#'@return a data.frame of 5 columns:
#'\itemize{
#'  \item{item}{ the Wikidata identifier of each object associated with
#'  \code{entity}.}
#'  \item{name}{ the name of the item, if available, in the requested language. If it
#'  is not available, \code{NA} will be returned instead.}
#'  \item{latitude}{ the latitude of \code{item}}
#'  \item{longitude}{ the longitude of \code{item}}
#'  \item{entity}{ the entity the item is associated with (necessary for multi-entity
#'  queries).}
#'}
#'
#'@examples
#'# All entities
#'sf_locations <- get_geo_entity("Q62")
#'
#'# Entities with French, rather than English, names
#'sf_locations <- get_geo_entity("Q62", language = "fr")
#'
#'# Entities within 1km
#'sf_close_locations <- get_geo_entity("Q62", radius = 1)
#'
#'# Multiple entities
#'multi_entity <- get_geo_entity(entity = c("Q62", "Q64"))
#'
#'@seealso \code{\link{get_geo_box}} for using a bounding box
#'rather than an unrestricted search or simple radius.
#'
#'@export
get_geo_entity <- function(entity, language = "en", radius = NULL, ...){
  
  entity <- check_input(entity, "Q")
  
  if(is.null(radius)){
    query <- paste0("SELECT DISTINCT ?item ?name ?coord ?propertyLabel WHERE {
                      ?item wdt:P131* wd:", entity, ". ?item wdt:P625 ?coord .
                      SERVICE wikibase:label {
                        bd:serviceParam wikibase:language \"", language, "\" .
                        ?item rdfs:label ?name
                      }
                    }
                    ORDER BY ASC (?name)")
  } else {
    query <- paste0("SELECT ?item ?name ?coord
                    WHERE {
                      wd:", entity, " wdt:P625 ?mainLoc .
                      SERVICE wikibase:around { 
                        ?item wdt:P625 ?coord .
                        bd:serviceParam wikibase:center ?mainLoc .
                        bd:serviceParam wikibase:radius \"", radius,
                        "\" .
                      }
                      SERVICE wikibase:label {
                        bd:serviceParam wikibase:language \"", language, "\" .
                        ?item rdfs:label ?name
                      }
                    } ORDER BY ASC (?name)")
  }
  
  if(length(query) > 1){
     return(do.call("rbind", mapply(function(query, entity, ...){
      output <- clean_geo(sparql_query(query, ...)$results$bindings)
      output$entity <- entity
      return(output)
    }, query = query, entity = entity, ..., SIMPLIFY = FALSE)))
  }
  output <- clean_geo(sparql_query(query)$results$bindings)
  output$entity <- entity
  return(output)
}

#'@title Get geographic entities based on a bounding box
#'@description \code{get_geo_box} retrieves all geographic entities in
#'Wikidata that fall between a bounding box between two existing items
#'with geographic attributes (usually cities).
#'
#'@param first_city_code a Wikidata item, or series of items, to use for
#'one corner of the bounding box.
#'
#'@param first_corner the direction of \code{first_city_code} relative
#'to \code{city} (eg "NorthWest", "SouthEast").
#'
#'@param second_city_code a Wikidata item, or series of items, to use for
#'one corner of the bounding box.
#'
#'@param second_corner the direction of \code{second_city_code} relative
#'to \code{city} (eg "NorthWest", "SouthEast").
#'
#'@param language the two-letter language code to use for the name
#'of the item. "en" by default.
#'
#'@param ... further arguments to pass to httr's GET.
#'
#'@return a data.frame of 5 columns:
#'\itemize{
#'  \item{item}{ the Wikidata identifier of each object associated with
#'  \code{entity}.}
#'  \item{name}{ the name of the item, if available, in the requested language. If it
#'  is not available, \code{NA} will be returned instead.}
#'  \item{latitude}{ the latitude of \code{item}}
#'  \item{longitude}{ the longitude of \code{item}}
#'  \item{entity}{ the entity the item is associated with (necessary for multi-entity
#'  queries).}
#'}
#'
#'@examples
#'# Simple bounding box
#'bruges_box <- WikidataR:::get_geo_box("Q12988", "NorthEast", "Q184287", "SouthWest")
#'
#'# Custom language
#'bruges_box_fr <- WikidataR:::get_geo_box("Q12988", "NorthEast", "Q184287", "SouthWest",
#'                                         language = "fr")
#'
#'@seealso \code{\link{get_geo_entity}} for using an unrestricted search or simple radius,
#'rather than a bounding box.
#'
#'@export
get_geo_box <- function(first_city_code, first_corner, second_city_code, second_corner,
                        language = "en", ...){
  
  # Input checks
  first_city_code <- check_input(first_city_code, "Q")
  second_city_code <- check_input(second_city_code, "Q")
  
  # Construct query
  query <- paste0("SELECT ?item ?name ?coord WHERE {
                    wd:", first_city_code, " wdt:P625 ?Firstloc .
                    wd:", second_city_code, " wdt:P625 ?Secondloc .
                    SERVICE wikibase:box {
                      ?item wdt:P625 ?coord .
                      bd:serviceParam wikibase:corner", first_corner, " ?Firstloc .
                      bd:serviceParam wikibase:corner", second_corner, " ?Secondloc .
                    }
                    SERVICE wikibase:label {
                      bd:serviceParam wikibase:language \"", language, "\" .
                      ?item rdfs:label ?name
                    }
                  }ORDER BY ASC (?name)")
  
  # Vectorise if necessary, or not if not!
  if(length(query) > 1){
    return(do.call("rbind", mapply(function(query, ...){
      output <- clean_geo(sparql_query(query, ...)$results$bindings)
      return(output)
    }, query = query, ..., SIMPLIFY = FALSE)))
  }
  output <- clean_geo(sparql_query(query)$results$bindings)
  return(output)
}