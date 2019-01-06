ggplot_to_pinterest <- function(plot, board, 
                                note, 
                                link = NULL, 
                                token, ...){
  if (!requireNamespace("ggplot2")){
    stop("`ggplot_to_pinterest()` requires ggplot2`")
  }
  tmpfile <- tempfile(fileext = ".png")   
  ggplot2::ggsave(tmpfile, plot = plot, ...)
  create_pin(tmpfile, board, note, token = token)
}

# x <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) + geom_point()
# ggplot_to_pinterest(x, "colinfay/gris-mon-amour", "test rpinterest", token = token)
