#' @include RevigoR.R
#' @include AllGenerics-export.R
NULL

#' @rdname RevigoRData
#' 
#' @param table a DataFrame containting the table data of a RevigoR analysis
#' @param treemap a DataFrame containting the treemap data of a RevigoR analysis
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
  return(all(.is_valid_table(object),.is_valid_table(object)))
}

.is_valid_table <- function(object){
  
  # table <- table[(table$plot_X != "null" & 
  #                   table$plot_Y != "null"),]
  # table$plot_X <- as.numeric(as.character(table$plot_X))
  # table$plot_Y <- as.numeric(as.character(table$plot_Y))
  # table$plot_size <- as.numeric(as.character(table$plot_size))
  # table$log10.p.value <- as.numeric(as.character(table$log10.p.value))
  # table$frequency <- as.numeric(as.character(table$frequency))
  # table$uniqueness <- as.numeric(as.character(table$uniqueness))
  # table$dispensability <- as.numeric(as.character(table$dispensability))
  
  return(TRUE)
}
.is_valid_treemap <- function(object){
  # treemap$abslog10pvalue <- as.numeric(as.character(treemap$abslog10pvalue))
  # treemap$freqInDbPercent <- as.numeric(as.character(treemap$freqInDbPercent))
  # treemap$uniqueness <- as.numeric(as.character(treemap$uniqueness))
  # treemap$dispensability <- as.numeric(as.character(treemap$dispensability))
  
  return(TRUE)
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

#' @name RevigoRData
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
NULL

#' @rdname RevigoRData
#' @export
setMethod(
  f = "getTableData", 
  signature = signature(x = "RevigoRData"),
  definition = function(x) {
    return(x$table)
  }
)

#' @rdname RevigoRData
#' @export
setMethod(
  f = "getTreemapData", 
  signature = signature(x = "RevigoRData"),
  definition = function(x) {
    return(x$treemap)
  }
)


