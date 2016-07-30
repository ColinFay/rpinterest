#'Get a user using its ID
#'
#'Get informations about a pinterest user using its ID.
#'
#'Takes a user ID and an access token, returns a data.frame.
#'@param user a character string with a user ID.
#'@param token a character string with an access token generated at \url{https://developers.pinterest.com/tools/access_token/}
#'@return Returns a data.frame with user informations.
#'@export
#'@examples
#'UserSpecByID(user = "42080715176677612", token = token)

UserSpecByID <- function(userID, token) {
  url <- paste0("https://api.pinterest.com/v1/users/", userID, "/?access_token=", token, "&fields=first_name%2Cid%2Clast_name%2Curl%2Caccount_type%2Cusername%2Cbio%2Ccounts%2Ccreated_at%2Cimage")
  user <- httr::GET(url)
  if (user$status_code == 200){
    content <- rjson::fromJSON(rawToChar(user$content))
    content <- content$data
    if(is.null(content$id)) {
      ci <- NA
    } else {
      ci <- content$id
    }
    if(is.null(content$username)) {
      userna <- NA
    } else {
      userna <- content$username
    }
    if(is.null(content$bio)) {
      bi <- NA
    } else {
      bi <- content$bio
    }
    if(is.null(content$first_name)) {
      nam <- NA
    } else {
      nam <- paste0(content$first_name, " ", content$last_name)
    }
    if(is.null(content$account_type)) {
      at <- NA
    } else {
      at <- content$account_type
    }
    if(is.null(content$url)) {
      cu <- NA
    } else {
      cu <- content$url
    }
    if(is.null(content$created_at)) {
      ca <- NA
    } else {
      ca <- content$created_at
    }
    if(is.null(content$counts$pins)) {
      cp <- NA
    } else {
      cp <- content$counts$pins
    }
    if(is.null(content$counts$following)) {
      fol <- NA
    } else {
      fol <- content$counts$following
    }
    if(is.null(content$counts$followers)) {
      folr <- NA
    } else {
      folr <- content$counts$followers
    }
    if(is.null(content$counts$boards)) {
      brd <- NA
    } else {
      brd <- content$counts$boards
    }
    if(is.null(content$counts$boards)) {
      brd <- NA
    } else {
      brd <- content$counts$boards
    }
    if(is.null(content$counts$likes)) {
      lk <- NA
    } else {
      lk <- content$counts$likes
    }
    identity <- data.frame(id = ci, name = userna, bio = bi, full_name = nam, account_type = at, url = cu, created_at = ca, pins = cp, following = fol, followers = folr, boards = brd, likes = lk)
    return(identity)
  } else {
    print("Request Error")
  }
}
