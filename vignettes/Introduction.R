## ---- eval=FALSE---------------------------------------------------------
#  #Retrieve an item
#  item <- get_item(id = 1)
#  
#  #Get information about the property of the first claim it has.
#  first_claim <- get_property(id = names(item$claims)[1])
#  #Do we succeed? Dewey!

## ---- eval=FALSE---------------------------------------------------------
#  #Retrieve a random item
#  rand_item <- get_random_item()
#  
#  #Retrieve a random property
#  rand_prop <- get_random_property()

## ---- eval=FALSE---------------------------------------------------------
#  #Find item - find defaults to "en" as a language.
#  aarons <- find_item("Aaron Halfaker")
#  
#  #Find a property - also defaults to "en"
#  first_names <- find_property("first name")

## ---- eval=FALSE---------------------------------------------------------
#  #Find item.
#  all_aarons <- find_item("Aaron Halfaker")
#  
#  #Grab the ID code for the first entry and retrieve the associated item data.
#  first_aaron <- get_item(aall_aarons[[1]]$id)

