#'Get board pins using board ID
#'
#'Get informations about all the pins on a pinterest board using the board ID.
#'
#'Takes a board ID and an access token, returns a data.frame.
#'@param boardID a character string with a board ID.
#'@param token a character string with an access token generated at \url{https://developers.pinterest.com/tools/access_token/}
#'@return Returns a data.frame with informations about all the pins on the board.
#'@export
#'@examples
#'BoardPinsByID(boardID = "42080646457333782", token = token)

BoardPinsByID <- function(boardID, token) {
  url <- paste0("https://api.pinterest.com/v1/boards/", boardID, "/pins/?access_token=", token, "&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Ccolor%2Cboard%2Ccounts%2Ccreated_at%2Ccreator%2Cimage%2Cmedia%2Cmetadata%2Coriginal_link")
  name <- httr::GET(url)
  if (name$status_code == 200){
    content <- rjson::fromJSON(rawToChar(name$content))
    contentdata <- content$data
    repeat{
      url <- content$page$`next`
      name <- httr::GET(url)
      content <- rjson::fromJSON(rawToChar(name$content))
      contentdata <- c(contentdata, content$data)
      if(is.null(content$page$`next`)){
        break
      }
    }
    identity = data.frame()
    for(i in 1:length(contentdata)){
      pin_now <- contentdata[[i]]
      if(is.null(pin_now$attribution)) {
        attrtit <- NA
        attraut <- NA
        attrurl <- NA
        attrprov <- NA
      } else {
        attrtit <- pin_now$attribution$title
        attraut <- pin_now$attribution$author_name
        attrurl <- pin_now$attribution$author_url
        attrprov <- pin_now$attribution$provider_name
      }
      if(is.null(pin_now$id)) {
        pin_i <- NA
      } else {
        pin_i <- pin_now$id
      }
      if(is.null(pin_now$creator$first_name)) {
        creator_nam <- NA
      } else {
        creator_nam <- paste0(pin_now$creator$first_name, " ", pin_now$creator$last_name)
      }
      if(is.null(pin_now$creator$id)) {
        creator_i <- NA
      } else {
        creator_i <- pin_now$creator$id
      }
      if(is.null(pin_now$media$type)) {
        typ <- NA
      } else {
        typ <- pin_now$media$type
      }
      if(is.null(pin_now$original_link)) {
        original_lin <- NA
      } else {
        original_lin <- pin_now$original_link
      }
      if(is.null(pin_now$note)) {
        pin_not <- NA
      } else {
        pin_not <- pin_now$note
      }
      if(is.null(pin_now$color)) {
        pin_colo <- NA
      } else {
        pin_colo <- pin_now$color
      }
      if(is.null(pin_now$link)) {
        pin_lin <- NA
      } else {
        pin_lin <- pin_now$link
      }
      if(is.null(pin_now$board$name)) {
        pin_board_nam <- NA
      } else {
        pin_board_nam <- pin_now$board$name
      }
      if(is.null(pin_now$board$url)) {
        pin_board_ur <- NA
      } else {
        pin_board_ur <- pin_now$board$url
      }
      if(is.null(pin_now$board$id)) {
        pin_board_i <- NA
      } else {
        pin_board_i <- pin_now$board$id
      }
      if(is.null(pin_now$counts$likes)) {
        pins_like <- NA
      } else {
        pins_like <- pin_now$counts$likes
      }
      if(is.null(pin_now$counts$comments)) {
        pins_comment <- NA
      } else {
        pins_comment <- pin_now$counts$comments
      }
      if(is.null(pin_now$counts$repins)) {
        pins_repin <- NA
      } else {
        pins_repin <- pin_now$counts$repins
      }
      obj <- data.frame(pin_id = pin_i, creator_name = creator_nam, creator_id = creator_i, type = typ, original_link = original_lin, pin_note = pin_not, pin_color = pin_colo, pin_link = pin_lin, pin_board_name = pin_board_nam, pin_board_url = pin_board_ur, pin_board_id = pin_board_i, pins_likes = pins_like, pins_comments = pins_comment, pins_repins = pins_repin, attribution_title = attrtit, attribution_author = attraut, attribution_url = attrurl, attribution_provider = attrprov, stringsAsFactors = FALSE)
      identity <- rbind(identity, obj)
    }
    return(identity)
  } else {
    print("Request Error")
  }
}
