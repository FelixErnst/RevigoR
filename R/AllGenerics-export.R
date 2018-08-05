#' @include RevigoR.R
NULL

# import -----------------------------------------------------------------------

#' @name getRevigo
#' @export
setGeneric( 
  name = "getRevigo",
  def = function(x,
                 goCategory,
                 pValueCutoff = FALSE,
                 padjValueCutoff = FALSE,
                 ...) standardGeneric("getRevigo")
) 

# plotting ---------------------------------------------------------------------

#' @name plotRevigo
#' @export
setGeneric( 
  name = "plotRevigoScatter",
  def = function(x,
                 xType = "X",
                 yType = "Y",
                 pointSizeType = "uniqueness",
                 colourType = "pvalue",
                 colour = "red",
                 size = 10) standardGeneric("plotRevigoScatter")
) 

#' @name plotRevigo
#' @export
setGeneric( 
  name = "plotRevigoTreemap",
  def = function(x,
                 type = "pvalue",
                 palette = "Set1") standardGeneric("plotRevigoTreemap")
) 

