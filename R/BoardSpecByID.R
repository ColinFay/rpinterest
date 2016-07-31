#'Get board using its ID
#'
#'Get informations about a pinterest board using its ID.
#'
#'Takes a board ID and an access token, returns a data.frame.
#'@param boardID a character string with a board ID.
#'@param token a character string with an access token generated at \url{https://developers.pinterest.com/tools/access_token/}
#'@return Returns a data.frame with board specifications.
#'@export
#'@examples
#'BoardSpecByID(boardID = "42080646457333782", token = token)

BoardSpecByID <- function(boardID, token) {
  url <- paste0("https://api.pinterest.com/v1/boards/", boardID, "/?access_token=", token, "&fields=id%2Cname%2Curl%2Ccounts%2Ccreated_at%2Ccreator%2Cdescription%2Cimage%2Cprivacy%2Creason")
  board <- httr::GET(url)
  if (board$status_code == 200){
    content <- rjson::fromJSON(rawToChar(board$content))
    content <- content$data
    if(is.null(content$name)) {
      na <- NA
    } else {
      na <- content$name
    }
    if(is.null(content$id)) {
      bi <- NA
    } else {
      bi <- content$id
    }
    if(is.null(content$description)) {
      desc <- NA
    } else {
      desc <- content$description
    }
    if(is.null(content$creator$first_name)) {
      cn <- NA
    } else {
      cn <- paste0(content$creator$first_name, " ", content$creator$last_name)
    }
    if(is.null(content$creator$url)) {
      cu <- NA
    } else {
      cu <- content$creator$url
    }
    if(is.null(content$creator$id)) {
      cid <- NA
    } else {
      cid <- content$creator$id
    }
    if(is.null(content$created_at)) {
      created <- NA
    } else {
      created <- content$created_at
    }
    if(is.null(content$counts$pins)) {
      pc <- NA
    } else {
      pc <- content$counts$pins
    }
    if(is.null(content$counts$collaborators)) {
      colab <- NA
    } else {
      colab <- content$counts$pins
    }
    if(is.null(content$counts$followers)) {
      pfoll <- NA
    } else {
      pfoll <- content$counts$followers
    }
    identity <- data.frame(name = na, board_id = bi, board_desc = desc, creator_name = cn, creator_url = cu, creator_id = cid, created_at = created, pins_count = pc, pins_collaborators = colab, pins_followers = pfoll, stringsAsFactors = FALSE)
    return(identity)
  } else {
    print("Request Error")
  }
}
