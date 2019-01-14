#' @include RevigoR.R
NULL

# #' @rdname getRevigo
# #'
# #' @description
# #' @section
# #' Acc
# #'
# #' @param x RevigoRData.
# #'
# #' @return a ggplot2 plot
# #'
# #' @importFrom GOdb
# #'
# #' @export
# #'
# #' @examples
# #' \donttest{
# #' go <- DAVIDFunctionalAnnotationChart()
# #' getRevigo(go,
# #'           pValueCutoff = 0.05)
# #' }
# setMethod(
#   f = "getRevigo",
#   signature = signature(x = "DAVIDFunctionalAnnotationChart"),
#   definition = function(x,
#                         pValueCutoff = 0.05){
#     browser()
#   }
# )