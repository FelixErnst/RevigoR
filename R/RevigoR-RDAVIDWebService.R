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
#' @importFrom stringr str_detect
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
  signature = signature(x = "DAVIDFunctionalAnnotationChart",
                        goCategory = "character"),
  definition = function(x,
                        goCategory,
                        pValueCutoff = FALSE,
                        padjValueCutoff = FALSE){
    # input check
    assertive::assert_is_a_non_empty_string(goCategory)
    if(assertive::is_not_false(as.logical(pValueCutoff))){
      assertive::assert_is_a_number(pValueCutoff)
    } else {
      pValueCutoff <- 0
    }
    if(assertive::is_not_false(as.logical(padjValueCutoff))){
      assertive::assert_is_a_number(padjValueCutoff)
    } else {
      padjValueCutoff <- 0
    }
    .checkValueValidity(goCategory,
                        unique(as.character(chart$Category)))
    #
    x <- x[x$Category == goCategory,]
    x <- x[str_detect(x$Term, "GO:"),]
    if(nrow(x) == 0){
      stop("No GO: terms found in selected go category '",goCategory,"'")
    }
    #
    goData <- data.frame(go = str_extract(x$Term,"GO:([0-9]++)"),
                         pvalue = x$PValue)
    
    browser()
  }
)