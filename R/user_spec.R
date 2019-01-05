#'Get a user using its ID
#'
#'Get information about a pinterest user using the user ID.
#'
#'Takes a user ID and an access token, returns a data.frame.
#'@param id a character string with an user ID.
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
#'@param board a character string with a board name.
#'@inheritParams get_board_pins_by_id
#'
#'@return Always returns a data.frame, with a warning when appropriate.
#'@export
#'@examples
#'get_user_spec_by_name(user = "colinfay", token = token)

get_user_spec_by_name <- function(name, token){
  url <- paste0("https://api.pinterest.com/v1/users/", user, "/?access_token=", token, "&fields=first_name%2Cid%2Clast_name%2Curl%2Caccount_type%2Cusername%2Cbio%2Ccounts%2Ccreated_at%2Cimage")
  get_user_spec(url)
}


get_user_spec <- function(url){
  check_internet()
  res <- httr::GET(url)
  check_status(res)
  content <- json_raw_to_char(board$content)
  content <- content$data
  contentlist <- list()
  contentlist[[1]] <- content
  identity <- lapply(contentlist, function(obj) {
    data.frame(id = obj$id %||% NA, 
               names = obj$username %||% NA,
               bio = obj$bio %||% NA, 
               first_name = obj$first_name %||% NA, 
               last_name = obj$last_name %||% NA, 
               account_type = obj$account_type %||% NA,
               url = obj$url %||% NA,
               created_at = obj$created_at %||% NA,
               pins = obj$counts$pins %||% NA,
               following = obj$counts$following %||% NA,
               followers = obj$counts$followers %||% NA,
               boards = obj$counts$boards %||% NA,
               likes = obj$counts$likes %||% NA, 
               stringsAsFactors = FALSE)
  }) 
  do.call(rbind, identity)

}
