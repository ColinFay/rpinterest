#' Get Information about the logged user
#' 
#' Get user information about their account or about
#' their boards.
#'
#'@inheritParams get_board_pins_by_id
#'
#' @rdname get_logged_user
#'
#' @return a data.frame
#' @export
#'
#' @examples
#' \dontrun{
#' get_logged_user(token)
#' get_logged_user_boards(token)
#' }
get_logged_user <- function(token){
  check_internet()
  res <- httr::GET(
    paste0("https://api.pinterest.com/v1/me/?access_token=", 
           token,"&fields=first_name%2Cid%2Clast_name%2Curl")
  )
  check_status(res)
  as.data.frame(json_raw_to_char(res$content)$data)
}

#' @rdname get_logged_user
#' @export
get_logged_user_boards <- function(token){
  check_internet()
  res <- httr::GET(
    paste0("https://api.pinterest.com/v1/me/boards/?access_token=", 
           token,"&fields=id%2Cname%2Curl%2Ccounts%2Ccreated_at%2Ccreator%2Cdescription%2Cimage%2Cprivacy%2Creason")
  )
  check_status(res)
  as.data.frame(json_raw_to_char(res$content)$data)
}