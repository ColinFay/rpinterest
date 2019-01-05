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
#'get_pin_spec_by_id(id = "42080577745042298", token = "your_token")

get_pin_spec_by_id <- function(id, token) {
  
  url <- paste0("https://api.pinterest.com/v1/pins/", id, "/?access_token=", token, "&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Cboard%2Ccounts%2Ccolor%2Ccreated_at%2Ccreator%2Cmedia%2Cimage%2Cmetadata%2Coriginal_link")
  check_internet()
  res <- httr::GET(url)
  check_status(res)
  content <- json_raw_to_char(pin$content)
  
  content <- content$data
  contentlist <- list()
  contentlist[[1]] <- content
  identity <- lapply(contentlist, function(obj) {
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
