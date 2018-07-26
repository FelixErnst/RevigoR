#' @include RevigoR.R
NULL


#' @rdname plotRevigo
#' 
#' @title Plotting ReViGo data
#' 
#' @description 
#' plotting stuff
#'
#' @param x a RevigoRData object
#'
#' @return a ggplot2 plot
#' @export
#'
#' @examples
#' \donttest{
#' rd <- getRevigo()
#' plotRevigoScatter(rd)
#' plotRevigoTreemap(rd)
#' }
setMethod(
  f = "plotRevigoScatter", 
  signature = signature(x = "RevigoRData"),
  definition = function(x){
    browser()
  }
)

#' @rdname plotRevigo
#' @export
setMethod(
  f = "plotRevigoTreemap", 
  signature = signature(x = "RevigoRData"),
  definition = function(x){
    browser()
  }
)
