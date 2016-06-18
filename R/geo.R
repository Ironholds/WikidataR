#'@title Retrieve geographic information from Wikidata
#'@description \code{get_geo_entity} retrieves any object
#'with geographic data associated with a geographically-tagged entity
#'(for example: a city).
get_geo_entity <- function(entity, radius = NULL, ...){
  
  if(is.null(radius)){
    query <- paste0("SELECT DISTINCT ?item ?name ?coord ?propertyLabel WHERE {
                      ?item wdt:P131* wd:", entity, ". ?item wdt:P625 ?coord .
                      ?item wdt:P31 ?property .
                      SERVICE wikibase:label {
                        bd:serviceParam wikibase:language \"bg\", \"cs\", \"da\",
                        \"de\", \"el\", \n    \"en\", \"es\", \"et\", \"fi\",
                        \"fr\", \"ga\", \"hr\", \"hu\", \"is\", \"it\", \"lt\", \"lv\", 
                        \"mk\", \"mt\", \"nl\", \"no\", \"pl\", \"pt\", \"ro\",
                        \"ru\", \"sk\", \"sl\", \"sq\", \"sr\", \n    \"sv\", \"tr\".
                        ?item rdfs:label ?name
                      }
                      SERVICE wikibase:label {
                        bd:serviceParam wikibase:language \"en\"
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
                        bd:serviceParam wikibase:language \"bg\", \"cs\",
                        \"da\", \"de\", \"el\", \n\"en\", \"es\", \"et\",
                        \"fi\", \"fr\", \"ga\", \"hr\", \"hu\", \"is\", \"it\",
                        \"lt\", \"lv\", \n\"mk\", \"mt\", \"nl\", \"no\",
                        \"pl\", \"pt\", \"ro\", \"ru\", \"sk\", \"sl\", \"sq\",
                        \"sr\", \n\"sv\", \"tr\".
                        ?item rdfs:label ?name
                      }
                    } ORDER BY ASC (?name)")
  }
  if(length(query) > 1){
    return(lapply(query, function(x, radius, ...){ return(sparql_query(x, radius, ...)$results$bindings)},
                  radius = radius, ...))
  }
  return(sparql_query(query)$results$bindings)
}