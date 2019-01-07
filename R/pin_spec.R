#' Return information about a Pin
#'
#' Get information about a pinterest pin using the pin ID.
#' 
#'@param id a character string with a pin ID.
#'@inheritParams get_board_pins_by_id
#'
#'@return Either a data.frame, or an error.
#'
#'@export
#' @importFrom httr GET
#' 
#'@examples
#'\dontrun{
#'get_pin_spec_by_id(id = "42080577745042298", token = token)
#'}

#' 
get_pin_spec_by_id <- function(id, token) {
  url <- paste0("https://api.pinterest.com/v1/pins/", id, "/?access_token=", token, "&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Cboard%2Ccounts%2Ccolor%2Ccreated_at%2Ccreator%2Cmedia%2Cimage%2Cmetadata%2Coriginal_link")
  check_internet()
  res <- GET(url)
  check_status(res)
  content <- json_raw_to_char(res$content)$data
  
  pin_spec_to_df(content)
  
}
