#' Create, delete, or edit a Pin
#'
#' @param file the path to the file
#' @param board name of the board (required)
#' @param note a description (required)
#' @param link an url (optional)
#' @inheritParams get_board_pins_by_id
#' 
#' @rdname pin_manip
#'
#'@return Either a data.frame, or an error.
#' @export
#'
#' @examples
#' \dontrun{
#' create_pin("~/Pictures/graph.png", "my_board", "a graph", token = token)
#' delete_pin("42080577756375754", token)
#' edit_pin("42080577744990466",note = "run run run", token = token)
#' }
create_pin <- function(file, board, note, link = NULL, token){
  url <- paste0("https://api.pinterest.com/v1/pins/?access_token=",token,"&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Cboard%2Ccolor%2Ccounts%2Ccreated_at%2Ccreator%2Cimage%2Cmedia%2Cmetadata%2Coriginal_link")
  res <- httr::POST(
    url = url, 
    body = list(
      board = board, 
      note = note, 
      link = link, 
      image_base64 = base64enc::base64encode(file)
    )
  )
  check_status(res)
  res <- json_raw_to_char(res$content)$data
  pin_spec_to_df(res)
}

#' @export
#' @rdname pin_manip

delete_pin <- function(id, token){
  check_internet()
  url <- paste0("https://api.pinterest.com/v1/pins/",id,"/?access_token=", token)
  res <- httr::DELETE(url)
  check_status(res)
  message("Pin deleted.")
}

#' @export
#' @rdname pin_manip

edit_pin <- function(id, board = NULL, note = NULL, link = NULL, token){
  check_internet()
  url <- paste0("https://api.pinterest.com/v1/pins/", id, "/?access_token=", token,"&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Cboard%2Ccolor%2Ccounts%2Ccreated_at%2Ccreator%2Cimage%2Cmedia%2Cmetadata%2Coriginal_link")
  res <- httr::PATCH(
    url = url, 
    body = list(
      pin = id, 
      board = board, 
      note = note, 
      link = link
    )
  )
  check_status(res)
  content <- json_raw_to_char(res$content)$data
  pin_spec_to_df(content)
}



