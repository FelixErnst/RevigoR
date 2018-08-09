## ----setup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----revigor_simple--------------------------------------------------------
data("rdinput", package = "RevigoR")
rdinput

rd <- getRevigo(rdinput)
rd

## ----revigor_data----------------------------------------------------------
rd
all(getTableData(rd) == rd[["table"]], na.rm = TRUE)

## ----revigor_david---------------------------------------------------------
data("chart", package = "RevigoR")
chart
# also 
rd <- getRevigo(chart,
                goCategory = "GOTERM_BP_DIRECT")
rd

## ----revigor_scatter, eval=FALSE-------------------------------------------
#  plotRevigoScatter(rd)

## ----plot1, fig.cap="Revigo scatter plot", echo=FALSE----------------------
plotRevigoScatter(rd)

## ----revigor_treemap, eval=FALSE-------------------------------------------
#  plotRevigoTreemap(rd)

## ----plot2, fig.cap="Revigo treemap plot", echo=FALSE----------------------
plotRevigoTreemap(rd)

## ----build_info------------------------------------------------------------
sessionInfo()

