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
#'@importFrom magrittr %>%
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
#'get_board_pins_by_name(user = "colinfay", board = "blanc-mon-amour", token = token)

get_board_pins_by_name <- function(user, board, token){
  url <- paste0("https://api.pinterest.com/v1/boards/", user, "/", board, "/pins/?access_token=", token, "&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Ccolor%2Cboard%2Ccounts%2Ccreated_at%2Ccreator%2Cimage%2Cmedia%2Cmetadata%2Coriginal_link")
  get_board_pins(url)
}


get_board_pins <- function(url){
  check_internet()
  browser()
  res <- httr::GET(url)
  check_status(res)
  content <- json_raw_to_char(res$content)
  contentdata <- content$data
  if(!is.null(content$page$`next`)){
    repeat{
      url <- content$page$`next`
      name <- httr::GET(url)
      content <-json_raw_to_char(name$content)
      contentdata <- c(contentdata, content$data)
      if(is.null(content$page$`next`)){
        break
      }
    }
  }
  identity <- lapply(contentdata, function(obj){
    data.frame(pin_id = obj$id %||% NA, 
               creator_first_name = obj$creator$first_name %||% NA, 
               creator_last_name = obj$creator$last_name %||% NA, 
               creator_id = obj$creator$id %||% NA, 
               type = obj$media$type %||% NA, 
               original_link = obj$original_link %||% NA, 
               pin_note = obj$note %||% NA, 
               pin_color = obj$color %||% NA, 
               pin_link = obj$link %||% NA, 
               pin_board_name = obj$board$name %||% NA, 
               pin_board_url = obj$board$url %||% NA, 
               pin_board_id = obj$board$id %||% NA, 
               pins_likes = obj$counts$likes %||% NA, 
               pins_comments = obj$counts$comments %||% NA, 
               pins_repins = obj$counts$repins %||% NA, 
               attribution_title = obj$attribution$title %||% NA, 
               attribution_author = obj$attribution$author_name %||% NA, 
               attribution_url = obj$attribution$author_url %||% NA, 
               attribution_provider = obj$attribution$provider_name %||% NA, 
               stringsAsFactors = FALSE)
  }) 
  do.call(rbind, identity) 
}
