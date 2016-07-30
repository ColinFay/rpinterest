#'Get pin using its ID
#'
#'Get informations about a pinterest pin using its ID.
#'
#'Takes a pin ID and an access token, returns a data.frame.
#'@param pinID a character string with a pin ID.
#'@param token a character string with an access token generated at \url{https://developers.pinterest.com/tools/access_token/}
#'@return Returns a data.frame with pin informations.
#'@export
#'@examples
#'PinSpecByID(pinID = "42080577745042298", token = token)

PinSpecByID <- function(pinID, token) {
  url <- paste0("https://api.pinterest.com/v1/pins/", pinID, "/?access_token=", token, "&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Cboard%2Ccounts%2Ccolor%2Ccreated_at%2Ccreator%2Cmedia%2Cimage%2Cmetadata%2Coriginal_link")
  pin <- httr::GET(url)
  if (pin$status_code == 200){
    content <- rjson::fromJSON(rawToChar(pin$content))
    content <- content$data
    if(is.null(content$attribution)) {
      attrtit <- NA
      attraut <- NA
      attrurl <- NA
      attrprov <- NA
    } else {
      attrtit <- content$attribution$title
      attraut <- content$attribution$author_name
      attrurl <- content$attribution$author_url
      attrprov <- content$attribution$provider_name
    }
    if(is.null(content$id)) {
      pin_i <- NA
    } else {
      pin_i <- content$id
    }
    if(is.null(content$creator$first_name)) {
      creator_nam <- NA
    } else {
      creator_nam <- paste0(content$creator$first_name, " ", content$creator$last_name)
    }
    if(is.null(content$creator$id)) {
      creator_i <- NA
    } else {
      creator_i <- content$creator$id
    }
    if(is.null(content$media$type)) {
      typ <- NA
    } else {
      typ <- content$media$type
    }
    if(is.null(content$original_link)) {
      original_lin <- NA
    } else {
      original_lin <- content$original_link
    }
    if(is.null(content$note)) {
      pin_not <- NA
    } else {
      pin_not <- content$note
    }
    if(is.null(content$color)) {
      pin_colo <- NA
    } else {
      pin_colo <- content$color
    }
    if(is.null(content$link)) {
      pin_lin <- NA
    } else {
      pin_lin <- content$link
    }
    if(is.null(content$board$name)) {
      pin_board_nam <- NA
    } else {
      pin_board_nam <- content$board$name
    }
    if(is.null(content$board$url)) {
      pin_board_ur <- NA
    } else {
      pin_board_ur <- content$board$url
    }
    if(is.null(content$board$id)) {
      pin_board_i <- NA
    } else {
      pin_board_i <- content$board$id
    }
    if(is.null(content$counts$likes)) {
      pins_like <- NA
    } else {
      pins_like <- content$counts$likes
    }
    if(is.null(content$counts$comments)) {
      pins_comment <- NA
    } else {
      pins_comment <- content$counts$comments
    }
    if(is.null(content$counts$repins)) {
      pins_repin <- NA
    } else {
      pins_repin <- content$counts$repins
    }
    identity <- data.frame(pin_id = pin_i, creator_name = creator_nam, creator_id = creator_i, type = typ, original_link = original_lin, pin_note = pin_not, pin_color = pin_colo, pin_link = pin_lin, pin_board_name = pin_board_nam, pin_board_url = pin_board_ur, pin_board_id = pin_board_i, pins_likes = pins_like, pins_comments = pins_comment, pins_repins = pins_repin, attribution_title = attrtit, attribution_author = attraut, attribution_url = attrurl, attribution_provider = attrprov)
    return(identity)
  } else {
    print("Request Error")
  }
}
