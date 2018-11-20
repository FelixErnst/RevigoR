#' @include RevigoR.R
NULL

#' @rdname getRevigo
#'
#' @param goCategory a string to choose a GO category
#' @param pValueCutoff a p-value cutoff for subsetting relevant GO terms 
#' (default:  \code{pValueCutoff = FALSE})
#' @param padjValueCutoff a p-adjusted value cutoff for subsetting to relevant
#' GO terms (default: \code{padjValueCutoff = FALSE}) using the Benjamini 
#' p-adjusted value as returned by the DAVID database.
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
                        padjValueCutoff = FALSE,
                        ...){
    # input check
    assertive::assert_is_a_non_empty_string(goCategory)
    if(assertive::is_not_false(as.logical(pValueCutoff))){
      assertive::assert_is_a_number(pValueCutoff)
    } else {
      pValueCutoff <- 1
    }
    if(assertive::is_not_false(as.logical(padjValueCutoff))){
      assertive::assert_is_a_number(padjValueCutoff)
    } else {
      padjValueCutoff <- 1
    }
    .checkValueValidity(goCategory,
                        unique(as.character(chart$Category)))
    #
    x <- x[x$Category == goCategory,]
    x <- x[str_detect(x$Term, "GO:"),]
    if(nrow(x) == 0){
      stop("No GO: terms found in selected go category '",goCategory,"'. Only ",
           "categores with GO:numbers are supported.",
           call. = FALSE)
    }
    # apply p value thresholds
    x <- x[x$PValue <= pValueCutoff & x$Benjamini <= padjValueCutoff,]
    if(nrow(x) == 0){
      stop("No GO terms with matching p-value thresholds found.")
    }
    # Assemble search input
    browser()
    goData <- data.frame(goTerms = stringr::str_extract(x$Term,"GO:([0-9]++)"),
                         value = x$PValue)
    rd <- do.call(getRevigo,
                  append(list(goData),
                         list(...)))
    return(rd)
  }
)