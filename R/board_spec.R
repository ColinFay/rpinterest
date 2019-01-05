#'Get board spec using its ID
#'
#'Get information about a pinterest board using the board ID.
#'
#'Takes a board ID and an access token, returns a data.frame.
#'@param id a character string with a board ID.
#'@inheritParams get_board_pins_by_id
#'
#'@return Always returns a data.frame, with a warning when appropriate.
#'@export
#'@importFrom magrittr %>%
#'@importFrom httr GET
#'@importFrom jsonlite fromJSON
#'@examples
#'get_board_spec_by_id(id = "42080646457333782", token = token)

get_board_spec_by_id <- function(id, token){
  url <- paste0("https://api.pinterest.com/v1/boards/", id, "/?access_token=", token, "&fields=id%2Cname%2Curl%2Ccounts%2Ccreated_at%2Ccreator%2Cdescription%2Cimage%2Cprivacy%2Creason")
  get_board_spec(url)
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
#'get_board_spec_by_name(user = "colinfay", board = "blanc-mon-amour", token = token)

get_board_spec_by_name <- function(user, board, token){
  url <- paste0("https://api.pinterest.com/v1/boards/", user, "/", board, "/?access_token=", token, "&fields=id%2Cname%2Curl%2Ccounts%2Ccreated_at%2Ccreator%2Cdescription%2Cimage%2Cprivacy%2Creason")
  get_board_spec(url)
}


get_board_spec <- function(url){
  check_internet()
  #browser()
  res <- httr::GET(url)
  check_status(res)
  content <- json_raw_to_char(res$content)$data
  
  data.frame(name = content$name %||% NA,
             board_id = content$id %||% NA,
             board_desc = content$description %||% NA,
             creator_first_name = content$creator$first_name %||% NA,
             creator_last_name = content$creator$last_name %||% NA,
             creator_url = content$creator$url %||% NA,
             creator_id = content$creator$id %||% NA,
             created_at = content$created_at %||% NA,
             pins_count = content$counts$pins %||% NA,
             pins_collaborators = content$counts$collaborators %||% NA,
             pins_followers = content$counts$followers %||% NA,
             stringsAsFactors = FALSE)
}
