WikidataR
=========

An R API wrapper for the Wikidata store of semantic data.

__Author:__ Oliver Keyes<br/>
__License:__ [MIT](http://opensource.org/licenses/MIT)<br/>
__Status:__ In development

Description
======
WikidataR is a wrapper around the Wikidata API. It is written in and for R, and was inspired by Christian Graul's
[rwikidata](https://github.com/chgrl/rwikidata) project. For details on how to best use it, see the [explanatory
vignette](https://github.com/Ironholds/WikidataR/blob/master/vignettes/Introduction.Rmd).

Installation
======

For the most recent version:

    library(devtools)
    devtools::install_github("ironholds/WikidataR",ref="0.5.0")
    
For the development version:

    library(devtools)
    devtools::install_github("ironholds/WikidataR")
    
Dependencies
======
* R. Doy.
* [httr](http://cran.r-project.org/web/packages/httr/index.html) and its dependencies.
* [WikipediR](https://github.com/Ironholds/WikipediR)