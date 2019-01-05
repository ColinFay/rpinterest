#'Get a user using its ID
#'
#'Get information about a pinterest user using the user ID.
#'
#'Takes a user ID and an access token, returns a data.frame.
#'@param id a character string with a user ID.
#'@inheritParams get_board_pins_by_id
#'
#'@return Always returns a data.frame, with a warning when appropriate.
#'@export
#'@importFrom magrittr %>%
#'@importFrom httr GET
#'@importFrom jsonlite fromJSON
#'@examples
#'get_user_spec_by_id(id = "42080715176677612", token = token)

get_user_spec_by_id <- function(id, token){
  url <- paste0("https://api.pinterest.com/v1/users/", id, "/?access_token=", token, "&fields=first_name%2Cid%2Clast_name%2Curl%2Caccount_type%2Cusername%2Cbio%2Ccounts%2Ccreated_at%2Cimage")
  get_user_spec(url)
}

#'Get board pins using board name
#'
#'Get information about all the pins on a pinterest board using the board name.
#'
#'Takes a user name, a board name and an access token, returns a data.frame.
#'@param user a character string with a user name.
#'@inheritParams get_board_pins_by_id
#'
#'@return Always returns a data.frame, with a warning when appropriate.
#'@export
#'@examples
#'get_user_spec_by_name(user = "colinfay", token = token)

get_user_spec_by_name <- function(user, token){
  url <- paste0("https://api.pinterest.com/v1/users/", user, "/?access_token=", token, "&fields=first_name%2Cid%2Clast_name%2Curl%2Caccount_type%2Cusername%2Cbio%2Ccounts%2Ccreated_at%2Cimage")
  get_user_spec(url)
}


get_user_spec <- function(url){
  browser()
  check_internet()
  res <- httr::GET(url)
  check_status(res)
  content <- json_raw_to_char(res$content)$data
  
  data.frame(id = content$id %||% NA, 
             names = content$username %||% NA,
             bio = content$bio %||% NA, 
             first_name = content$first_name %||% NA, 
             last_name = content$last_name %||% NA, 
             account_type = content$account_type %||% NA,
             url = content$url %||% NA,
             created_at = content$created_at %||% NA,
             pins = content$counts$pins %||% NA,
             following = content$counts$following %||% NA,
             followers = content$counts$followers %||% NA,
             boards = content$counts$boards %||% NA,
             likes = content$counts$likes %||% NA, 
             stringsAsFactors = FALSE)
  
}
