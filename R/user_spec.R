#' Return a user's information
#'
#' Get information about a Pinterest user using the ID or name.
#'
#'@param id a character string with a user ID.
#'@param user a character string with a user name.
#'@inheritParams get_board_pins_by_id
#'
#'@rdname get_user
#'
#'@return Either a data.frame, or an error.
#'
#'@export
#'
#'@examples
#'\dontrun{
#'get_user_spec_by_id(id = "42080715176677612", token = token)
#'get_user_spec_by_name(user = "colinfay", token = token)
#'}

get_user_spec_by_id <- function(id, token){
  get_user_spec_by_name(id, token)
}

#'@rdname get_user
#'@export

get_user_spec_by_name <- function(user, token){
  url <- paste0("https://api.pinterest.com/v1/users/", user, "/?access_token=", token, "&fields=first_name%2Cid%2Clast_name%2Curl%2Caccount_type%2Cusername%2Cbio%2Ccounts%2Ccreated_at%2Cimage")
  get_user_spec(url)
}


#' @importFrom httr GET
get_user_spec <- function(url){
  check_internet()
  res <- GET(url)
  check_status(res)
  content <- json_raw_to_char(res$content)$data

  df_tbl(names = content$username %||% NA,
             bio = content$bio %||% NA, 
             first_name = content$first_name %||% NA, 
             last_name = content$last_name %||% NA, 
             account_type = content$account_type %||% NA,
             url = content$url %||% NA,
             created_at = content$created_at %||% NA,
             image_60x60_url = content$image$`60x60`$url %||% NA,
             image_60x60_width = content$image$`60x60`$width %||% NA,
             image_60x60_height = content$image$`60x60`$height %||% NA,
             counts_pins = content$counts$pins %||% NA,
             counts_following = content$counts$following %||% NA,
             counts_followers = content$counts$followers %||% NA,
             counts_boards = content$counts$boards %||% NA,
             id = content$id %||% NA, 
             stringsAsFactors = FALSE)
  
}
