#' @include RevigoR.R
NULL

#' @rdname getRevigo
#' 
#' @description
#' Acc
#'
#' @param x a DAVIDFunctionalAnnotationChart object
#'
#' @return a RevigoRData object
#' 
#' @export
#'
#' @examples
#' \donttest{
#' go <- DAVIDFunctionalAnnotationChart()
#' getRevigo(go,
#'           pValueCutoff = 0.05)
#' }
setMethod(
  f = "getRevigo", 
  signature = signature(x = "DAVIDFunctionalAnnotationChart"),
  definition = function(x,
                        pValueCutoff = 0.05){
    browser()
  }
)