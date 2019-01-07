#' Send a ggplot plot to a Pinterest board
#'
#' @param plot a ggplot object
#' @param board the name of the board
#' @param note description of the image
#' @param link a link to put under the image
#' @param ... arguments to be passed to `ggsave()`
#' @inheritParams get_board_pins_by_id
#' 
#' @return Either a data.frame, or an error.
#' @export
#' 
#' @importFrom attempt stop_if_not
#'
#' @examples
#'\dontrun{
#' library(ggplot2)
#' x <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) + geom_point()
#' ggplot_to_pinterest(x, "colinfay/gris-mon-amour", "test rpinterest", token = token)
#'}
#'
ggplot_to_pinterest <- function(plot, board, 
                                note, 
                                link = NULL, 
                                token, ...){
  if (!requireNamespace("ggplot2")){
    stop("`ggplot_to_pinterest()` requires ggplot2`")
  }
  stop_if_not(plot, ~ class(.x) == "ggplot", "Please pass a ggplot object.")
  tmpfile <- tempfile(fileext = ".png")   
  ggplot2::ggsave(tmpfile, plot = plot, ...)
  create_pin(tmpfile, board, note, token = token)
}


