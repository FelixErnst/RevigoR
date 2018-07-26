#' @include RevigoR.R
NULL

#' @name RevigoRData-class
#' 
#' @title RevigoRData
#' 
#' @description 
#' These classes are inheriting from List. It contains exactly two DataFrames, 
#' table and treemap
#' 
#' but require the presence of
#' the following columns to be valid.
#' 
#' @export
#'
#' @examples
#' df <- DataFrame(a = 1, b = 2)
setClass("RevigoRData",
         contains = "SimpleList")