WikidataR
=========

An R API wrapper for the Wikidata store of semantic data.

__Author:__ Oliver Keyes, Serena Signorelli & Christian Graul<br/> 
__License:__ [MIT](http://opensource.org/licenses/MIT)<br/>
__Status:__ Stable

[![Travis-CI Build Status](https://travis-ci.org/Ironholds/WikidataR.svg?branch=master)](https://travis-ci.org/Ironholds/WikidataR)![downloads](http://cranlogs.r-pkg.org/badges/grand-total/WikidataR)

Description
======
WikidataR is a wrapper around the Wikidata API. It is written in and for R, and was inspired by Christian Graul's
[rwikidata](https://github.com/chgrl/rwikidata) project. For details on how to best use it, see the [explanatory
vignette](https://CRAN.R-project.org/package=WikidataR/vignettes/Introduction.html).

Please note that this project is released with a
[Contributor Code of Conduct](https://github.com/Ironholds/WikidataR/blob/master/CONDUCT.md).
By participating in this project you agree to abide by its terms.

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
* [httr](https://cran.r-project.org/package=httr) and its dependencies.
* [WikipediR](https://cran.r-project.org/package=WikipediR)
