#' @include RevigoR.R
NULL

REVIGOR_URL_FORM <- "revigo.jsp"
REVIGOR_URL_RSCRIPT1 <- "toR.jsp?table=1"
REVIGOR_URL_CSVSCRIPT1 <- "export.jsp?table=1"
REVIGOR_URL_RSCRIPT2 <- "toR_treemap.jsp?table=1"
REVIGOR_URL_CSVSCRIPT2 <- "export_treemap.jsp?table=1"

REVIGOR_ORG_ID <- c(0,9606,10090,10116,9913,9031,7955,31033,7227,
                    6239,3702,39947,4577,559292,284812,44689,36329,
                    3055,83333,224308,208964,83332,243273,1111708,
                    190650,272634,1413510)

#' @rdname getRevigo
#' 
#' @title Get data from ReViGo
#' 
#' @description
#' \code{getRevigo} access the ReViGo services with the given gene ontology 
#' terms.
#'
#' @param goTerms a data.frame like object with two columns, "goTerms" and 
#' "p-value". If colnames are not given, the order is assumed.
#' @param revigoURL optional: the URL of the ReViGo service (default = 
#' \code{http://revigo.irb.hr})
#' @param verbose optional: whether to print more verbose information for the 
#' httr functions used to accessed the ReViGo service. 
#'
#' @return RevigoRData
#' @export
#'
#' @examples
#' \donttest{
#' getRevigo()
#' }
setMethod(
  f = "getRevigo", 
  signature = signature(x = "data.frame"),
  definition = .do_revigo)

#
.do_revigo <- function(goTerms,
                       cutoff = 0.7,
                       isPValue = TRUE,
                       whatIsBetter = "higher",
                       orgID = 0,
                       measure = "SIMREL",
                       revigoURL = "http://revigo.irb.hr",
                       verbose = FALSE){
  # input checks
  assertive::assert_is_a_number(cutoff)
  .checkValueValidity(cutoff, 
                      c(0.9,
                        0.7,
                        0.5,
                        0.4))
  assertive::assert_is_a_string(whatIsBetter)
  .checkValueValidity(whatIsBetter, 
                      c("higher",
                        "lower",
                        "absolute",
                        "abs_log"))
  assertive::assert_is_a_number(orgID)
  .checkValueValidity(orgID, 
                      REVIGOR_ORG_ID)
  assertive::assert_is_a_string(measure)
  .checkValueValidity(measure, 
                      c("RESNIK",
                        "LIN",
                        "SIMREL",
                        "JIANG"))
  #
  revigo_url <- function(path = "") {
    url <- modify_url(revigoURL, path = path)
    return(url)
  }
  # construct revigo input parameters
  revigo <- list(
    goList = paste(apply(goTerms, 
                         1,
                         function(x){
                           paste(trimws(x[1]),
                                 trimws(x[2]),
                                 sep = " ")
                         }),
                   collapse = "\n"),
    goSizes = orgID,
    cutoff = cutoff,
    isPValue = ifelse(isPValue,"yes","no"),
    measure = measure,
    whatIsBetter = whatIsBetter,
    startRevigo = "Please wait..."
  )
  # get initial result. Its is probably only about the session ID
  if(verbose){
    res <- httr::POST(revigo_url(REVIGOR_URL_FORM), 
                      body = revigo, 
                      encode = "form", 
                      httr::verbose())
  } else {
    res <- httr::POST(revigo_url(REVIGOR_URL_FORM), 
                      body = revigo, 
                      encode = "form")
  }
  # check result
  browser()
  # get the actual data as csv
  if(verbose){
    table <- httr::GET(revigo_url(REVIGOR_URL_CSVSCRIPT1), 
                     httr::verbose())
  } else {
    table <- httr::GET(revigo_url(REVIGOR_URL_CSVSCRIPT1))
  }
  if(verbose){
    treemap <- httr::GET(revigo_url(REVIGOR_URL_CSVSCRIPT2), 
                         httr::verbose())
  } else {
    treemap <- httr::GET(revigo_url(REVIGOR_URL_CSVSCRIPT2))
  }
  # extract csv text
  table <- utils::read.csv(text = readBin(content(table), "character"),
                           stringsAsFactors = FALSE)
  if(ncol(table) != 11){
    stop("Response has unknow number of columns.")
  }
  colnames(table) <- c("goTerm",
                         "description",
                         "frequency",
                         "plot_X",
                         "plot_Y",
                         "plot_size",
                         "log10pvalue",
                         "uniqueness",
                         "dispensability",
                         "representative",
                         "eliminated")
  treemap <- utils::read.csv(text = readBin(content(treemap), "character"),
                             skip = 4,
                             stringsAsFactors = FALSE)
  if(ncol(treemap) != 7){
    stop("Response has unknow number of columns.")
  }
  colnames(treemap) <- c("goTerm",
                         "description",
                         "frequency",
                         "log10pvalue",
                         "uniqueness",
                         "dispensability",
                         "representative")
  if(length(table) == 0 || 
     length(table) == 0){
    message("No Revigo results. Returning NULL...")
    return(NULL)
  }
  # create RevigRData object
  rd <- RevigoRData(table,
                    treemap)
  #
  return(rd)
}
