#'Get pin using its ID
#'
#'Get information about a pinterest pin using the pin ID.
#'
#'Takes a pin ID and an access token, returns a data.frame.
#'@param pinID a character string with a pin ID.
#'@inheritParams get_board_pins_by_id
#'@return Always returns a data.frame, with a warning when appropriate.
#'@export
#'@examples
#'get_pin_spec_by_id(id = "42080577745042298", token = token)

#' @importFrom httr GET
get_pin_spec_by_id <- function(id, token) {
  url <- paste0("https://api.pinterest.com/v1/pins/", id, "/?access_token=", token, "&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Cboard%2Ccounts%2Ccolor%2Ccreated_at%2Ccreator%2Cmedia%2Cimage%2Cmetadata%2Coriginal_link")
  check_internet()
  res <- GET(url)
  check_status(res)
  content <- json_raw_to_char(res$content)$data
  
  data.frame(pin_id = content$id %||% NA, 
             creator_first_name = content$creator$first_name %||% NA, 
             creator_last_name = content$creator$last_name %||% NA, 
             creator_id = content$creator$id %||% NA, 
             type = content$media$type %||% NA, 
             original_link = content$original_link %||% NA, 
             pin_note = content$note %||% NA, 
             pin_color = content$color %||% NA, 
             pin_link = content$link %||% NA, 
             pin_board_name = content$board$name %||% NA, 
             pin_board_url = content$board$url %||% NA, 
             pin_board_id = content$board$id %||% NA, 
             pins_likes = content$counts$likes %||% NA, 
             pins_comments = content$counts$comments %||% NA, 
             pins_repins = content$counts$repins %||% NA, 
             attribution_title = content$attribution$title %||% NA, 
             attribution_author = content$attribution$author_name %||% NA, 
             attribution_url = content$attribution$author_url %||% NA, 
             attribution_provider = content$attribution$provider_name %||% NA, 
             stringsAsFactors = FALSE)
  
}
