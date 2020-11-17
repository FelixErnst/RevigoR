#' @title RevigoR
#' 
#' @author Felix G M Ernst [aut]
#' 
#' @description
#' RevigoR accesses the ReViGo service (http://revigo.irb.hr) for
#' given gene ontology terms and saves the data as a list like object of type
#' RevigoRData. Simple plotting functions are implemented, but can be extended 
#' upon if necessary.
#'
#' @docType package
#' @name RevigoR
NULL

#' @import methods
#' @import httr
#' @import ggplot2
#' @import S4Vectors
#' @importFrom RDAVIDWebService DAVIDFunctionalAnnotationChart
NULL
requireNamespace("S4Vectors")

#' RevigoR datasets
#' 
#' Internally used data for RevigoR examples and vignettes.
#' 
#' @name RevigoR-data
#' @docType data
#' @keywords datasets
#' @usage data(chart)
"chart"
#' @name RevigoR-data
#' @usage data(rd)
"rd"
#' @name RevigoR-data
#' @usage data(rdinput)
"rdinput"
