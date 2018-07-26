#' @include RevigoR.R
NULL

# import -----------------------------------------------------------------------

#' @name getRevigo
#' @export
setGeneric( 
  name = "getRevigo",
  def = function(x,
                 pValueCutoff = 0.05) standardGeneric("getRevigo")
) 

# plotting ---------------------------------------------------------------------

#' @name plotRevigo
#' @export
setGeneric( 
  name = "plotRevigoScatter",
  def = function(x) standardGeneric("plotRevigoScatter")
) 

#' @name plotRevigo
#' @export
setGeneric( 
  name = "plotRevigoTreemap",
  def = function(x) standardGeneric("plotRevigoTreemap")
) 

