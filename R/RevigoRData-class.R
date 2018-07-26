#' @include RevigoR.R
NULL


#' @rdname RevigoRData-class
#' @export
RevigoRData <- function(table,
                        treemap){
  class <- new("RevigoRData", 
               table,
               treemap)
  return(class)
}
#
setMethod(
  f = "initialize", 
  signature = signature(.Object = "RevigoRData"),
  definition = function(.Object,
                        table = DataFrame(),
                        treemap = DataFrame()) {
    .Object@listData[["table"]] <- table
    .Object@listData[["treemap"]] <- treemap
    return(.Object)
  }
)

# Validation -------------------------------------------------------------------

.valid.RevigoRData <- function(object){
  return(all(.is_valid_table(object),.is_valid_table(object)))
}

.is_valid_table <- function(object){
  return(TRUE)
}
.is_valid_treemap <- function(object){
  return(TRUE)
}

setValidity("RevigoRData", .valid.RevigoRData)

# Coercion ---------------------------------------------------------------------

setAs("RevigoRData", "list", function(from) as.list(from))
setAs("List", "RevigoRData", function(from) as.revigor_data.List(from))

as.revigor_data.List <- function(from){
  browser()
  elementNames <- c("table","treemap")
  if(length(from) == 0){
    class(from) <- "RevigoRData"
    return(from)
  }
  if(length(from) > 2){
    warning("List longer than two elements. Overflowing elements will be
            dropped.")
    from <- from[1:2]
  }
  if(length(from) == 2){
    if( is.null(names(from))){
      names(from) <- elementNames
    }
    if(!all(names(from) %in% elementNames)){
      warning("Names of list elements do not contain 'table' and 'treemap'.
              First element will be used as 'table', second as 'treemap'.")
      names(from) <- elementNames
    }
    ans <- from
  }
  if(length(from) == 1 &&
     any(names(from) %in% elementNames)){
    keep <- which(elementNames %in% names(from))
    ans <- from[1]
    names(ans) <-  elementNames[keep]
  } else if(length(from) == 1){
    ans <- from[1]
    if(.is_valid_table(from[1])){
      names(ans) <- elementNames[1]
    } else if(.is_valid_treemap(from[1])){
      names(ans) <- elementNames[2]
    }
  }
  table <- ifelse("table" %in% names(ans), ans[["table"]], DataFrame())
  treemap <- ifelse("treemap" %in% names(ans), ans[["treemap"]], DataFrame())
  ans <- new("RevigoRData",
              table,
              treemap)
  validObject(ans)
  ans
}

# Functions --------------------------------------------------------------------

#' @name RevigoRData-functions
#' 
#' @title Accessing RevigoRData 
#' 
#' @description 
#' \code{getTableData} and \code{getTreemapData} returns data froma
#' \code{RevigoRData} object.
#'
#' @param x RevigoRData. 
#'
#' @return DataFrame
#' @export
#'
#' @examples
#' getTableData(rd)
#' getTreemapData(rd)
setGeneric( 
  name = "getTableData",
  def = function(x) standardGeneric("getTableData")
) 
#' @rdname RevigoRData-functions
#' @export
setMethod(
  f = "getTableData", 
  signature = signature(x = "RevigoRData"),
  definition = function(x) {
    return(x$table)
  }
)

#' @rdname RevigoRData-functions
#' @export
setGeneric( 
  name = "getTreemapData",
  def = function(x) standardGeneric("getTreemapData")
) 
#' @rdname RevigoRData-functions
#' @export
setMethod(
  f = "getTreemapData", 
  signature = signature(x = "RevigoRData"),
  definition = function(x) {
    return(x$treemap)
  }
)


