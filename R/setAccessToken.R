#'Set Access Token
#'
#'Set your Pinterest Access Token 
#'
#'Takes a character string containing your access token.
#'@param token a character string with an access token generated at \url{https://developers.pinterest.com/tools/access_token/}.
#'@export
#'@examples
#'setAccessToken(token = "youraccesstoken")

setAccessToken <- function(token){
  options(token = token)
}
