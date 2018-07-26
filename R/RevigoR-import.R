#' @include RevigoR.R
NULL

REVIGOR_URL_FORM <- "revigo.jsp"
REVIGOR_URL_RSCRIPT1 <- "toR.jsp?table=1"
REVIGOR_URL_CSVSCRIPT1 <- "export.jsp?table=1"
REVIGOR_URL_RSCRIPT2 <- "toR_treemap.jsp?table=1"
REVIGOR_URL_CSVSCRIPT2 <- "export_treemap.jsp?table=1"

#' @name getRevigo
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
getRevigo <- function(goTerms, 
                      revigoURL = "http://revigo.irb.hr",
                      verbose = FALSE){
  # input checks
  assertive::assert_is_a_string(type)
  .checkValueValidity(type,c("table","treemap"))
  #
  revigo_url <- function(path = "") {
    url <- modify_url(revigoURL, path = path)
    return(url)
  }
  # get initial result. Its is probably only about the session ID
  res <- ifelse(verbose,
                httr::POST(revigo_url(REVIGOR_URL_FORM), 
                           body = revigo, 
                           encode = "form", 
                           httr::verbose()),
                httr::POST(revigo_url(REVIGOR_URL_FORM), 
                           body = revigo, 
                           encode = "form"))
  # get the actual data as csv
  table <- ifelse(verbose,
                  httr::GET(revigo_url(REVIGOR_URL_CSVSCRIPT1), 
                            httr::verbose()),
                  httr::GET(revigo_url(REVIGOR_URL_CSVSCRIPT1)))
  treemap <- ifelse(verbose,
                    httr::GET(revigo_url(REVIGOR_URL_CSVSCRIPT2), 
                              httr::verbose()),
                    httr::GET(revigo_url(REVIGOR_URL_CSVSCRIPT2)))
  # extract csv text
  table <- utils::read.csv(text = readBin(content(table), "character"))
  treemap <- utils::read.csv(text = readBin(content(treemap), "character"))
  # csv checks
  
  #
  return(df)
}
