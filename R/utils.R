`%||%` <- function(a,b) if(is.null(a)) b else a

#' @importFrom attempt stop_if_not
#' @importFrom curl has_internet
check_internet <- function(){
  stop_if_not(.x = has_internet(), msg = "Please check your internet connexion")
}

#' @importFrom httr status_code
#' @importFrom attempt message_if_not

check_status <- function(res){
  message_if_not(.x = status_code(res), 
              .p = ~ .x == 200,
              msg = "The API returned an error")
  json_raw_to_char(res$content)
  stop()
}

#' @importFrom jsonlite fromJSON
json_raw_to_char <- function(content){
  fromJSON(rawToChar(content))
}

