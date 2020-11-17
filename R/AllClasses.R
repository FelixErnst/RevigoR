#' @include RevigoR.R
NULL

#' RevigoRData class
#' 
#' This class is a container for holding data returned from the ReViGo web 
#' service.
#' 
#' @slot listData a \code{\link[S4Vectors:SimpleList-class]{SimpleList}} with 
#'   two entries, \code{table} and \code{treemap}
#' 
#' @name RevigoRData-class
#' 
#' @export
setClass("RevigoRData",
         contains = "SimpleList")
