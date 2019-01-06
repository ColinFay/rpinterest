#' Retrieve information about a Board
#'
#'Get information about a pinterest board using the board ID or the name/user combination.
#'
#'@param id a character string with a board ID.
#'@param user a character string with a user name.
#'@param board a character string with a board name.
#'@inheritParams get_board_pins_by_id
#'
#' @return Either a data.frame, or an error.
#' 
#' @export
#' @rdname board_spec
#' 
#' @importFrom httr GET
#' @examples
#'\dontrun{
#' get_board_spec_by_id(id = "42080646457333782", token = token)
#' get_board_spec_by_name(user = "colinfay", board = "blanc-mon-amour", token = token)
#'}

get_board_spec_by_id <- function(id, token){
  url <- paste0("https://api.pinterest.com/v1/boards/", id, "/?access_token=", token, "&fields=id%2Cname%2Curl%2Ccounts%2Ccreated_at%2Ccreator%2Cdescription%2Cimage%2Cprivacy%2Creason")
  get_board_spec(url)
}

#' @export
#' @rdname board_spec

get_board_spec_by_name <- function(user, board, token){
  get_board_spec_by_id(paste(user, board, sep = "/"), token)
}


#' @importFrom httr GET
get_board_spec <- function(url){
  check_internet()
  browser()
  res <- GET(url)
  check_status(res)
  content <- json_raw_to_char(res$content)$data
  board_spec_to_df(content)
}
