#'Get a user using its name
#'
#'Get informations about a pinterest user using its ID.
#'
#'Takes a user ID and an access token, returns a data.frame.
#'@param user a character string with a user ID.
#'@param token a character string with an access token generated at \url{https://developers.pinterest.com/tools/access_token/}
#'@return Returns a data.frame with user informations.
#'@export
#'@examples
#'UserSpecByName(user = "colinfay", token = token)

UserSpecByName <- function(user, token) {
  . <- NULL 
  default <- data.frame(id = vector("character"), 
                        names = vector("character"),
                        bio = vector("character"), 
                        first_name = vector("character"), 
                        last_name = vector("character"), 
                        account_type = vector("character"),
                        url = vector("character"),
                        created_at = vector("character"),
                        pins = vector("character"),
                        following = vector("character"),
                        followers = vector("character"),
                        boards = vector("character"),
                        likes = vector("character"))
  url <- paste0("https://api.pinterest.com/v1/users/", user, "/?access_token=", token, "&fields=first_name%2Cid%2Clast_name%2Curl%2Caccount_type%2Cusername%2Cbio%2Ccounts%2Ccreated_at%2Cimage")
  user <- httr::GET(url)
  if (user$status_code == 200){
    content <- rjson::fromJSON(rawToChar(user$content))
    content <- content$data
    contentlist <- list()
    contentlist[[1]] <- content
    identity <- lapply(contentlist, function(obj) {
      data.frame(id = obj$id %||% NA, 
                 names = obj$username %||% NA,
                 bio = obj$bio %||% NA, 
                 first_name = obj$first_name %||% NA, 
                 last_name = obj$last_name %||% NA, 
                 account_type = obj$account_type %||% NA,
                 url = obj$url %||% NA,
                 created_at = obj$created_at %||% NA,
                 pins = obj$counts$pins %||% NA,
                 following = obj$counts$following %||% NA,
                 followers = obj$counts$followers %||% NA,
                 boards = obj$counts$boards %||% NA,
                 likes = obj$counts$likes %||% NA, 
                 stringsAsFactors = FALSE)
    }) %>% do.call(rbind, .)  
    return(identity)
  } else {
    warning("Request error (was ", user,")")
    identity <- default
    return(identity)
  }
}
