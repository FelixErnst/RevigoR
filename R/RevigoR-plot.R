#' @include RevigoR.R
#' @include AllGenerics-export.R
NULL

#' @name plotRevigo
#' 
#' @title Plotting ReViGo data
#' 
#' @description 
#' plotting stuff
#'
#' @param x a RevigoRData object
#' @param xType one of the following values: 
#' \code{"alphabetical","pvalue","uniqueness","X","Y"}
#' @param yType one of the following values: 
#' \code{"pvalue","uniqueness","X","Y"}
#' @param pointSizeType one of the following values: 
#' \code{"same","point_size","pvalue","uniqueness","X","Y"}
#' @param colourType one of the following values: 
#' \code{"same","unique","pvalue","uniqueness","X","Y"}
#' @param colour a colour, which ggplot understands
#' @param size a positive numeric value
#' @param showAllLabels optional logical value: should all labels be shown? 
#' (default: \code{showAllLabels = FALSE})
#'
#' @return a ggplot2 plot
#' 
#' @importFrom colorRamps matlab.like2
#' @importFrom ggthemes solarized_pal
#'
#' @examples
#' data("rdinput", package = "RevigoR")
#' rd <- getRevigo(rdinput)
#' plotRevigoScatter(rd)
#' plotRevigoTreemap(rd)
NULL

#' @rdname plotRevigo
#' @export
setMethod(
  f = "plotRevigoScatter", 
  signature = signature(x = "RevigoRData"),
  definition = function(x,
                        xType,
                        yType,
                        pointSizeType,
                        colourType,
                        colour,
                        size,
                        showAllLabels){
    requireNamespace("ggplot2", quietly = TRUE)
    # input check
    checkX <- c("alphabetical","pvalue","uniqueness","X","Y")
    checkY <- c("pvalue","uniqueness","X","Y")
    checkPoint <- c("same","point_size","pvalue","uniqueness","X","Y")
    checkColour <- c("same","unique","pvalue","uniqueness","X","Y")
    labelNames <- c("description" = "Alphabetical",
                    "plot_size" = "Point size",
                    "log10pvalue" = "-log10(p)",
                    "uniqueness" = "uniqueness",
                    "plot_X" = "Semantic space X",
                    "plot_Y" = "Semantic space Y")
    .checkValueValidity(xType,
                        checkX)
    xType <- .convert_types_to_colnames(xType)
    .checkValueValidity(yType,
                        checkY)
    yType <- .convert_types_to_colnames(yType)
    .checkValueValidity(pointSizeType,
                        checkPoint)
    pointSizeType <- .convert_types_to_colnames(pointSizeType)
    .checkValueValidity(colourType,
                        checkColour)
    colourType <- .convert_types_to_colnames(colourType)
    assertive::assert_is_a_string(colour)
    assertive::assert_is_a_number(size)
    assertive::assert_all_are_positive(size)
    assertive::assert_is_a_bool(showAllLabels)
    # get data and subset
    data <- getTableData(x)
    data <- data[!is.na(data$plot_X) | !is.na(data$plot_Y),]
    data$log10pvalue <- abs(data$log10pvalue)
    if(showAllLabels){
      ex <- data
    } else{
      ex <- data[data$dispensability < 0.15,]
    }
    # plot data
    plot <- ggplot(data = data)
    # point and colour options
    if(pointSizeType == "same" &&
       colourType == "same"){
      plot <- plot + 
        geom_point(mapping = aes_string(x = xType,
                                        y = yType),
                   colour = colour,
                   size = size,
                   alpha = I(0.6))
    } else if(pointSizeType == "same"){
      plot <- plot + 
        geom_point(mapping = aes_string(x = xType,
                                        y = yType,
                                        colour = colourType),
                   size = size,
                   alpha = I(0.6))
    } else if(colourType == "same"){
      plot <- plot + 
        geom_point(mapping = aes_string(x = xType,
                                        y = yType,
                                        size = pointSizeType),
                   colour = colour,
                   alpha = I(0.6))
    } else if(colourType == "unique"){
      plot <- plot + 
        geom_point(mapping = aes_string(x = xType,
                                        y = yType,
                                        size = pointSizeType,
                                        colour = "description"),
                   alpha = I(0.6))
    } else {
      plot <- plot + 
        geom_point(mapping = aes_string(x = xType,
                                        y = yType,
                                        colour = colourType,
                                        size = pointSizeType), 
                   alpha = I(0.6))
    }
    #
    if(pointSizeType == "same"){
      plot <- plot + 
        geom_point(mapping = aes_string(x = xType,
                                        y = yType),
                   size = size,
                   shape = 21, 
                   fill = "transparent", 
                   colour = I(alpha("black", 0.6)))
    } else {
      plot <- plot + 
        geom_point(mapping = aes_string(x = xType,
                                        y = yType,
                                        size = pointSizeType), 
                   shape = 21, 
                   fill = "transparent", 
                   colour = I(alpha("black", 0.6)))
    }
    #
    if(xType %in% c("log10pvalue","uniqueness","plot_X","plot_Y")){
      x_range = max(data[,xType]) - min(data[,xType])
      plot <- plot +
        xlim(min(data[,xType]) - x_range/10,
             max(data[,xType]) + x_range/10)
    }
    if(yType %in% c("log10pvalue","uniqueness","plot_X","plot_Y")){
      y_range = max(data[,yType]) - min(data[,yType])
      plot <- plot +
        ylim(min(data[,yType]) - y_range/10,
             max(data[,yType]) + y_range/10)
    }
    # remaining plot stuff
    plot <- plot +
      theme_bw() + 
      theme(legend.key = element_blank()) +
      labs(x = labelNames[xType],
           y = labelNames[yType]) +
      geom_text(data = ex, 
                aes_string(x = xType, 
                           y = yType, 
                           label = "description"),
                colour = I(alpha("black", 0.85)),
                size = 3)
    #
    if(colourType == "unique"){
      plot <- plot + 
        scale_colour_manual(name = "GO Terms",
                            values = grDevices::colorRampPalette(ggthemes::solarized_pal()(8))(nrow(data)))
    } else {
      plot <- plot + 
        scale_colour_gradientn(name = labelNames[colourType],
                               colours = colorRamps::matlab.like2(100),
                               limits = c(0,max(data$log10pvalue)) )
    }
    #
    if(pointSizeType == "same"){
      plot <- plot + 
        scale_size(name = "one size",
                   range = c(10,10),
                   guide = FALSE)
    } else {
      plot <- plot + 
        scale_size(name = labelNames[pointSizeType],
                   range = c(5, 30))
    }
    return(plot)
  }
)

#
.convert_types_to_colnames <- function(type){
  if(type %in% c("X","Y")){
    type <- paste0("plot_",type)
  }
  if(type == "pvalue"){
    type <- "log10pvalue"
  }
  if(type == "alphabetical"){
    type <- "description"
  }
  if(type == "point_size"){
    type <- "plot_size"
  }
  return(type)
}

#' @rdname plotRevigo
#' 
#' @param type one of \code{"frequency"}, \code{"pvalue"}, \code{"uniqueness"} 
#' or \code{"dispensability"}
#' @param palette name of a colour palette, which 
#' \code{ggplot2::scale_fill_brewer} accepts
#' 
#' @import treemapify
#' @export
setMethod(
  f = "plotRevigoTreemap", 
  signature = signature(x = "RevigoRData"),
  definition = function(x,
                        type,
                        palette){
    requireNamespace("ggplot2", quietly = TRUE)
    requireNamespace("treemapify", quietly = TRUE)
    cols <- c("frequency" = "frequency",
              "pvalue" = "log10pvalue",
              "uniqueness" = "uniqueness",
              "dispensability" = "dispensability")
    # input check
    assertive::assert_is_a_non_missing_nor_empty_string(type)
    .checkValueValidity(type,
                        names(cols))
    # get data and make values positive
    data <- getTreemapData(x)
    data$log10pvalue <- abs(data$log10pvalue)
    # plot data
    plot <- ggplot(data,
                   mapping = aes_string(area = cols[type], 
                                        fill = "representative", 
                                        label = "description",
                                        subgroup = "representative")) +
      geom_treemap() +
      geom_treemap_subgroup_border() +
      geom_treemap_subgroup_text(place = "centre",
                                 grow = TRUE,
                                 colour = "black",
                                 fontface = "bold",
                                 min.size = 0) +
      geom_treemap_text(colour = "black",
                        place = "topleft",
                        fontface = "italic",
                        reflow = TRUE) +
      scale_fill_brewer(palette = palette) +
      labs(title = "REVIGO Gene Ontology treemap") +
      guides(fill = FALSE)
    return(plot)
  }
)
