#' Create, delete, or edit a Board
#'
#' @param name name of the new board for creation, new name to give for edit.
#' @param board a board name.
#' @param description description of the board?
#' @inheritParams get_board_pins_by_id
#'
#' @rdname board_manip
#'
#' @return Either a data.frame, or an error.
#' @export
#'
#' @examples
#' \dontrun{
#' create_board("testboard", "from rpinterest", token)
#' delete_board("colinfay/testboard", token)
#' edit_board("colinfay/testboard",description = "A new desc", token = token)
#' }
create_board <- function(name, description,  token){
  browser()
  check_internet()
  url <- paste0("https://api.pinterest.com/v1/boards/?access_token=", token,"&fields=id%2Cname%2Curl%2Ccounts%2Ccreated_at%2Ccreator%2Cimage%2Cdescription%2Cprivacy%2Creason")
  res <- httr::POST(
    url = url, 
    body = list(
      name = name, 
      description = description
    )
  )
  check_status(res)
  res <- json_raw_to_char(res$content)$data
  board_spec_to_df(res)
}

#' @rdname board_manip
#' @export

delete_board <- function(board, token){
  check_internet()
  url <- paste0("https://api.pinterest.com/v1/boards/",board,"/?access_token=", token)
  res <- httr::DELETE(url)
  check_status(res)
  message("Board deleted.")
}

#' @rdname board_manip
#' @export

edit_board <- function(board, name = NULL, description = NULL, token){
  check_internet()
  url <- paste0("https://api.pinterest.com/v1/boards/",board,"/?access_token=", token, "&fields=id%2Cname%2Curl%2Ccounts%2Ccreated_at%2Ccreator%2Cdescription%2Cimage%2Cprivacy%2Creason")
  res <- httr::PATCH(
    url = url, 
    body = list(
      board = board, 
      name = name, 
      description = description
    )
  )
  check_status(res)
  content <- json_raw_to_char(res$content)$data
  board_spec_to_df(content)
}




