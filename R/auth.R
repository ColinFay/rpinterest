#' Create a Pinterest API token
#'
#' @param app the name of your app
#' @param app_id the ID of your app
#' @param app_secret the secret of the app
#' @param verbose wether of not to print a message about the auth process
#' @param callback the callback uri for your app
#'
#' @return an access token
#' @export
#'
#' @importFrom glue glue
#' @importFrom httr POST
#' @importFrom utils browseURL

pinterest_token <- function(app, app_id, app_secret, verbose = TRUE, 
                         callback = "https://colinfay.me/rpinterestcallback/"){
  
  # Warning the user
  if (verbose){
    message("R will open your web browser, and invite you to log into pinterest.")
    message("Once the login is done, you'll land on a page giving your a code.")
    message("Copy and paste the code from this page here.")
  }
  
  # Getting app_id & callback
  url <- glue::glue("https://api.pinterest.com/oauth/?response_type=code&redirect_uri={callback}&client_id={app_id}&scope=read_public,write_public&state=28111988")
  utils::browseURL(url)
  
  code <- readline("Paste the code here: ")
  
  # Posting the code, app_id and app_secret
  token <- httr::POST(glue::glue("https://api.pinterest.com/v1/oauth/token?grant_type=authorization_code&client_id={app_id}&client_secret={app_secret}&code={code}"))
  
  # Parsing the result
  json_raw_to_char(token$content)$access_token
}

