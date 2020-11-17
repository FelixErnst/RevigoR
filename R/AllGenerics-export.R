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

#' @rdname plotRevigo
#' @export
setGeneric( 
  name = "plotRevigoScatter",
  def = function(x,
                 xType = "X",
                 yType = "Y",
                 pointSizeType = "uniqueness",
                 colourType = "pvalue",
                 colour = "red",
                 size = 10,
                 showAllLabels = FALSE) standardGeneric("plotRevigoScatter")
) 

#' @rdname plotRevigo
#' @export
setGeneric( 
  name = "plotRevigoTreemap",
  def = function(x,
                 type = "pvalue",
                 palette = "Set1") standardGeneric("plotRevigoTreemap")
) 

# RevigoRData accessors --------------------------------------------------------

#' @rdname RevigoRData-accessors
#' @export
setGeneric( 
  name = "getTableData",
  def = function(x) standardGeneric("getTableData")
) 
#' @rdname RevigoRData-accessors
#' @export
setGeneric( 
  name = "getTreemapData",
  def = function(x) standardGeneric("getTreemapData")
) 
