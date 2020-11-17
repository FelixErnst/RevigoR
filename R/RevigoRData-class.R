#' @include RevigoR.R
#' @include AllGenerics-export.R
NULL

#' @rdname RevigoRData-class
#' 
#' @param table a DataFrame containing the table data of a RevigoR analysis
#' @param treemap a DataFrame containing the treemap data of a RevigoR analysis
#' 
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
    #
    table[table$plot_X == "null","plot_X"] <- 
      rep(NA,nrow(table[table$plot_X == "null",]))
    table[table$plot_Y == "null","plot_Y"] <- 
      rep(NA,nrow(table[table$plot_X == "null",]))
    table$plot_X <- as.numeric(as.character(table$plot_X))
    table$plot_Y <- as.numeric(as.character(table$plot_Y))
    table$plot_size <- as.numeric(as.character(table$plot_size))
    table$log10pvalue <- as.numeric(as.character(table$log10pvalue))
    if(any(stringr::str_detect(table$frequency, "%"))){
      if(sum(stringr::str_detect(table$frequency, "%")) != nrow(table)){
        stop("Inconsistent frequency format.")
      }
      table$frequency <- as.numeric(gsub("%","",table$frequency))/100
    } else {
      table$frequency <- as.numeric(as.character(table$frequency))
    }
    table$uniqueness <- as.numeric(as.character(table$uniqueness))
    table$dispensability <- as.numeric(as.character(table$dispensability))
    #
    treemap$log10pvalue <- as.numeric(as.character(treemap$log10pvalue))
    if(any(stringr::str_detect(treemap$frequency, "%"))){
      if(sum(stringr::str_detect(treemap$frequency, "%")) != nrow(treemap)){
        stop("Inconsistent frequency format.")
      }
      treemap$frequency <- as.numeric(gsub("%","",treemap$frequency))/100
    } else {
      treemap$frequency <- as.numeric(as.character(treemap$frequency))
    }
    treemap$uniqueness <- as.numeric(as.character(treemap$uniqueness))
    treemap$dispensability <- as.numeric(as.character(treemap$dispensability))
    #
    .Object@listData[["table"]] <- table
    .Object@listData[["treemap"]] <- treemap
    return(.Object)
  }
)

# Validation -------------------------------------------------------------------

.valid.RevigoRData <- function(object){
  return(c(.is_valid_revigor(object),
           .is_valid_table(object),
           .is_valid_treemap(object)))
}

.is_valid_revigor <- function(object){
    names <- names(object@listData)
    if(length(names) != 2L || !all(c("table","treemap") %in% names)){
        return("Invalid entries in list data of RevigoR class")
    }
    NULL
}

.is_valid_table <- function(object){
    names <- colnames(getTableData(object))
    if(!all(c("goTerm","description","frequency","plot_X","plot_Y","plot_size",
              "log10pvalue","uniqueness","dispensability","representative",
              "eliminated") %in% names)){
        return("Invalid column names in table data of RevigoR class")
    }
    NULL
}
.is_valid_treemap <- function(object){
    names <- colnames(getTreemapData(object))
    if(!all(c("goTerm","description","frequency","log10pvalue","uniqueness",
              "dispensability","representative") %in% names)){
        return("Invalid column names in treemap data of RevigoR class")
    }
    NULL
}

setValidity("RevigoRData", .valid.RevigoRData)

# Coercion ---------------------------------------------------------------------

setAs("RevigoRData", "list", function(from) as.list(from))
setAs("List", "RevigoRData", function(from) as.revigor_data.List(from))

as.revigor_data.List <- function(from){
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

#' Accessing RevigoRData 
#' 
#' \code{getTableData} and \code{getTreemapData} returns data from a
#' \code{RevigoRData} object.
#'
#' @param x a \code{\link[=RevigoRData-class]{RevigoRData}} object
#'
#' @return a DataFrame
#' 
#' @name RevigoRData-accessors
#'
#' @examples
#' data(rd)
#' getTableData(rd)
#' getTreemapData(rd)
NULL

#' @rdname RevigoRData-accessors
#' @export
setMethod(
  f = "getTableData", 
  signature = signature(x = "RevigoRData"),
  definition = function(x) {
    return(x$table)
  }
)

#' @rdname RevigoRData-accessors
#' @export
setMethod(
  f = "getTreemapData", 
  signature = signature(x = "RevigoRData"),
  definition = function(x) {
    return(x$treemap)
  }
)
