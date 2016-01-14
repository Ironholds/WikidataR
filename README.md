WikidataR
=========

An R API wrapper for the Wikidata store of semantic data.

__Author:__ Oliver Keyes & Christian Graul<br/> 
__License:__ [MIT](http://opensource.org/licenses/MIT)<br/>
__Status:__ Stable

![downloads](http://cranlogs.r-pkg.org/badges/grand-total/WikidataR)

Description
======
WikidataR is a wrapper around the Wikidata API. It is written in and for R, and was inspired by Christian Graul's
[rwikidata](https://github.com/chgrl/rwikidata) project. For details on how to best use it, see the [explanatory
vignette](https://cran.r-project.org/web/packages/WikidataR/vignettes/Introduction.html).

![downloads](http://cranlogs.r-pkg.org/badges/grand-total/WikidataR)

Installation
======

For the most recent CRAN version:

    install.packages("WikidataR")
    
For the development version:

    library(devtools)
    devtools::install_github("ironholds/WikidataR")
    
Dependencies
======
* R. Doy.
* [httr](http://cran.r-project.org/web/packages/httr/index.html) and its dependencies.
* [WikipediR](https://github.com/Ironholds/WikipediR)