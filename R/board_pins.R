#'Get board pins using board ID
#'
#'Get information about all the pins on a pinterest board using the board ID.
#'
#'Takes a board ID and an access token, returns a data.frame.
#'@param id a character string with a board ID.
#'@param token a character string with an access token generated with `pinterest_token()`
#'
#'@return Always returns a data.frame, with a warning when appropriate.
#'@export
#'@importFrom httr GET
#'@importFrom jsonlite fromJSON
#'@examples
#'get_board_pins_by_id(id = "42080646457333782", token = token)

get_board_pins_by_id <- function(id, token){
  url <- paste0("https://api.pinterest.com/v1/boards/", id, "/pins/?access_token=", token, "&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Ccolor%2Cboard%2Ccounts%2Ccreated_at%2Ccreator%2Cimage%2Cmedia%2Cmetadata%2Coriginal_link")
  get_board_pins(url)
}

#'Get board pins using board name
#'
#'Get information about all the pins on a pinterest board using the board name.
#'
#'Takes a user name, a board name and an access token, returns a data.frame.
#'@param user a character string with a user name.
#'@param board a character string with a board name.
#'@inheritParams get_board_pins_by_id
#'
#'@return Always returns a data.frame, with a warning when appropriate.
#'@export
#'@examples
#'get_board_pins_by_name(user = "colinfay", board = "violet-mon-amour", token = token)

get_board_pins_by_name <- function(user, board, token){
  url <- paste0("https://api.pinterest.com/v1/boards/", user, "/", board, "/pins/?access_token=", token, "&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Ccolor%2Cboard%2Ccounts%2Ccreated_at%2Ccreator%2Cimage%2Cmedia%2Cmetadata%2Coriginal_link")
  get_board_pins(url)
}


#' @importFrom data.table rbindlist
#' @importFrom httr GET
get_board_pins <- function(url){
  check_internet()
  #browser()
  res <- GET(url)
  check_status(res)
  content <- json_raw_to_char(res$content)
  contentdata <- content$data
  
  if(!is.null(content$page$`next`)){
    repeat{
      url <- content$page$`next`
      res <- GET(url)
      check_status(res)
      content <- json_raw_to_char(res$content)
      contentdata <- rbindlist(
        list(contentdata, content$data), 
        fill = TRUE)
      if(is.null(content$page$`next`)){
        break
      }
    }
  }
  contentdata
}
